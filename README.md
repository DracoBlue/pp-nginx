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

Result (`/etc/nginx/conf.d/example.org.conf`):

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

See the Example at the beginning for explanation how the `nginx::server` and `nginx::location` type work together.

### `nginx::server`

Adds a new `server` in a file called `/etc/nginx/conf.d/$name.conf`.

``` ruby
nginx::server { "example.org":
  server => 'example.org',
  content => "
    listen *:80;
    server_name example.org;
"
}
```

See `tests/simple.example.org.pp` for more examples.

### `nginx::server::location`

Adds a `location` block definition to the given `$server`.

``` ruby
nginx::server::location { "assets":
  server => 'example.org',
  location => '~ ^/assets/(.+)',
  content => "
      root /var/www;
"
}
```

See `tests/simple-locations.example.org.pp` for more examples.

### `nginx::server::location::alias`

Adds a `alias` definition to map to a `$local_directory` for to the given `$location` in the specified `$server`.

``` ruby
nginx::server::location::alias { "assets-directory":
  server => 'example.org',
  location => 'assets',
  local_directory => '/var/www/assets/$1'
}
```

See `tests/alias-location.example.org.pp` for more examples.

# Run tests

``` console
$ make test
```

Hint: The tests will need sudo rights and will write into /tmp/pp-nginx-results. Every other file should not be affected.

# Changelog

* dev
  - travis now tests multiple puppet versions #5
  - `nginx::server::location::alias` adds the alias definition, to the nginx location specified #3
* 1.0.0 (2014/03/16)
  - Initial release

# License

pp-nginx is licensed under the terms of MIT.
