class role::mywiki {
include stdlib
include profile::dns
#include profile::db
include profile::sudo_perm
include profile::myrepo
#include profile::certificate
#include profile::web
include profile::wiki
#include profile::firewall
#include profile::myhosts

Class['profile::dns'] ->
Class['profile::myrepo'] ->
Class['profile::sudo_perm'] ->
#Class['profile::certificate'] ->
#Class['profile::db'] ->
Class['profile::wiki']
#Class['profile::web']
#Class['profile::myhosts'] ->
#Class['profile::proxy'] ->
#Class['profile::firewall']
}
