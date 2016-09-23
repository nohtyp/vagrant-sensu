class sensu::env_export inherits sensu {

  exec { 'Gem export':
   environment => ["GEM_HOME=/opt/sensu/embedded/lib/ruby/gems/2.3.0"],
   path        => ['/bin/', '/sbin/'],
   command     => "bash -c export $GEM_HOME",
   unless      => "echo $GEM_HOME",
  }

  exec { 'Gem installs':
   path        => ['/opt/sensu/embedded/bin/'],
   command     => "gem install $gempackages",
   #unless      => ['test -f ",
 }

}
