class redmine::web::passengersvc inherits params {

  exec {'Creating passenger binary ':
    path    => ['/bin', '/usr/local/bin'],
    command => 'passenger-install-apache2-module -a',
    timeout => 1800,
    unless  => [ "test -f /usr/local/share/gems/gems/$passenger_version/buildout/apache2/mod_passenger.so"],
  }
}
