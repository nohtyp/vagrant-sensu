class postgresql::dbusers inherits params {

  pguser { 'Creating database user account':
    ensure    => present,
    username  => 'tet',
    #runas     => 'postgres',
    password  => 'test',
    super_user => true,
    }
}
