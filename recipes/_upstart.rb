cookbook_file '/etc/init/modules-load.conf' do
  source 'modules-load.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

if node['platform'] == 'centos'
  cookbook_file '/etc/init/module-init-tools.conf' do
    source 'module-init-tools.conf'
    owner 'root'
    group 'root'
    mode '0644'
  end
end

service 'modules-load' do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
  notifies :restart, 'service[module-init-tools]'
end

service 'module-init-tools' do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
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

