class redmine::web::passengersvc inherits params {

  exec {'Creating passenger binary ':
    path    => ['/bin', '/usr/local/bin'],
    command => 'passenger-install-apache2-module -a',
    timeout => 1800,
  }
}
