TorqueBox::RemoteDeploy.configure do
  torquebox_home "/opt/torquebox"
  hostname "localhost"
  port "2222"
  user "vagrant"
  key "~/.vagrant.d/insecure_private_key"
end