class redis::params {
$redis_user                 = 'redis'
$redis_group                = 'redis'
$use_hiera                  = false
$use_sentinel_hiera         = false
case $::osfamily {
  'RedHat': {
    $redis_package              = 'redis'
    $redis_service              = 'redis'
    $redis_sentinel_service     = 'redis-sentinel'
    $redis_config_path          = '/etc/redis.conf'
    $redis_sentinel_config_path = '/etc/redis-sentinel.conf'
  }
  #'Debian': {
  #  $redis_package              = 'redis-server'
  #  $redis_service              = 'redis-server'
  #  $redis_sentinel_service     = 'redis-server --sentinel'
  #  $redis_config_path          = '/etc/redis/redis.conf'
  #  $redis_sentinel_config_path = '/etc/redis/redis-sentinel.conf'
  #  $redis_sentinel_package     = 'redis-server'
  #}
  #'Suse': {
  #  $redis_config_path          = '/etc/redis/redis-server.conf'
  #  $redis_package              = 'redis'
  #  $redis_sentinel_config_path = '/etc/redis/redis-sentinel.conf'
  #  $redis_sentinel_package     = 'redis'
  #}
  default: {
    fail "Operating system ${::operatingsystem} is not supported yet."
  }
  }
if $use_hiera {
  $redis_config                 = hiera('redis::redis_config')
  }
else {
  $redis_config = {
  daemonize                     => 'no',
  pidfile                       => '/var/run/redis/redis.pid',
  port                          => '6379',
  tcp-backlog                   => '511',
  bind                          => "${::ipaddress_enp0s8}",
  timeout                       => '0',
  tcp-keepalive                 => '0',
  loglevel                      => 'notice',
  logfile                       => '/var/log/redis/redis.log',
  databases                     => '16',
  'save 900'                    => '1',
  'save 300'                    => '10',
  'save 60'                     => '10000',
  stop-writes-on-bgsave-error   => 'yes',
  rdbcompression                => 'yes',
  rdbchecksum                   => 'yes',
  dbfilename                    => 'dump.rdb',
  dir                           => '/var/lib/redis',
  slave-serve-stale-data        => 'yes',
  slave-read-only               => 'yes',
  repl-diskless-sync            => 'no',
  repl-diskless-sync-delay      => '5',
  repl-disable-tcp-nodelay      => 'no',
  slave-priority                => '100',
  appendonly                    => 'no',
  appendfilename                => 'appendonly.aof',
  appendfsync                   => 'everysec',
  no-appendfsync-on-rewrite     => 'no',
  auto-aof-rewrite-percentage   => '100',
  auto-aof-rewrite-min-size     => '64mb',
  aof-load-truncated            => 'yes',
  lua-time-limit                => '5000',
  slowlog-log-slower-than       => '10000',
  slowlog-max-len               => '128',
  latency-monitor-threshold     => '0',
  notify-keyspace-events        => '""',
  hash-max-ziplist-entries      => '512',
  hash-max-ziplist-value        => '64',
  list-max-ziplist-entries      => '512',
  list-max-ziplist-value        => '64',
  set-max-intset-entries        => '512',
  zset-max-ziplist-entries      => '128',
  zset-max-ziplist-value        => '64',
  hll-sparse-max-bytes          => '3000',
  activerehashing               => 'yes',
  client-output-buffer-limit    => 'normal 0 0 0',
  client-output-buffer-limit    => 'slave 256mb 64mb 60',
  client-output-buffer-limit    => 'pubsub 32mb 8mb 60',
  hz                            => '10',
  aof-rewrite-incremental-fsync => 'yes',
  }
}
if $use_sentinel_hiera {
  $redis_sentinel_conf          = hiera('redis::redis_sentinel_conf')
  }
else {
  $redis_sentinel_conf = {
  port                               => '6379',
  dir                                => '/tmp',
  'sentinel monitor mymaster'        => "${::ipaddress_enp0s8} 6379 2",
  'sentinel down-after-milliseconds' => 'mymaster 30000',
  'sentinel parallel-syncs'          => 'mymaster 1',
  'sentinel failover-timeout'        => 'mymaster 180000',
  logfile                            => '/var/log/redis/sentinel.log',
  }
  }
}
