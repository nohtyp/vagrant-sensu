class influxdb::params {
  $influxdb_pkg_version  = 'latest'
  $influxdb_pkg          = ['influxdb', 'collectd']
  $admin_bind_port       = "8083"
  $http_bind_port        = "8086"
  $collectd_bind_port    = '0.0.0.0:8888'
  $influxdb_user         = 'root'
  $influxdb_group        = 'root'
  $influxdb_config_path  = '/etc/influxdb/influxdb.conf'
  $influxdb_service      = 'influxdb'
  $influxdb_https_enable = false

}
