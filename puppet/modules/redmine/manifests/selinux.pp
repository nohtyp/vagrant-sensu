class redmine::selinux inherits params {

  exec { 'turn off selinux':
    path     => ['/sbin', '/bin'],
    command  => 'setenforce 0',
    unless   => "sestatus |grep 'Current mode' |grep 'permissive'"
  }
}
