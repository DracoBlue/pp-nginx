# Is loaded by the `nginx` class, to ensure that the nginx service control is
# available
class nginx::service (
  $ensure = running,
  $enable = true
) {
  service { 'nginx':
    ensure => $ensure,
    enable => $enable,
    hasstatus => true,
    hasrestart => true
  }
}
