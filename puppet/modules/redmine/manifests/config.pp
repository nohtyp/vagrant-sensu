class redmine::config inherits params {

  file { 'Configure redmine config':
    ensure  => file,
    path    => "${redmine_dir_path}/${redmine_directory}/config/database.yml",
    content => template('redmine/redmine_database.erb'),
  }

  file { 'Changing ownership on redmine directory':
    ensure    => directory,
    path      => "${redmine_dir_path}/${redmine_directory}",
    owner     => "${apache_user}",
    group     => "${redmine_group}",
    recurse   => true,
  }

  file { 'Changing mode on db schema':
    ensure    => file,
    path      => "${redmine_dir_path}/${redmine_directory}/db/schema.rb",
    owner     => "${apache_user}",
    group     => "${redmine_group}",
    mode      => '0664',
  }

  file { 'Changing mode on production log file':
    ensure    => file,
    path      => "${redmine_dir_path}/${redmine_directory}/log/production.log",
    owner     => "${apache_user}",
    group     => "${redmine_group}",
    mode      => '0664',
  }
}
