
define pip::require($virtualenv_path, $owner) {
  $requirements = $name
  $checksum = "${virtualenv_path}/requirements.checksum"

  Exec {
    user => $owner,
    cwd => "/tmp",
    environment => ["PIP_DOWNLOAD_CACHE=~$owner/.pip-cache/"],
  }

  file { $requirements:
    ensure => present,
    replace => false,
    owner => $owner,
    group => $owner,
    content => "# Puppet will install packages listed here and update them if
# the the contents of this file changes.",
  }

# We create a sha1 checksum of the requirements file so that
# we can detect when it changes:
  exec { "create new checksum of ${name} requirements":
    command => "sha1sum ${requirements} > ${checksum}",
    unless => "sha1sum -c ${checksum}",
    require => File[$requirements],
  }

  exec { "update ${name} requirements":
    command => "${virtualenv_path}/bin/pip install -Ur ${requirements}",
    cwd => $virtualenv_path,
    subscribe => Exec["create new checksum of ${name} requirements"],
    refreshonly => true,
    timeout => 1800, # sometimes, this can take a while,
  }
}
