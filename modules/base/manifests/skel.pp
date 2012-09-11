
class base::skel {
  exec {
    "/bin/sed -i -re '/force_color_prompt=yes/ s/^#//' /etc/skel/.bashrc":
  }
  
  exec {
    "/bin/sed -i -re 's/01;32m/01;31m/' /etc/skel/.bashrc":
  }
}
