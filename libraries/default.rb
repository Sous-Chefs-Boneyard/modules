def supported?
  case node['platform']
  when 'ubuntu'
    # only work with upstart
    if Gem::Version.new(node['platform_version']) >= Gem::Version.new('9.10')
      return true
    else
      return false
    end
  when 'debian'
    # only work with systemd
    if Gem::Version.new(node['platform_version']) >= Gem::Version.new('8.0')
      return true
    else
      return false
    end
  when 'centos'
    # only work with upstart
    if Gem::Version.new(node['platform_version']) >= Gem::Version.new('6.0')
      return true
    else
      return false
    end
  when 'fedora'
    return true
  else
    Chef::Log.info("Your platform isn't manage to save module changes")
    return false
  end
end
