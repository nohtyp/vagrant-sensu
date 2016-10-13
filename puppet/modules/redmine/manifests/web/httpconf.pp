class redmine::web::httpconf inherits params {

  file {'Configure httpd.conf file':
    ensure    => present,
    path      => '/etc/httpd/conf/httpd.conf',
    content   => template('redmine/httpdconf.erb'),
  }
}
