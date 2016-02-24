class git::gitclone inherits git {

git_clone { "repo_list":
    ensure      => absent,
    baseurl     => 'https://github.com/sensu-plugins',
    repo        => $sensu_git,
    destination => '/etc/sensu/plugins',
    require     => Package['install git'],
  }
}

