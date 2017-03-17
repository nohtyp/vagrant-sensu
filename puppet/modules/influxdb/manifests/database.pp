class influxdb::database inherits influxdb {

 influxdb { 'Creating database':
    ensure  => present,
    username  => 'foster',
    password  => 'new.one',
    database  => 'chunkycheese',
    host      => '192.168.2.199',
    port      => '8086',
  }

influxuser { 'Creating user':
   ensure  => absent,
   createuser => 'loser',
   userpwd  => 'new.one',
   host       => '192.168.2.199',
   port      => '8086',
   username  => 'foster',
   password  => 'new.one',
 }

}
