
VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_SERVER_URL'] = 'https://vagrant.elab.pro'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  #config.vm.provider = 'virtualbox'

  config.vm.define "net1" do | p |
   p.vm.box = 'ubuntu/22.04'
   p.vm.host_name = "net1"
   p.vm.network  "public_network", bridge: "wlp7s0"

       p.vm.provider :virtualbox do |res|

          res.customize ["modifyvm", :id, "--cpus", "2"]
          res.customize ["modifyvm", :id, "--memory", "2000"]
       end

  end

  config.vm.define "net2" do | b |
   b.vm.box= 'ubuntu/22.04'
   b.vm.host_name = "net2"

   b.vm.network  "public_network", bridge: "wlp7s0"
      b.vm.provider :virtualbox do |res|

        res.customize ["modifyvm", :id, "--cpus", "2"]
        res.customize ["modifyvm", :id, "--memory", "2000"]
      end

  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.compatibility_mode = "2.0"
  end

end
