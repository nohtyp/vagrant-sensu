class redmine::gems inherits params {
  
  package { $redmine_gems:
    ensure    => present,
    provider  => 'gem',
  }
}
