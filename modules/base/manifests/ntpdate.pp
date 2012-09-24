
class base::ntpdate {
  cron { ntpdate: 
    command => 'ntpdate ntp.ubuntu.com',
    user => root,
    hour => '*/1'
  }
}
