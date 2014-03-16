define nginx::server::location::alias (
  $ensure                       = present,
  $server                       = undef,
  $location_alias               = undef,
  $location                     = $name,
  $location_config_template     = "nginx/conf.d/location.conf.erb",
  $order                        = 50,
  $content                      = undef
) {
  $alias_content = "        alias ${location_alias};"

  if $content == undef {
    $expanded_content = "${alias_content}"
  } else {
    $expanded_content = "${alias_content}
${content}"
  }

  nginx::server::location { "${server}_location_rewrite_${name}":
    ensure => $ensure,
    content => $expanded_content,
    location_config_template => $location_config_template,
    location => $location,
    server => $server,
    order => $order,
  }
}
