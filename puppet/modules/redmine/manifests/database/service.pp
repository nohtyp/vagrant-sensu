class redmine::database::service inherits params {

  service { 'Starting database':
    ensure     => "${postgresql_ensure}",
    name       => "${postgresql_service}",
    hasstatus  => "${postgresql_hasstatus}",
    hasrestart => "${postgresql_hasrestart}",
  }
}
