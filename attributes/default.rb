default['modules']['default'] = {}
default['modules']['init'] = value_for_platform(
  ['centos', 'redhat'] => {
    '~> 6.0' => 'upstart',
    '~> 7.0' => 'systemd'
  },
  'fedora' => {
    '>= 20.0' => 'systemd'
  },
  'debian' => {
    '~> 8.0' => 'systemd'
  },
  'default' => 'upstart')
default['modules']['packages'] = value_for_platform(
  'debian' => {
    'default' => ['kmod']
  },
  'ubuntu' => {
    'default' => ['kmod'],
    '>= 10.04' => ['module-init-tools'],
  },
  ['centos', 'redhat'] => {
    '~> 7.0' => ['kmod']
  },
  'fedora' => {
    '>= 20.0' => ['kmod']
  },
  'default' => []
)
