class redmine::users inherits params {

  group { 'redmine':
    ensure => 'present',
    gid    => $redmine_groupid,
    members => [ 'apache' ],
  }

  user { 'redmine':
    ensure           => 'present',
    gid              => $redmine_groupid,
    home             => $redmine_userhome,
    password         => '$6$J1FNU3u2$cRX3YTr4YDbU.lDyDuLwnt37bs0bsFpglV5o5V7G2hNQPNq55dBk/YUiqs4ksek/N51ZJsfPHD4zRsxzr1B591',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => $redmine_usershell,
    uid              => $redmine_userid,
    managehome       => true,
    require          => Group['redmine'],
   }
}
