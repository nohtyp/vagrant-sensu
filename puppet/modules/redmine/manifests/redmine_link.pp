class redmine::redmine_link inherits params {

  exec { 'Creating symbolic link for Redmine':
    path          => ['/bin'],
    command       => "ln -s  ${redmine_dir_path}/${redmine_directory} ${redmine_dir_path}/redmine",
  }
}
