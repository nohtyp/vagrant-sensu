class role::myproxy {
include profile::myrepo
include profile::proxy
include profile::firewall
include profile::dns
include profile::myhosts
include stdlib

Class['profile::dns'] ->
Class['profile::myhosts'] ->
Class['profile::myrepo'] ->
Class['profile::proxy'] ->
Class['profile::firewall']
}
