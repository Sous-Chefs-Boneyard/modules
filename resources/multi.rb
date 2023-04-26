unified_mode true

property :modules, Array, required: true
property :path, String

action :save do
  include_recipe 'modules::config'

  template new_resource.path do
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
  file new_resource.path do
    action :delete
  end

  new_resource.modules.each do |name|
    execute 'unload module' do
      command "modprobe -r #{name}"
    end
  end
end
