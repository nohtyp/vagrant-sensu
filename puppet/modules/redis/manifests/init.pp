# == Class: redis
#
# Full description of class redis here.
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
#  class { redis:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class redis (
$redis_pkgs                 = $redis::params::redis_pkgs,
$redis_config               = $redis::params::redis_config,
$redis_config_path          = $redis::params::redis_config_path,
$redis_service              = $redis::params::redis_service,
$redis_sentinel_config      = $redis::params::redis_sentinel_config,
$redis_sentinel_config_path = $redis::params::redis_sentinel_config_path,
$redis_sentinel_service     = $redis::params::redis_sentinel_service,
$use_hiera                  = $redis::params::use_hiera,
) inherits redis::params {

anchor {'redis::begin': } ->
  class {'::redis::redis::install':} ->
  class {'::redis::redis::redis_config':} ->
  class {'::redis::sentinel::redis_sentinel_config':} ->
  class {'::redis::redis::redis_service':} ->
  class {'::redis::sentinel::redis_sentinel_service':}
anchor {'redis::end':}

}
