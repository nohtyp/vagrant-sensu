# == Class: redmine
#
# Full description of class redmine here.
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
#  class { redmine:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class redmine (
$redmine_packages      = $redmine::params::redmine_packages,
$redmine_gems          = $redmine::params::redmine_gems,
$redmine_version       = $redmine::params::redmine_version,
$redmine_url           = $redmine::params::redmine_url,
$redmine_wget_pkg      = $redmine::params::redmine_wget_pkg,
$redmine_adapter       = $redmine::params::redmine_adapter,
$redmine_dbname        = $redmine::params::redmine_dbname, 
$redmine_host          = $redmine::params::redmine_host,
$redmine_username      = $redmine::params::redmine_username,
$redmine_password      = $redmine::params::redmine_password,
$redmine_directory     = $redmine::params::redmine_directory,
$redmine_dir_path      = $redmine::params::redmine_dir_path,
$redmine_encoding      = $redmine::params::redmine_encoding,

) inherits params {

anchor {'redmin::begin': } 
  class {'::redmine::install':} ->
  class {'::redmine::database::initialize':} ->
  class {'::redmine::database::service':} ->
  class {'::redmine::database::users':} ->
  class {'::redmine::database::database':} ->
  class {'::redmine::users':} ->
  class {'::redmine::download':} ->
  class {'::redmine::untar':} ->
  class {'::redmine::config':} ->
  class {'::redmine::gems':} ->
  class {'::redmine::bundler':} ->
  class {'::redmine::redmine_token':} ->
  class {'::redmine::redmine_migrate':} ->
  #class {'::redmine::openssl::create_certificate':} ->
  class {'::redmine::web::httpconf':} ->
  class {'::redmine::web::passenger':} ->
  class {'::redmine::web::passengersvc':} ->
  class {'::redmine::web::service':} ->
  class {'::redmine::selinux':}
anchor {'redmine::end':}
}
