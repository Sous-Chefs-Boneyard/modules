def supported?
  case node['platform']
  when 'ubuntu'
    # only work with upstart
    Chef::VersionConstraint::Platform.new('>= 9.10').include? node['platform_version']
  when 'debian'
    # only work with systemd
    Chef::VersionConstraint::Platform.new('>= 8.0').include? node['platform_version']
  when 'centos'
    # only work with upstart
    Chef::VersionConstraint::Platform.new('>= 6.0').include? node['platform_version']
  when 'fedora'
    return true
  else
    Chef::Log.info("Your platform isn't manage to save module changes")
    return false
  end
end
