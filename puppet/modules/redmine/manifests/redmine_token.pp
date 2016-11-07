class redmine::redmine_token inherits params {

  exec { 'Generate redmine token':
    path          => ['/usr/local/bin/', '/bin/'],
    command       => 'bundle exec rake generate_secret_token',
    cwd           => "${redmine_dir_path}/${redmine_directory}",
    user          => "${redmine_user}",
    environment   => 'HOME=${redmine_userenvhome}',
    unless        => [ "test -f ${redmine_dir_path}/${redmine_directory}/config/initializers/secret_token.rb" ],
  }
}

