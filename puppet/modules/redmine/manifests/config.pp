class redmine::config inherits params {

  file { 'Configure redmine config':
    ensure  => file,
    path    => "${redmine_dir_path}/${redmine_directory}/config/database.yml",
    content => template('redmine/redmine_database.erb'),
  }

  file { 'Changing ownership on redmine directory':
    ensure    => directory,
    path      => "${redmine_dir_path}/${redmine_directory}",
    owner     => "${redmine_user}",
    group     => "${redmine_group}",
    recurse   => true,
  }
}
