class redmine::database::database inherits params {

  pgdb { 'Creating database':
    ensure    => "${database_ensure}",
    runas     => "${database_runas}",
    database  => "${database_name}",
    owner     => "${database_owner}",
  }
}
