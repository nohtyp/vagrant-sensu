class redmine::download inherits params {
  
  exec { "Download redmine-${redmine_version}":
    path      => '/bin',
    command   => "wget ${redmine_url}/${redmine_wget_pkg}",
    cwd       => "${redmine_dir_path}",
    unless    => "test -f ${redmine_dir_path}/${redmine_wget_pkg}",
  }
}
