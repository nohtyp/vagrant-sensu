class redmine::db_initialize inherits params {

  exec { 'Initializing the database':
    path  => ['/bin'],
    command  => 'initdb /var/lib/pgsql/data',
    user     => 'postgres',
  }
}
