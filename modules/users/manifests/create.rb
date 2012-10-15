define "users::create", :users do

  group "sudo", :ensure => :present

  @users.collect do |username,sshkey|
    user username, 
      :ensure => :present, 
      :managehome => :true, 
      :groups => "sudo",
      :require => "Group[sudo]"

    ssh_authorized_key username,
      :user => username,
      :type => 'rsa',
      :key => sshkey,
      :require => "User[" << username << "]"
  end
end