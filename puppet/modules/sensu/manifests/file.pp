class sensu::file inherits params {
  
  file {'uchiwa file':
   ensure  => present,
   path    => '/etc/sensu/uchiwa.json',
   source   => "puppet:///modules/sensu/uchiwa.json",
   mode     => '0644',
   owner    => 'root',
   group    => 'root',
  }

  file {'config file':
   ensure  => present,
   path    => '/etc/sensu/config.json',
   source   => "puppet:///modules/sensu/config.json",
   mode     => '0644',
   owner    => 'root',
   group    => 'root',
  }
}
