class sensu::sensu_server::sensu_check inherits sensu {

  #file { '/etc/sensu/conf.d/test.json':
  #  ensure  => present,
  #}
#
#  file { '/etc/sensu/conf.d/test2.json':
#    ensure  => present,
#  }

  file { '/etc/sensu/conf.d/test3.json':
    ensure  => present,
  }

  file { '/etc/sensu/conf.d/mail.json':
    ensure  => present,
  }

  file { '/etc/sensu/conf.d/filters.json':
    ensure  => present,
  }

  file { '/etc/sensu/conf.d/mutators.json':
    ensure  => present,
  }

  #sensu_server_checks { '/etc/sensu/conf.d/test.json':
  #  ensure      => present,
  #  checks      => 'test',
  #  handler     => '/etc/sensu/plugins/sensu-plugins-chef/bin/handler-chef-node.rb',
  #  config_file => '/etc/sensu/conf.d/test.json',
  #  command     => '/etc/sensu/plugins/sensu-plugins-chef/bin/check-chef-client.rb',
  #  subscribers => [ 'test', 'fake' ],
  #  interval    => 60,
  #  ttl         => 5,
  #  timeout     => 15,
  #}

  #sensu_server_checks { '/etc/sensu/conf.d/test2.json':
  #  ensure      => present,
  #  checks      => 'test2',
  #  config_file => '/etc/sensu/conf.d/test2.json',
  #  command     => '/etc/sensu/plugins/sensu-plugins-chef/bin/check-chef.rb',
  #  subscribers => [ 'fake', 'foster' ],
  #  interval    => 30,
  #  ttl         => 5,
  #  timeout     => 5,
  #}

  sensu_server_checks { '/etc/sensu/conf.d/test3.json':
    ensure      => present,
    checks      => 'test3',
    config_file => '/etc/sensu/conf.d/test3.json',
    command     => '/etc/sensu/plugins/sensu-plugins-disk-checks/bin/check-disk-usage.rb',
    subscribers => [ 'fakes', 'foster' ],
    interval    => 10,
    ttl         => 10,
    timeout     => 20,
    require     => File['/etc/sensu/conf.d/test3.json'],
  }

  sensu_server_handlers { '/etc/sensu/conf.d/mail.json':
    ensure      => present,
    handler     => 'mail',
    config_file => '/etc/sensu/conf.d/mail.json',
    type        => 'pipe',
    command     => "mailx -s 'sensu event' next@address.com",
    filters     => [ 'recurrence', 'production' ],
    severities  => ["critical", "unknown"],
    mutator     => 'only_check_output',
    timeout     => 15,
    pipe        => { type => "direct", name => "mail_handler" },
    subdue      => { days => ["monday", "wednesday"] },
    require     => File['/etc/sensu/conf.d/mail.json'],
   }

  sensu_server_filters { '/etc/sensu/conf.d/filters.json':
    ensure      => present,
    name        => 'myfilters',
    config_file => '/etc/sensu/conf.d/filters.json',
    attributes  => { check => { team => "ops" }},
    negate      => false,
    require     => File['/etc/sensu/conf.d/filters.json'],
  }

  sensu_server_mutators { '/etc/sensu/conf.d/mutators.json':
    ensure      => present,
    name        => 'mymutates',
    config_file => '/etc/sensu/conf.d/mutators.json',
    command     => '/etc/sensu/plugins/mutated.rb',
    timeout     => 20,
    require     => File['/etc/sensu/conf.d/mutators.json'],
  }
}
