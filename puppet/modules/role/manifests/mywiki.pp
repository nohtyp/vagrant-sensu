class role::mywiki {
include profile::wiki
include profile::db
include profile::sudo_perm
include profile::myrepo
#include profile::firewall
include profile::dns
#include profile::myhosts
include stdlib

Class['profile::dns'] ->
Class['profile::myrepo'] ->
Class['profile::wiki'] ->
Class['profile::sudo_perm'] ->
Class['profile::db']
#Class['profile::myhosts'] ->
#Class['profile::proxy'] ->
#Class['profile::firewall']
}
