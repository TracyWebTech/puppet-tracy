
users::create { "fake_users1": 
  users => {
    "fake_user1" => {"ssh_authorized_keys" => "fake_key"},
    "fake_user2" => {"ssh_authorized_keys" => ["fake_key", "fake_key2"]}
  }
}