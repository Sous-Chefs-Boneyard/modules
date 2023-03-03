unified_mode true

property :path, String, default: "/etc/modules-load.d/#{new_resource.name}.conf"
property :modules, Array, required: true

action :save do
  include_recipe 'modules::config'

  template path do
    source 'modules.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      modules: new_resource.modules
    )
    notifies :start, 'service[modules-load]'
    only_if { supported? }
  end
end

action :remove do
  file path do
    action :delete
  end

  new_resource.modules.each do |name|
    execute 'unload module' do
      command "modprobe -r #{name}"
    end
  end
end
