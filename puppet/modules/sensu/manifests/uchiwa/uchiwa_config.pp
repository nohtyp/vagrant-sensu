class sensu::uchiwa::uchiwa_config inherits sensu {
  
  file {'uchiwa config':
   ensure  => present,
   mode     => '0644',
   owner    => 'sensu',
   group    => 'sensu',
   path    => $::sensu::sensu_uchiwa_path,
   require => Package[$::sensu::sensu_package],
   content => template('sensu/uchiwa_config.erb'),
  }
}
