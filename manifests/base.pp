class nginx::base (
  $service = 'nginx'
) {
  if defined(Nginx::Service[$service]) {
    File {
      notify => Nginx::Service[$service]
    }
  }
}
