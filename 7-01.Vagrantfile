
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.provider = 'virtualbox'

  config.vm.define "net1" do | p |
   p.vm.box = 'centos/7'
   p.vm.host_name = "net1"
   p.vm.network  "public_network", bridge: "wlp7s0"

       p.vm.provider :virtualbox do |res|

          res.customize ["modifyvm", :id, "--cpus", "2"]
          res.customize ["modifyvm", :id, "--memory", "2000"]
       end

  end

  config.vm.define "net2" do | b |
   b.vm.box= 'centos/7'
   b.vm.host_name = "net2"

   b.vm.network  "public_network", bridge: "wlp7s0"
      b.vm.provider :virtualbox do |res|

        res.customize ["modifyvm", :id, "--cpus", "2"]
        res.customize ["modifyvm", :id, "--memory", "2000"]
      end

  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end

end
