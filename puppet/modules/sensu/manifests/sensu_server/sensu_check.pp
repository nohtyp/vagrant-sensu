class sensu::sensu_server::sensu_check inherits sensu {

  file { '/etc/sensu/conf.d/test.json':
    ensure  => present,
  }

  file { '/etc/sensu/conf.d/test2.json':
    ensure  => present,
  }

  sensu_server_checks { '/etc/sensu/conf.d/test.json':
    ensure      => present,
    checks      => 'test',
    config_file => '/etc/sensu/conf.d/test.json',
    command     => '/etc/sensu/plugins/sensu-plugins-chef/bin/check-chef-client.rb',
    subscribers => [ 'test', 'fake' ],
    interval    => 60,
    ttl         => 5,
    timeout     => 15,
  }

  sensu_server_checks { '/etc/sensu/conf.d/test2.json':
    ensure      => present,
    checks      => 'test2',
    config_file => '/etc/sensu/conf.d/test2.json',
    command     => '/etc/sensu/plugins/sensu-plugins-chef/bin/check-chef.rb',
    subscribers => [ 'fake', 'foster' ],
    interval    => 30,
    ttl         => 1,
    timeout     => 5,
  }
}
