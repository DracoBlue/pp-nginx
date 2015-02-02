# Redirect a given domain from `www.example.org` to `example.org` with an own
# nginx server entry.
define nginx::templates::www_rewrite_http_server (
  $server_name = $title,
  # inherited from nginx::server
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
  if ($content)
  {
    $content_with_newline = "
${content}"
  }
  else
  {
    $content_with_newline = ''
  }
  nginx::server { $title:
    ensure   => $ensure,
    content => "listen 80;
server_name www.${server_name};
rewrite ^(.*) http://${server_name}\$1 permanent;${content_with_newline}",
    server_config_header_template => $server_config_header_template,
    server_config_footer_template => $server_config_footer_template,
    server_config_file_name => $server_config_file_name,
    server_config_owner => $server_config_owner,
    server_config_group => $server_config_group,
    server_config_mode => $server_config_mode,
    indention => $indention,
  }
}