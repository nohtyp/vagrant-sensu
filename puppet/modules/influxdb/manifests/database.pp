class influxdb::database inherits influxdb {

 influxdb { 'Creating database':
    ensure    => present,
    username  => 'foster',
    password  => 'new.one',
    database  => 'chunkycheese',
    host      => '192.168.2.199',
    port      => '8086',
  }

 influxdb { 'Creating database2':
    ensure    => present,
    username  => 'foster',
    password  => 'new.one',
    database  => 'mamba',
    host      => '192.168.2.199',
    port      => '8086',
  }

influxuser { 'Creating user':
   ensure  => present,
   createuser => 'loser',
   userpwd    => 'new.one',
   host       => '192.168.2.199',
   port       => '8086',
   username   => 'foster',
   password   => 'new.one',
 }

influxperm { 'Modifying user':
   ensure     => present,
   user       => 'loser',
   perms      => 'write',
   host       => '192.168.2.199',
   port       => '8086',
   username   => 'foster',
   password   => 'new.one',
   database   => 'mamba',
  }
}
