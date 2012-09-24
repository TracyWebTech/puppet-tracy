class milou::conectar($user, $virtualenv_path) {
  
  package { 'sqlite3': ensure => installed }

  base::buildenvironment{'conectar': 
    repository_url => 'git@bitbucket.org:seocam/conectar.git',
    deploy_user => $user,
    virtualenv_path => $virtualenv_path
  }

  file { 'conectar_settings':
    path => "${virtualenv_path}/conectar/src/conectar/settings_local.py",
    ensure => present,
    owner => $user,
    group => $user,
    source => 'puppet:///modules/milou/conectar/settings_local.py',
    require => Base::Buildenvironment['conectar']
  }

  exec { "collectstatic $virtualenv_name":
    command => "${virtualenv_path}/conectar/bin/python ${virtualenv_path}/conectar/src/manage.py collectstatic --noinput --settings=conectar.settings",
    user => $user,
    cwd => "${virtualenv_path}/conectar/src/conectar",
    require => File['conectar_settings']
  }

  exec { "syncdb $virtualenv_name":
    command => "${virtualenv_path}/conectar/bin/python ${virtualenv_path}/conectar/src/manage.py syncdb --noinput --settings=conectar.settings",
    user => $user,
    cwd => "${virtualenv_path}/conectar/src/conectar",
    require => File['conectar_settings']
  }

  supervisor::supervisor { 'conectar':
    command => "${virtualenv_path}/conectar/bin/gunicorn wsgi:application --bind='127.0.0.1:8000'",
    directory => "${virtualenv_path}/conectar/src/conectar",
    require => File['conectar_settings']
  }

}