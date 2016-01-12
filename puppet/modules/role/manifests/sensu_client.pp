class role::sensu_client {
include profile::myrepo
include profile::firewall
include profile::monitor
include profile::clone
include stdlib


Class['profile::myrepo'] ->
Class['profile::monitor'] ->
Class['profile::clone'] ->
Class['profile::firewall']
}
