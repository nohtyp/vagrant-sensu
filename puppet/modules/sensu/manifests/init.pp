# == Class: sensu
#
# Full description of class sensu here.
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
#  class { sensu:
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
class sensu (

$sensu_package          = $sensu::params::sensu_package,
$sensu_config_path      = $sensu::params::sensu_config_path,
$sensu_uchiwa_path      = $sensu::params::sensu_uchiwa_path,
$sensu_client_path      = $sensu::params::sensu_client_path,
$sensu_base_url         = $sensu::params::sensu_base_url,
$gempackages            = $sensu::params::gempackages,
$kernel_settings        = $sensu::params::kernel_settings,
$kernel_sysctl_config   = $sensu::params::kernel_sysctl_config,
$use_sensu_repo         = $sensu::params::use_sensu_repo,
$sensu_client           = $sensu::params::sensu_client,
$redis_port             = $sensu::params::redis_port,
$sensu_api_port         = $sensu::params::sensu_api_port,
$uchiwa_server          = $sensu::params::uchiwa_server,


) inherits sensu::params {

    if $uchiwa_server == true and $use_sensu_repo == true and $sensu_client == false {
      anchor {'sensu::begin': } ->
       class {'::sensu::sensu_repo':} ->
       class {'::sensu::sensu_server::install':} ->
       #class {'::sensu::gems':} ->
       class {'::sensu::sensu_server::sensu_check':} ->
       class {'::sensu::sensu_server::sensu_server_config':} ->
       class {'::sensu::sensu_server::sensu_api_service':} ->
       class {'::sensu::sensu_server::sensu_server_service':}
       class {'::sensu::uchiwa::uchiwa_config':} 
       class {'::sensu::uchiwa::uchiwa_service':}
      anchor {'sensu::end':}
     }
    elsif $uchiwa_server == false and $use_sensu_repo == true and $sensu_client == false {
      anchor {'sensu::begin': } ->
       class {'::sensu::sensu_repo':} ->
       class {'::sensu::sensu_server::install':} ->
       #class {'::sensu::gems':} ->
       class {'::sensu::sensu_server::sensu_check':} ->
       class {'::sensu::sensu_server::sensu_server_config':} ->
       class {'::sensu::sensu_server::sensu_api_service':} ->
       class {'::sensu::sensu_server::sensu_server_service':}
      anchor {'sensu::end':}
     }
    elsif $uchiwa_server == false and $use_sensu_repo == false and $sensu_client == false {
      anchor {'sensu::begin': } ->
       class {'::sensu::sensu_server::install':} ->
       #class {'::sensu::gems':} ->
       class {'::sensu::sensu_server::sensu_check':} ->
       class {'::sensu::sensu_server::sensu_server_config':} ->
       class {'::sensu::sensu_server::sensu_api_service':} ->
       class {'::sensu::sensu_server::sensu_server_service':}
      anchor {'sensu::end':}
     }
    elsif $uchiwa_server == false and $use_sensu_repo == false and $sensu_client == true {
      anchor {'sensu::begin': } ->
       class {'::sensu::sensu_client::install':} ->
       class {'::sensu::env_export':} ->
       ##class {'::sensu::gems':} ->
       class {'::sensu::sensu_server::sensu_check':} ->
       class {'::sensu::sensu_client::sensu_config':} ->
       class {'::sensu::sensu_client::sensu_client_service':}
      anchor {'sensu::end':}
     }
    elsif $uchiwa_server == false and $use_sensu_repo == true and $sensu_client == true {
      anchor {'sensu::begin': } ->
       class {'::sensu::sensu_repo':} ->
       class {'::sensu::sensu_client::install':} ->
       class {'::sensu::env_export':} ->
       ##class {'::sensu::gems':} ->
       class {'::sensu::sensu_client::sensu_config':} ->
       class {'::sensu::sensu_client::sensu_client_service':}
      anchor {'sensu::end':}
     }
    elsif $uchiwa_server == true and $use_sensu_repo == false and $sensu_client == false {
      anchor {'sensu::begin': } ->
       class {'::sensu::sensu_server::install':} ->
       #class {'::sensu::gems':} ->
       class {'::sensu::sensu_server::sensu_check':} ->
       class {'::sensu::sensu_server::sensu_server_config':} ->
       class {'::sensu::sensu_server::sensu_api_service':} ->
       class {'::sensu::sensu_server::sensu_server_service':}
       class {'::sensu::uchiwa::uchiwa_config':} 
       class {'::sensu::uchiwa::uchiwa_service':}
      anchor {'sensu::end':}
     }
    elsif $uchiwa_server == true and $use_sensu_repo == false and $sensu_client == true {
      anchor {'sensu::begin': } ->
       class {'::sensu::sensu_client::install':} ->
       class {'::sensu::env_export':} ->
       ##class {'::sensu::gems':} ->
       class {'::sensu::sensu_client::sensu_config':} ->
       class {'::sensu::sensu_client::sensu_client_service':} ->
       class {'::sensu::uchiwa::uchiwa_config':}
       class {'::sensu::uchiwa::uchiwa_service':}
      anchor {'sensu::end':}
     }
    else {
      anchor {'sensu::begin': } ->
       class {'::sensu::sensu_client::install':} ->
       class {'::sensu::env_export':} ->
       ##class {'::sensu::gems':} ->
       class {'::sensu::sensu_client::sensu_config':} ->
       class {'::sensu::sensu_client::sensu_client_service':}
      anchor {'sensu::end':}
    }
}
