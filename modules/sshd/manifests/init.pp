
class sshd {

  package { 'openssh-server':
    ensure => installed,
  }
  
  file { '/etc/ssh/sshd_config':
    owner   => 'root',
    group   => 'root',
    mode    => '600',
    require => Package['openssh-server'],
  }
  
  service { 'ssh':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => File['/etc/ssh/sshd_config']
  }

}
