class redmine::db_service inherits params {

  service { 'Starting database':
    ensure     => running,
    name       => 'postgresql',
    hasstatus  => true,
    hasrestart => true,
  }
}
