class role::sensu_client {
include profile::myrepo
include profile::firewall
include profile::monitor
include stdlib


Class['profile::myrepo'] ->
Class['profile::monitor'] ->
Class['profile::firewall']
}
