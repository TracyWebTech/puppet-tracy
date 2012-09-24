class milou::milou {
  
  include base::ntpdate
  include base::sshd

  $user = 'davi'
  $virtualenv_path = '/usr/local/virtualenvs'

  user { $user: 
    ensure => present,
  }

  # Send SSH Keys
  file { 'ssh_keys':
    path => "/home/${user}/.ssh/",
    ensure => directory,
    recurse => true,
    owner => $user,
    group => $user,
    mode => 600,
    source => "puppet:///modules/milou/ssh/",
    require => User[$user]
  }

  ssh_authorized_key { 'davi':
    ensure => present,
    user => $user,
    type => 'rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJcaxt21vy5f69iSvsefg03BlFeMTp2eGtGqz3qsCsZZkbkhxh1qZY+c4RvXoG3dh4iZjAwhCHuUBG16/8NeiLXeZIxSvGsx+J03tTpSbjVOAO8ur7CZuXQvjCHpXepKdCuaHMjZHTFIFvFdbsnif1vCFATf+rLmEO/YiDX3PXCZRSKAMBzne5w7a2wRSVBFjFq1HnLKGR09tuMu8kc1InLV+CoWcqtAfEbpPD1QJu2mq2qv6295PkeuNu0AnbR2J7qTFWcr050nS6ne1B4qKcr5W0drunOeFiTY118gUItEKS5sFFDgXg+noXNW1bpnwXiDTSQs5JYN2YTjv3fAnX',
  }

  ssh_authorized_key { 'sergio':
    ensure => present,
    user => $user,
    type => 'rsa',
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDJcaxt21vy5f69iSvsefg03BlFeMTp2eGtGqz3qsCsZZkbkhxh1qZY+c4RvXoG3dh4iZjAwhCHuUBG16/8NeiLXeZIxSvGsx+J03tTpSbjVOAO8ur7CZuXQvjCHpXepKdCuaHMjZHTFIFvFdbsnif1vCFATf+rLmEO/YiDX3PXCZRSKAMBzne5w7a2wRSVBFjFq1HnLKGR09tuMu8kc1InLV+CoWcqtAfEbpPD1QJu2mq2qv6295PkeuNu0AnbR2J7qTFWcr050nS6ne1B4qKcr5W0drunOeFiTY118gUItEKS5sFFDgXg+noXNW1bpnwXiDTSQs5JYN2YTjv3fAnX',
  }

  class { milou::conectar:
    user => $user,
    virtualenv_path => $virtualenv_path,
    require => File['ssh_keys']
  }

}