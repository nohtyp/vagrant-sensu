class sensu::sensu_repo inherits sensu {

  yumrepo {'Sensu repo':
    ensure    => present,
    descr     => 'Sensu repository for monitoring systems',
    name      => 'sensu',
    baseurl   => $sensu_base_url,
    gpgcheck  => '0',
    enabled   => '1',
  }
  yumrepo {'EPEL repo':
    ensure    => present,
    descr     => 'epel repository',
    name      => 'epel',
    baseurl   => $epel_url,
    gpgcheck  => '0',
    enabled   => '1',
  }

}
