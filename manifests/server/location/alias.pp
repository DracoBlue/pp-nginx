define nginx::server::location::alias (
  $ensure                       = present,
  $server                       = undef,
  $location			= undef,
  $local_directory              = undef,
  $order                        = "050",
  $content                      = undef
) {
  $server_config_file_name = getparam(Nginx::Server[$server], "server_config_file_name")
  $location_order = getparam(Nginx::Server::Location[$location], "order")

  $alias_content = "        alias ${local_directory};
"

  if $content == undef {
    $expanded_content = "${alias_content}"
  } else {
    $expanded_content = "${alias_content}
${content}"
  }

  concat::fragment{ "${server_config_file_name}_location_alias_${name}":
    ensure  => $ensure,
    target  => $server_config_file_name,
    content => $expanded_content,
    order   => "$location_order+$order",
  }
}
