# Is loaded by the `nginx` class, to ensure that the nginx package is
# available on the operating system
class nginx::package (
  $ensure = present
) {
  case $::osfamily {
    'debian': {
      package{ 'nginx':
        ensure => $ensure
      }
    }
    default: {
      case $::operatingsystem {
        'Gentoo': {
          package{ 'www-servers/nginx':
            ensure => $ensure
          }
        }
        default: {
          fail("The type nginx::package is not support on ${::operatingsystem} (os family: ${::osfamily}.")
        }
      }
    }
  }
  
}
