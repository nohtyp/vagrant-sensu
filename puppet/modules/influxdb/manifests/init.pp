# == Class: influxdb
#
# Full description of class influxdb here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { influxdb:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author$domain.com>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class influxdb (

$influxdb_pkg                      = $influxdb::params::influxdb_pkg,
$reporting_disabled                = $influxdb::params::reporting_disabled,
$hostname                          = $influxdb::params::hostname,
$retention_autocreate              = $influxdb::params::retention_autocreate,
$logging_enabled                   = $influxdb::params::logging_enabled,
$data_shards_in_cluster            = $influxdb::params::data_shards_in_cluster,
$influxdb_https_enable             = $influxdb::params::influxdb_https_enable,
$influxdb_admin_cert               = $influxdb::params::influxdb_admin_cert,
$http_auth_enabled                 = $influxdb::params::http_auth_enabled,
$http_log_enabled                  = $influxdb::params::http_log_enabled,
$http_write_tracing                = $influxdb::params::http_write_tracing,
$http_pprof_enabled                = $influxdb::params::http_pprof_enabled,
$http_https_enabled                = $influxdb::params::http_https_enabled,
$http_certificate                  = $influxdb::params::http_certificate,
$subscriber_enabled                = $influxdb::params::subscriber_enabled,
$graphite_enabled                  = $influxdb::params::graphite_enabled,
$collectd_enabled                  = $influxdb::params::collectd_enabled,
$collectd_bind_port                = $influxdb::params::collectd_bind_port,
$opentsdb_enabled                  = $influxdb::params::opentsdb_enabled,
$udp_enabled                       = $influxdb::params::udp_enabled,
$continuous_queries_log_enabled    = $influxdb::params::continuous_queries_log_enabled,
$continuous_queries_enabled        = $influxdb::params::continuous_queries_enabled,
$admin_bind_port                   = $influxdb::params::admin_bind_port,
$http_bind_port                    = $influxdb::params::http_bind_port,

) inherits influxdb::params {

   anchor {'influxdb::begin': } ->
    class {'::influxdb::repo':} ->
    class {'::influxdb::install':} ->
    class {'::influxdb::config':} ->
    class {'::influxdb::service':} ->
    class {'::influxdb::database':} ->
   anchor {'influxdb::end':}
}
