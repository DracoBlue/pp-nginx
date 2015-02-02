$domain_name = 'www-rewrite-server.example.org'
$server_config_file_name = "/tmp/pp-nginx-results/${domain_name}.conf"

nginx::templates::www_rewrite_http_server { $domain_name:
  server_name => "test.${domain_name}",
  server_config_file_name => $server_config_file_name,
}

