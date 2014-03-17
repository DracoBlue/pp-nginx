#
# This is ONLY used by the other location::* types. Please do not invoke it directly!
#
define nginx::server::location::fragment (
  $server = undef,
  $location	= undef,
  $content = undef,
  $ensure = present,
  $order = undef,
) {
  validate_string($server)
  validate_string($location)
  validate_string($content)
  validate_string($order)

  $server_config_file_name = getparam(Nginx::Server[$server], "server_config_file_name")
  $location_order = getparam(Nginx::Server::Location[$location], "order")

  if $content != "" {
    concat::fragment{ "${server_config_file_name}_location_${name}":
      ensure => $ensure,
      target => $server_config_file_name,
      content => $content,
      order => "$location_order+$order",
    }
  }
}
