class influxdb::params {
  $influxdb_pkg_version                  = 'latest'
  $influxdb_pkg                          = ['influxdb', 'collectd']
  $admin_bind_port                       = "8083"
  $bind_ipaddress                        = "${::ipaddress_enp0s8}"
  $http_bind_port                        = "8086"
  $influxdb_user                         = 'root'
  $influxdb_group                        = 'root'
  $influxdb_config_path                  = '/etc/influxdb/influxdb.conf'
  $influxdb_service                      = 'influxdb'
  $hostname                              = "${::hostname}"
  $retention_autocreate                  = true
  $logging_enabled                       = true
  $data_shards_in_cluster                = true
  $influxdb_https_enable                 = false
  $influxdb_admin_cert                   = "/etc/ssl/influxdb.pem"
  $http_auth_enabled                     = false
  $http_log_enabled                      = true
  $http_write_tracing                    = false
  $http_pprof_enabled                    = false
  $http_https_enabled                    = false
  $http_certificate                      = "/etc/ssl/influxdb.pem"
  $subscriber_enabled                    = true
  $graphite_enabled                      = false
  $collectd_enabled                      = true
  $collectd_bind_port                    = "0.0.0.0:8888"
  $opentsdb_enabled                      = false
  $udp_enabled                           = false
  $continuous_queries_log_enabled        = true
  $continuous_queries_enabled            = true
  $reporting_disabled                    = false
  
}
