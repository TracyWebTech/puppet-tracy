define virtualenv::install_requirements(
  $virtualenv
) {

  $checksum = "${virtualenv}/requirements.checksum"
  
  Exec {
    path => ['/usr/bin']
  }

  exec { "checksum_${name}":
    command => "sha1sum ${requirements} > ${checksum}",
    unless => ["sha1sum -c ${checksum}", "test -d ${name}"]
  }

  exec { "update ${name} requirements":
    command => "pip install --environment=${virtualenv} -Ur ${name}",
    subscribe => Exec["checksum_${name}"],
    refreshonly => true,
    timeout => 1800,
  }

  exec { "pip_requirements ${virtualenv_path} ${name}":
    command => "pip install --environment=${virtualenv} -r ${name}",
    require => Exec["checksum_${name}"]
    
  }
}