case node['platform']
when "ubuntu"
  default['modules'] = %w(lp rtc)
end
