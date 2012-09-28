
class postfix {
  package { 'postfix':
    ensure => installed,
  }
  
  package { 'mailutils':
    ensure => installed,
  }

  service { 'postfix':
    ensure => running,
    enable => true,
    hasstatus => false,
    stop => 'invoke-rc.d postfix stop',
    start => 'invoke-rc.d postfix start',
    restart => 'invoke-rc.d postfix restart',
  }
}
