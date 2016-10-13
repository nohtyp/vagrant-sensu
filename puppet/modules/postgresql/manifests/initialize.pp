class postgresql::initialize inherits params {

  exec { 'Initializing the database':
    path     => $postgresql_path,
    command  => 'initdb /var/lib/pgsql/data',
    user     => $postgresql_init_user,
    unless   => 'test -f /var/lib/pgsql/data/pg_hba.conf'
  }
}
