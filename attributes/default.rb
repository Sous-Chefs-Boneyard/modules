case node[:platform]
  when "ubuntu"
    default[:modules][:lp][:options] = nil
    default[:modules][:rtc][:options] = nil
end
