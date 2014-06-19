default['modules']['default'] = {}
default['modules']['packages'] = value_for_platform_family(
  'debian' => value_for_platform(
    'ubuntu' => {
      'default' => ['kmod'],
      ['10.04', '12.04', '12.10'] => ['module-init-tools'],
    },
    'default' => ['kmod']
  ),
  'centos' => {
    '6.0' => ['module-init-tools']
  },
  'default' => []
)
