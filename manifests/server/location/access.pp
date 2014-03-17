define nginx::server::location::access (
  $server                       = undef,
  $location			            = undef,

  $allow                        = [],
  $deny                         = [],
  $content                      = undef,

  $ensure                       = present,
  $order                        = "050",
  $config_template              = "nginx/conf.d/location/access.conf.erb",
) {
  $server_config_file_name = getparam(Nginx::Server[$server], "server_config_file_name")
  $location_order = getparam(Nginx::Server::Location[$location], "order")

  validate_array($allow)
  validate_array($deny)

  $file_content = template($config_template)

  if $file_content != "" {
    concat::fragment{ "${server_config_file_name}_location_access_${name}":
      ensure  => $ensure,
      target  => $server_config_file_name,
      content => $file_content,
      order   => "$location_order+$order",
    }
  }
}
