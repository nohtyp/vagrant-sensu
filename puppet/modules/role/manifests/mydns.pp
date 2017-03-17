class role::mydns {
include profile::myrepo
include profile::dns
include profile::monitordb
include profile::myhosts
include stdlib

Class['profile::dns'] ->
Class['profile::myhosts'] ->
Class['profile::myrepo'] ->
Class['profile::monitordb']
}
