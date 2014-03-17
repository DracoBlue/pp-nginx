$domain_name = "access-location.example.org"
$server_config_file_name = "/tmp/pp-nginx-results/$domain_name.conf"

nginx::server { $domain_name:
  ensure => present,
  server_config_file_name => $server_config_file_name,
  content => "
    listen                *:80;

    server_name           $domain_name;
  "
}

nginx::server::location { "with-content":
  location => "~ /first/",
  server => $domain_name,
  content => "
        index index.html;
"
}

nginx::server::location::access { "access-with-content":
  server => $domain_name,
  location => "with-content",
  allow => ['all', '127.0.0.1'],
  deny => ['all', '127.0.0.1'],
}

nginx::server::location { "without-content":
  location => "~ /second/",
  server => $domain_name,
}

nginx::server::location::access { "access-without-content":
  location => "without-content",
  server => $domain_name,
  allow => ['all', '127.0.0.1'],
  deny => ['all', '127.0.0.1'],
}

nginx::server::location { "without-deny":
  location => "~ /third/",
  server => $domain_name,
}

nginx::server::location::access { "access-without-deny":
  location => "without-deny",
  server => $domain_name,
  allow => ['all', '127.0.0.1']
}

nginx::server::location { "without-allow":
  location => "~ /fourth/",
  server => $domain_name,
}

nginx::server::location::access { "access-without-allow":
  location => "without-allow",
  server => $domain_name,
  deny => ['all', '127.0.0.1']
}