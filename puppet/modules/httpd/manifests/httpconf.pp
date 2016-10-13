class httpd::httpconf inherits params {

  file {'Configure httpd.conf file':
    ensure    => present,
    path      => '/etc/httpd/conf/httpd.conf',
    content   => template('httpd/httpdconf.erb'),
  }
}
