class redmine::selinux inherits params {

  exec { 'turn off selinux':
    path  => ['/sbin'],
    command => 'setenforce 0',
  }
}
