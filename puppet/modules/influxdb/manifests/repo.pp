class influxdb::repo inherits influxdb {

 file { 'InfluxDB repo config':
    ensure  => file,
    path    => '/etc/yum.repos.d/influxdb.repo',
    backup  => true,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('influxdb/influxdb.repo.erb'),
  }

}
