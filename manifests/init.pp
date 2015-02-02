# makes sure that `nginx::package` and `nginx::service` is available
class nginx ($ensure = present) {
  class { 'nginx::package':
    ensure => $ensure
  }
  if $ensure == absent {
    class { 'nginx::service':
      ensure => stopped
    }
  } else {
    class { 'nginx::service':
      ensure => running
    }
  }
}
