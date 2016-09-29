class haproxy::selinux inherits params {
  
  exec { 'Stop selinux before haproxy runs':
    path     => '/sbin/',
    command  => 'setenforce 0',
    require  => Package['haproxy'],
  }
}
