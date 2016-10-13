class redmine::users inherits params {

  group { 'redmine':
    ensure => 'present',
    gid    => '1002',
    members => [ 'apache' ],
  }

  user { 'redmine':
    ensure           => 'present',
    gid              => '1002',
    home             => '/home/redmine',
    password         => '$6$J1FNU3u2$cRX3YTr4YDbU.lDyDuLwnt37bs0bsFpglV5o5V7G2hNQPNq55dBk/YUiqs4ksek/N51ZJsfPHD4zRsxzr1B591',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    uid              => '1001',
    managehome       => true,
   }
}
