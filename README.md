# pp-nginx

A very slim nginx module for puppet.

* Latest Release: [![GitHub version](https://badge.fury.io/gh/DracoBlue%2Fpp-nginx.png)](https://github.com/DracoBlue/pp-nginx/releases)
* Build-Status: [![Build Status](https://travis-ci.org/DracoBlue/pp-nginx.png?branch=master)](https://travis-ci.org/DracoBlue/pp-nginx)
* Official Site: http://dracoblue.net/

pp-ningx is copyright 2014 by DracoBlue http://dracoblue.net

# Installation

Latest version from puppet forge:

``` console
$ puppet module install DracoBlue-nginx
```

Latest version from git.

``` console
$ cd modules
$ git clone https://github.com/DracoBlue/pp-nginx.git nginx
```

# Usage

## Example

``` ruby
# include package and server for nginx
include nginx

$server = "example.org"

# define new server (/vhost)
nginx::server { $server:
  content => "
    listen *:80;
    server_name $server;
"
}

# define a location

nginx::server::location { "assets":
  location => "~ ^/",
  server => $server,
  content => "
        root /var/www/assets/;
  "
}
```

Result (`/etc/nginx/example.org.conf`):

```
server {

    listen *:80;
    server_name example.org;

    location ~ ^/ {

        root /var/www/assets/;

    }
}
```

## Classes

There are only 3 classes in this puppet module.

* public:
  * `include nginx`: makes sure that `nginx::package` and `nginx::service` is available 
* private
  * `include nginx::package`: is loaded by the `nginx` class, to ensure that the nginx package is available on the operating system
  * `include nginx::service`: is loaded by the `nginx` class, to ensure that the nginx service control is available
  * `include nginx::base`: is used by `nginx::location` and `nginx::server` to ensure that the server is reloaded on file changes

## Types

See the Example at the beginning for explanation how the `nginx::server` and `nginx::location` type work.

# Run tests

``` console
$ make test
```

Hint: The tests will need sudo rights and will write into /tmp/pp-nginx-results. Every other file should not be affected.

# License

pp-nginx is licensed under the terms of MIT.
