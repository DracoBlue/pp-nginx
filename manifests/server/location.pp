define nginx::server::location (
  $ensure                       = 'present',
  $server                       = undef,
  $location                     = $name,
  $location_config_template     = "nginx/conf.d/location.conf.erb",
  $order                        = 50,
  $content                      = ""
) {
  $server_config_file_name = getparam(Nginx::Server[$server], "server_config_file_name")

  concat::fragment{ "${server_config_file_name}_location_${name}":
    ensure  => $ensure,
    target  => $server_config_file_name,
    content => template($location_config_template),
    order   => $order,
  }
}
