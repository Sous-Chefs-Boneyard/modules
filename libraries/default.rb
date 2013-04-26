def supported?
  case node['platform']
  when "ubuntu"
    # only work with upstart, so >= 9.10
    major, minor = node['platform_version'].split(".")
    if Integer(major) > 9 || (Integer(major) == 9 && Integer(minor) >= 10)
      return true
    else
      return false
    end
  else
    Chef::log.info("Your platform isn't manage to save module changes")
    return false
  end
end
