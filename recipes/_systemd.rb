%w[module-init-tools modules-load].each do |f|

  cookbook_file "/usr/local/bin/#{f}.sh" do
    mode 0770
    owner "root"
    group "root"
  end

  cookbook_file "/etc/systemd/system/#{f}.service" do
    mode 0644
    owner "root"
    group "root"
    source "#{f}.systemd"
  end
end

# This is a symlink to /etc/modules which breaks the modules-load script. Delete
# this symlink on Debian.
file '/etc/modules-load.d/modules.conf' do
  action :delete
  backup false
  only_if { platform?('debian') }
end

service "module-init-tools" do
  provider Chef::Provider::Service::Systemd
  action [:enable, :start]
end

service "modules-load" do
  provider Chef::Provider::Service::Systemd
  action [:enable, :start]
  notifies :restart, "service[module-init-tools]", :immediately
end

template '/etc/modules-load.d/chef-default.conf' do
  source 'modules.conf.erb'
  mode '0644'
  owner 'root'
  group 'root'
  variables(
    :modules => node['modules']['default']['modules']
  )
  notifies :restart, 'service[modules-load]', :immediately
  only_if { node['modules']['default']['modules'] }
end
