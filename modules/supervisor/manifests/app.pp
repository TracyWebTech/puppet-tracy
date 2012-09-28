define supervisor::app (
  $app_name = $title,
  $command,
  $directory,
  $user = 'ubuntu',
) {

  $conf_file = "supervisor_${app_name}"
  $service_name = $conf_file

  file { $conf_file:
    path => "/etc/supervisor/conf.d/${app_name}.conf",
    ensure => present,
    content => template('supervisor/supervisor.conf.erb'),
    require => Package['supervisor'],
    notify => Service['supervisor'],
  }

  service { $service_name:
    ensure => running,
    start => "/usr/bin/supervisorctl start $app_name",
    restart => "/usr/bin/supervisorctl restart $app_name",
    stop => "/usr/bin/supervisorctl stop $app_name",
    subscribe => File[$conf_file], 
    hasrestart => false, 
    hasstatus => false,
  }
}
