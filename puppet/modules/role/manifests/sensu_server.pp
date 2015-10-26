class role::sensu_server {
include profile::myrepo
include profile::shard
include profile::queue
include profile::monitor


Class['profile::myrepo'] ->
Class['profile::shard'] ->
Class['profile::queue'] ->
Class['profile::monitor']
}
