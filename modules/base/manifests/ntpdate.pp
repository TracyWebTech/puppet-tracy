
class base::ntpdate {
  file { '/etc/cron.hourly/ntpdate':
    ensure => file,
    mode => '755',
    owner => root,
    group => root,
    source => 'puppet:///modules/base/ntp/ntpdate',
  }
}
