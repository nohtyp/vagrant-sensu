class role::sensu_client {
include profile::myrepo
#include profile::firewall
include profile::monitor
include profile::clone
include profile::dns
include profile::myhosts
include stdlib


Class['profile::myrepo'] ->
Class['profile::dns'] ->
Class['profile::myhosts'] ->
Class['profile::monitor'] ->
Class['profile::clone']
#Class['profile::firewall']
}
