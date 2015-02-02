# Adds `allow` and `deny` definitions to a given `$location`.
define nginx::server::location::access (
  $allow = [],
  $deny = [],
  $content = undef,
  $config_template = 'nginx/conf.d/location/access.conf.erb',

  $location = undef,
  $ensure = present,
  $order = '050',
) {
  validate_array($allow)
  validate_array($deny)

  nginx::server::location::fragment { "access_${name}":
    ensure => $ensure,
    content => template($config_template),

    location => $location,
    order => $order,
  }
}
