class redmine::db_install inherits params {

  package { 'Installing database':
    ensure     => present,
    name       => 'postgresql-server',
  }
}
