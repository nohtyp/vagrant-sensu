class redmine::untar inherits params {

  exec { 'untarring redmine directory':
   path     => '/bin',
   command  => "tar -xf ${redmine_dir_path}/${redmine_wget_pkg}",
   cwd      => "${redmine_dir_path}",
   unless   => "test -d ${redmine_dir_path}/${redmine_wget_pkg}",
  }
}
