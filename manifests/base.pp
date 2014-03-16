class nginx::base (
  $service = 'nginx'
) {
  if defined('nginx::service') {
    File {
      notify => Class['nginx::service']
    }
  }
}
