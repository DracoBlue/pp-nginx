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
