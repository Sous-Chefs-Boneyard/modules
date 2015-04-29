default['modules']['default'] = {}
Chef::Log.info node.platform + " " + node.platform_version
default['modules']['init'] = value_for_platform(
  'centos' => {
    '~> 6.0' => 'upstart',
    '~> 7.0' => 'systemd'
  },
  'fedora' => {
    '>= 20.0' => 'systemd'
  },
  'default' => 'upstart')
default['modules']['packages'] = value_for_platform(
  #'debian' => value_for_platform(
  #  'ubuntu' => {
  #    'default' => ['kmod'],
  #    ['10.04', '12.04', '12.10'] => ['module-init-tools'],
  #  },
  #  'default' => ['kmod']
  #),
  'centos' => {
    '~> 7.0' => ['kmod']
  },
  'fedora' => {
    '>= 20.0' => ['kmod']
  },
  'default' => []
)
