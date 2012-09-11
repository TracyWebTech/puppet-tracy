
define base::user(
  $username = $title, 
  $ensure = present, 
  $ssh_key = undef, 
  $ssh_key_type = 'ssh-rsa')
{
 
  user { $username:
    ensure => $ensure,
    groups => 'sudo',
    shell => '/bin/bash',
    managehome => true,
    require => Class['base::skel'],
  }

  exec {"usermod -p '' ${username}; chage -d 0 ${username}":
    path => ['/usr/bin/', '/usr/sbin/'],
    subscribe => User[$username],
    refreshonly => true,
    onlyif => "/usr/bin/id ${username}",
  }

  exec {"/bin/rm -fR /home/${username}":
    subscribe => User[$username],
    refreshonly => true,
    unless => "/usr/bin/id ${username}",
  }

  if $ssh_key {
    ssh_authorized_key { $username:
      user => $username,
      require => User[$username],
      type => $ssh_key_type,
      key => $ssh_key
    }
  }
}

