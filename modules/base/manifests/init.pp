
class base {
  # making prompt colored
  exec {
    "/bin/sed -i -re '/force_color_prompt=yes/ s/^#//' /etc/skel/.bashrc":
  }

  if $::environment == 'production' {
    $shell_color = '31'
  } elsif $::environment == 'test' {
    $shell_color = '33'
  }

  exec {
    "/bin/sed -i -re 's/01;32m/01;${shell_color}m/' /etc/skel/.bashrc":
  }

  # NTP
  cron { ntpdate:
    command => 'ntpdate ntp.ubuntu.com',
    user => root,
    hour => '*/1'
  }

}
