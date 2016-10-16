class role::mywiki {
include stdlib
include profile::dns
include profile::sudo_perm
include profile::myrepo
include profile::wiki
include profile::firewall
#include profile::myhosts

Class['profile::dns'] ->
Class['profile::myrepo'] ->
Class['profile::sudo_perm'] ->
Class['profile::firewall'] ->
Class['profile::wiki']
#Class['profile::myhosts'] ->
}
