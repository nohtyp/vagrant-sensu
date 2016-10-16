class redmine::web::passenger inherits params {

  file {'Creating passenger file':
    ensure  => file,
    path    => "${passenger_conf}",
    content => template('redmine/passenger.erb')
  }
}
