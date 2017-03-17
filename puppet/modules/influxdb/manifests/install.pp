class influxdb::install inherits influxdb {

  package { $::influxdb::influxdb_pkg:
      ensure    => installed,
    }

}
