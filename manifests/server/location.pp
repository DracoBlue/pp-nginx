# Adds a `location` block definition to the given `$server`.
define nginx::server::location (
  $content = '',
  $location = $name,

  $ensure = present,
  $server = undef,
  $location_config_header_template = 'nginx/conf.d/location_header.conf.erb',
  $location_config_footer_template = 'nginx/conf.d/location_footer.conf.erb',
  $order = "050+${name}",
  $indention = '    ',
) {
  if $server == undef {
    fail('Please provide a $server for this location')
  }

  if is_string($server) {
    fail('Please provide a Nginx::Server as $server for this location')
  }

  $server_config_file_name = getparam($server, 'server_config_file_name')

  if $server_config_file_name == '' {
    fail('The given $server does not contain a server_config_file_name')
  }

  $server_indention = getparam($server, 'indention')

  $header_with_indention = regsubst(
    template($location_config_header_template),
    '^(.*)$',
    "${server_indention}\\1",
    'G'
  )

  concat::fragment{ "${server_config_file_name}_location_${name}_header":
    ensure => $ensure,
    target => $server_config_file_name,
    content => "\n\n${header_with_indention}",
    order => "${order}+001",
  }

  if $content != '' {
    $content_with_indention = regsubst(
      $content,
      '^(.*)$',
      "${server_indention}${indention}\\1",
      'G'
    )

    concat::fragment{ "${server_config_file_name}_location_${name}_body":
      ensure => $ensure,
      target => $server_config_file_name,
      content => "\n${content_with_indention}",
      order => "${order}+090",
    }
  }

  $footer_with_indention = regsubst(
    template($location_config_footer_template),
    '^(.*)$',
    "${server_indention}\\1",
    'G'
  )
  concat::fragment{ "${server_config_file_name}_location_${name}_footer":
    ensure => $ensure,
    target => $server_config_file_name,
    content => "\n${footer_with_indention}",
    order => "${order}+099",
  }

}
