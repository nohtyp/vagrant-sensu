class postgresql::database inherits params {

  pgdb { 'Creating database':
    ensure    => present,
    runas     => 'postgres',
    database  => 'redmine',
    owner     => 'redmine',
  }
}
