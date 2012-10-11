define virtualenv::create(
  $user = undef
) {

  exec { "create_virtualenv ${name}":
    command => "virtualenv ${name}",
    user => $user,
    require => Package['python-virtualenv'],
    path => ['/usr/bin']
  }

}