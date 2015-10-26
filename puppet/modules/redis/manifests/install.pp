class redis::install inherits redis {

  package { $redis_package:
    ensure   => installed,
    require  => Class['profile::myrepo'],
  }
}
