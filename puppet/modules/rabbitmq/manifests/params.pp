  # Class: rabbitmq::params
#
#   The RabbitMQ Module configuration settings.
#
class rabbitmq::params {

  case $::osfamily {
    'Archlinux': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq'
      $service_name     = 'rabbitmq'
      $version          = '3.1.3-1'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/lib/rabbitmq'
      $plugin_dir       = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
    }
    'Debian': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq-server'
      $service_name     = 'rabbitmq-server'
      $package_provider = 'apt'
      $version          = '3.1.5'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/lib/rabbitmq'
      $plugin_dir       = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
    }
    'OpenBSD': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq'
      $service_name     = 'rabbitmq'
      $version          = '3.4.2'
      $rabbitmq_user    = '_rabbitmq'
      $rabbitmq_group   = '_rabbitmq'
      $rabbitmq_home    = '/var/rabbitmq'
      $plugin_dir       = '/usr/local/lib/rabbitmq/plugins'
    }
    'RedHat': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq-server'
      $service_name     = 'rabbitmq-server'
      $package_provider = 'rpm'
      $version          = '3.1.5-1'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/lib/rabbitmq'
      $plugin_dir       = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
    }
    'SUSE': {
      $package_ensure   = 'installed'
      $package_name     = 'rabbitmq-server'
      $service_name     = 'rabbitmq-server'
      $package_provider = 'zypper'
      $version          = '3.1.5-1'
      $rabbitmq_user    = 'rabbitmq'
      $rabbitmq_group   = 'rabbitmq'
      $rabbitmq_home    = '/var/lib/rabbitmq'
      $plugin_dir       = "/usr/lib/rabbitmq/lib/rabbitmq_server-${version}/plugins"
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  #install
  $admin_enable               = true
  $management_port            = '15672'
  $management_ssl             = true
  $rabbitmq_url               = 'https://www.rabbitmq.com/releases/rabbitmq-server'
  $rabbit_version             = '3.5.6'
  $rabbit_minor               = '1'
  $package_apt_pin            = ''
  $package_gpg_key            = 'http://www.rabbitmq.com/rabbitmq-signing-key-public.asc'
  $external_repos             = false
  $manage_repos               = undef
  $service_ensure             = 'running'
  $service_manage             = true
  #config
  $cluster_node_type          = 'disc'
  $cluster_nodes              = ['sensu01', 'sensu02']
  $config                     = 'rabbitmq/rabbitmq.config.erb'
  $config_cluster             = true
  $config_path                = '/etc/rabbitmq/rabbitmq.config'
  $config_stomp               = false
  $default_user               = 'sensu'
  $default_pass               = 'sensu'
  $delete_guest_user          = true
  $env_config                 = 'rabbitmq/rabbitmq-env.conf.erb'
  $env_config_path            = '/etc/rabbitmq/rabbitmq-env.conf'
  $erlang_cookie              = 'sensu_cluster_chat'
  $interface                  = 'UNSET'
  $node_ip_address            = 'UNSET'
  $port                       = '5672'
  $tcp_keepalive              = false
  $ssl                        = false
  $ssl_only                   = false
  $ssl_cacert                 = 'UNSET'
  $ssl_cert                   = 'UNSET'
  $ssl_key                    = 'UNSET'
  $ssl_port                   = '5671'
  $ssl_interface              = 'UNSET'
  $ssl_management_port        = '15671'
  $ssl_stomp_port             = '6164'
  $ssl_verify                 = 'verify_none'
  $ssl_fail_if_no_peer_cert   = false
  $ssl_versions               = undef
  $ssl_ciphers                = []
  $stomp_ensure               = false
  $ldap_auth                  = false
  $ldap_server                = 'ldap'
  $ldap_user_dn_pattern       = 'cn=username,ou=People,dc=example,dc=com'
  $ldap_other_bind            = 'anon'
  $ldap_use_ssl               = false
  $ldap_port                  = '389'
  $ldap_log                   = false
  $ldap_config_variables      = {}
  $stomp_port                 = '6163'
  $stomp_ssl_only             = false
  $wipe_db_on_cookie_change   = true
  $cluster_partition_handling = 'ignore'
  $environment_variables      = {}
  $config_variables           = {}
  $config_kernel_variables    = {}
  $file_limit                 = '16384'
  $myvhost                    = '/sensu'
  $vhostuser                  = 'sensu'
  $config_perms               = '.*'
  $read_perms                 = '.*'
  $write_perms                = '.*'
  $queue_name                 = 'sensu@/sensu'
  $queue_user                 = 'sensu'
  $queue_passwd               = 'sensu'
  $queue_durable              = true
  $queue_autodel              = false
  $queue_ensure               = present
  $exchange_name              = "/sensu@sensu"
  $exchange_user              = 'sensu'
  $exchange_passwd            = 'sensu'
  $exchange_durable           = true
  $exchange_autodel           = false
  $exchange_args              = { x-message-ttl => 123, x-dead-letter-exchange => 'other'}
  $exchange_ensure            = present
  $exchange_type              = 'fanout'
  $exchange_internal          = true
}
