case node['platform']
when 'ubuntu'
  default['modules']['default']['modules'] = ['lp', 'rtc']
  default['modules']['service']['module-init-tools'] = 'service[module-init-tools]'
  default['modules']['service']['modules-load'] = 'service[modules-load]'

when 'debian'
  default['modules']['default']['modules'] = []
  default['modules']['service']['modules-load'] = 'service[kmod]'
end

default['modules']['packages'] = value_for_platform_family(
  'debian' => value_for_platform(
    'ubuntu' => {
      'default' => ['kmod'],
      ['10.04', '12.04', '12.10'] => ['module-init-tools'],
    },
    'default' => ['kmod']
  ),
  'default' => []
)

