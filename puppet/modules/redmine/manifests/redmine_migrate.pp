class redmine::redmine_migrate inherits params {

  exec { 'Migrate database':
    path          => ['/usr/local/bin/', '/bin/'],
    command       => 'bundle exec rake db:migrate RAILS_ENV=production',
    cwd           => "${redmine_dir_path}/${redmine_directory}",
    user          => 'redmine',
    environment   => 'HOME=/home/redmine',
  }
}
