define virtualenv::install_package(
    $virtualenv,
    $user = undef
) {

  exec { "pip_package ${virtualenv} ${name}":
    command => "pip install --environment=${virtualenv} ${name}",
    user => $user,
    path => ['/usr/bin']
  }
  
}