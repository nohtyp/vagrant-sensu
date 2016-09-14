class role::sensu_server {
include profile::dns
include profile::myhosts
include profile::firewall
include profile::myrepo
include profile::shard
include profile::queue
include profile::monitor
include stdlib


Class['profile::dns'] ->
Class['profile::myhosts'] ->
Class['profile::myrepo'] ->
Class['profile::shard'] ->
Class['profile::queue'] ->
Class['profile::monitor'] ->
Class['profile::firewall']
}
