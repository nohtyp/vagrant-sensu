class sensu::sensu_client::sensu_check inherits sensu {

  file { '/etc/sensu/test':
    ensure  => present,
  }

  file { '/etc/sensu/test2':
    ensure  => present,
  }

  sensu_server_checks { '/etc/sensu/test':
    ensure      => present,
    checks      => 'test',
    config_file => '/etc/sensu/test',
    command     => '/etc/sensu/plugins/check-chef-client.rb',
    subscribers => [ 'test', 'fake' ],
    interval    => 60,
    ttl         => 5,
    timeout     => 15,
  }

  sensu_server_checks { '/etc/sensu/test2':
    ensure      => present,
    checks      => 'test2',
    config_file => '/etc/sensu/test2',
    command     => '/etc/sensu/plugins/check-chef.rb',
    subscribers => [ 'fake' ],
    interval    => 30,
    ttl         => 1,
    timeout     => 5,
  }
}
