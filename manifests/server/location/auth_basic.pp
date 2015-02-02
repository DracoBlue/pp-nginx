# Adds `auth_basic` and `auth_basic_user_file` definitions to a given
# `$location`.
define nginx::server::location::auth_basic (
  $text = undef,
  $user_file = undef,
  $content = undef,
  $config_template = 'nginx/conf.d/location/auth-basic.conf.erb',

  $ensure = present,
  $location = undef,
  $order = '050',
) {
  validate_string($text)
  validate_absolute_path($user_file)

  nginx::server::location::fragment { "auth-basic_${name}":
    ensure => $ensure,
    content => template($config_template),

    location => $location,
    order => $order,
  }
}
