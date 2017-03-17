class influxdb::service inherits influxdb {

  service {'InfluxDB Service':
      ensure     => running,
      name       => $::influxdb::influxdb_service,
      hasstatus  => true,
      hasrestart => true,
      require    => Package[$::influxdb::influxdb_pkg],
      subscribe  => File['InfluxDB Service config'],
    }

}
