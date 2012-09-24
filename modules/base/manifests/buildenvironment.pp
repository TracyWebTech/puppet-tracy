define base::buildenvironment(
  $env_name = $title, 
  $repository_url,
  $deploy_user,
  $client = 'git',
  $virtualenv_path
) {

  Exec {
    path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    logoutput => true,
  }

  if !defined(Package[$client]) {
    package { $client:
      ensure => installed,
    }
  }

  package { 'python-virtualenv': 
    ensure => installed,
  }

  $requirements_txt = "${$virtualenv_path}/${env_name}/src/requirements.txt"

  file { $virtualenv_path:
    ensure => directory,
    recurse => true,
    mode => 666
  }

  exec { "create_virtualenv $env_name":
    command => "virtualenv ${$virtualenv_path}/${env_name}",
    cwd => $virtualenv_path,
    user => $deploy_user,
    require => [Package['python-virtualenv'], User[$deploy_user], 
                                                      File[$virtualenv_path]],
    unless => "test -d ${$virtualenv_path}/${env_name}",
  }

  exec { "clone_repository $env_name":
    command => "${client} clone ${repository_url} ${$virtualenv_path}/${env_name}/src",
    user => $deploy_user,
    require => [Exec["create_virtualenv ${env_name}"], Package[$client]],
    unless => "test -d ${$virtualenv_path}/${env_name}/src",
  }

  package { "build-essential":
    ensure => installed,
  }

  pip::require { $requirements_txt: 
    virtualenv_path => "${virtualenv_path}/${env_name}",
    owner => $deploy_user,
    require => [
      [Exec["clone_repository ${env_name}"], Package['build-essential']]
    ]
  }

}