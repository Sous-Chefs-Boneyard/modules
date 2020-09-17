default['modules']['default']['modules'] = %w(lp rtc) if platform?('ubuntu')

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
