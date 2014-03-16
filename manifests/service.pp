define nginx::service (
  $ensure = running,
  $enable = true,
  $hasstatus = true,
  $hasrestart = true
) {
  service { 'nginx':
    ensure => $ensure,
    enable => $enable,
    hasstatus => $hasstatus,
    hasrestart => $hasrestart
  }
}
