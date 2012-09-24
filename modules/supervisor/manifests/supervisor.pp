define supervisor::supervisor (
  $app_name = $title,
  $command,
  $directory
) {

  Exec {
    path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    logoutput => true,
  }

  package { "supervisor":
    ensure => installed,
  }

  service { "supervisor":
    ensure => running,
    enable => true,
    require => Package['supervisor']
  }

  file { "supervisor ${app_name}":
    path => "/etc/supervisor/conf.d/${app_name}.conf",
    ensure => present,
    content => template('supervisor/supervisor.conf.erb'),
    require => Package['supervisor']
  }

  exec { "supervisorctl update":
    user => "root",
    require => [File["supervisor ${app_name}"], Service['supervisor']]
  }

}