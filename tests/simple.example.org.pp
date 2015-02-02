$domain_name = 'simple.example.org'
$server_config_file_name = "/tmp/pp-nginx-results/${domain_name}.conf"

nginx::server { $domain_name:
  ensure => present,
  server_config_file_name => $server_config_file_name,
  content => "listen                *:80;
server_name           ${domain_name};
access_log            /var/log/nginx/simple.example.org.access.log;
error_log             /var/log/nginx/simple.example.org.error.log;"
}
