unified_mode true

property :module, String, name_property: true
property :options, Hash
property :path, String

action :save do
  include_recipe 'modules::config'

  file path do
    content new_resource.module + serialize_options
    owner 'root'
    group 'root'
    mode '0644'
    only_if { supported? }
  end
  run_action :load
end

action :load do
  execute "load module #{new_resource.module}" do
    command "modprobe #{new_resource.module} #{serialize_options}"
    not_if { mod_loaded?(new_resource.module) }
  end
end

action :remove do
  file path do
    action :delete
  end
  execute 'unload module' do
    command "modprobe -r #{new_resource.module}"
  end
end

action_class do
  def path
    new_resource.path || "/etc/modules-load.d/#{new_resource.name}.conf"
  end

  def serialize_options
    output = ''
    if new_resource.options
      new_resource.options.each do |option, value|
        output << ' ' + option + '=' + value
      end
    end
    output
  end

  def mod_loaded?(mod)
    cmd = "lsmod | grep -q #{mod}"
    shell_out(cmd).status == 0
  end
end
