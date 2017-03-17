class influxdb::config inherits influxdb {

 file { 'InfluxDB Service config':
    ensure  => file,
    path    => $::influxdb::influxdb_config_path,
    backup  => true,
    mode    => '0644',
    owner   => $::influxdb::influxdb_user,
    group   => $::influxdb::influxdb_group,
    require => Package[$::influxdb::influxdb_pkg],
    content => template('influxdb/influxdb.conf.erb'),
  }

}
