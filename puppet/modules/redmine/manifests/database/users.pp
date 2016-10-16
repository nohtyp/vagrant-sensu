class redmine::database::users inherits params {

  pguser { 'Creating database user account':
    ensure     => "${postgresql_user_ensure}",
    username   => "${postgresql_user}",
    password   => "${postgresql_user_pw}",
    }
}
