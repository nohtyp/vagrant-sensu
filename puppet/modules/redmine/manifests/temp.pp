class redmine::temp inherits params {

  exec { 'stopping firewalld':
    path  => ['/bin'],
    command => 'systemctl stop firewalld',
  }

  exec { 'turn off selinux':
    path  => ['/sbin'],
    command => 'setenforce 0',
  }
}
