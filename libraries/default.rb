def supported?
  if platform?('ubuntu')
    # only work with upstart
    Gem::Version.new(node['platform_version']) >= Gem::Version.new('9.10')
  else
    Chef::Log.info("Your platform isn't manage to save module changes")
    false
  end
end

def module_init_service
  if (Gem::Version.new(node['platform_version']) > Gem::Version.new('12.04')) ||
     (platform?('debian') && (Gem::Version.new(node['platform_version']) >= Gem::Version.new('7.0')))
    'kmod'
  else
    'module-init-tools'
  end
end
