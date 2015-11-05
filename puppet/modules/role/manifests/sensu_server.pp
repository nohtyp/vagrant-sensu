class role::sensu_server {
include profile::firewall
include stdlib

#Class['profile::firewall']
}
