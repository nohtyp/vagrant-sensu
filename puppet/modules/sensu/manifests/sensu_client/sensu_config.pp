class sensu::sensu_client::sensu_config inherits sensu {
  
  file { "${sensu_config_path}":
   ensure  => present,
   mode     => '0644',
   owner    => 'sensu',
   group    => 'sensu',
   path    => $::sensu::sensu_config_path,
   #require => Package[$::sensu::sensu_client_package],
   content => template('sensu/sensu_client_config.erb'),
  }
  
  file { "${sensu_client_path}":
   ensure   => present,
   mode     => '0644',
   owner    => 'sensu',
   group    => 'sensu',
   path     => $::sensu::sensu_client_path,
   #require => Package[$::sensu::sensu_client_package],
   content => template('sensu/sensu_client.erb'),
  }
}
