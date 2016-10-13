class httpd::passenger inherits params {

  file {'Creating passenger file':
    ensure  => file,
    path    => '/etc/httpd/conf.d/passenger.conf',
    content => template('httpd/passenger.erb')
  }
}
