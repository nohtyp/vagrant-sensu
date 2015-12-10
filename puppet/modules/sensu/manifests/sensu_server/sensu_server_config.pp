class sensu::sensu_server::sensu_server_config inherits sensu {
  
  file {'sensu server config':
   ensure  => present,
   mode     => '0644',
   owner    => 'sensu',
   group    => 'sensu',
   path    => $::sensu::sensu_config_path,
   #require => Package[$::sensu::sensu_package],
   content => template('sensu/sensu_server_config.erb'),
  }
}
