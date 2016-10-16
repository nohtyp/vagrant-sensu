class redmine::web::httpconf inherits params {

  file {'Configure httpd.conf file':
    ensure    => present,
    path      => "${http_conf}",
    content   => template('redmine/httpdconf.erb'),
  }
}
