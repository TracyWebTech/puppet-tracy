
class base::nginx {
  
  package { 'nginx': }
  
  service { 'nginx': 
    ensure => running,
    enable => true,
    provider => 'debian',
    hasrestart => true,
  }
}
