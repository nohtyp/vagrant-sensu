class redmine::web::passenger inherits params {

  file {'Creating passenger file':
    ensure  => file,
    path    => '/etc/httpd/conf.d/passenger.conf',
    content => template('redmine/passenger.erb')
  }
}
