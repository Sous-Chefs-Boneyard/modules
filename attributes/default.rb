case node['platform']
when "ubuntu"
  default['modules']['lp']
  default['modules']['rtc']
end
