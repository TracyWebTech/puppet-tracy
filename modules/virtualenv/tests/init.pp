
include virtualenv

virtualenv::create { '/tmp/fake_env': }

virtualenv::install_package { "fake_package":
  virtualenv => '/tmp/fake_env'
}

virtualenv::install_package { "/tmp/fake_requirements.txt":
  virtualenv => '/tmp/fake_env'
}
