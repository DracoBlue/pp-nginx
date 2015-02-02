# Adds a new `server` in a file called `/etc/nginx/conf.d/$name.conf`.
define nginx::server (
  $ensure = present,
  $server_config_header_template = 'nginx/conf.d/server_header.conf.erb',
  $server_config_footer_template = 'nginx/conf.d/server_footer.conf.erb',
  $server_config_file_name = "/etc/nginx/conf.d/${name}.conf",
  $server_config_owner = 'root',
  $server_config_group = 'root',
  $server_config_mode = '0644',
  $content = '',
  $indention = '    ',
) {
  if $ensure == present {
    concat { $server_config_file_name:
      owner => $server_config_owner,
      group => $server_config_group,
      mode => $server_config_mode,
      order => 'alpha',
    }

    if defined(Service['nginx']) {
      Concat[$server_config_file_name] {
        notify => Service['nginx']
      }
    }

    concat::fragment{ "${server_config_file_name}_header":
      target => $server_config_file_name,
      content => regsubst(template($server_config_header_template), '^(.*)$', '\1', 'G'),
      order => '001+'
    }

    if $content != '' {
      $content_with_indention = regsubst(
        $content,
        '^(.*)$',
        "${indention}\\1",
        'G'
      )

      concat::fragment{ "${server_config_file_name}_body":
        ensure => $ensure,
        target => $server_config_file_name,
        content => "\n${content_with_indention}",
        order => '025+',
      }
    }

    concat::fragment{ "${server_config_file_name}_footer":
      target => $server_config_file_name,
      content => regsubst(template($server_config_footer_template), '^(.*)$', '\1', 'G'),
      order => '999+'
    }
  } else {
    file { $server_config_file_name:
      ensure => absent
    }
  }
}
