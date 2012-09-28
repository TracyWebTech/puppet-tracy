
class postfix {
  package { 'postfix': }
  package { 'mailutils': }

  service { 'postfix':
    ensure => running,
    enable => true,
    hasstatus => false,
    stop => 'invoke-rc.d postfix stop',
    start => 'invoke-rc.d postfix start',
    restart => 'invoke-rc.d postfix restart',
  }
}
