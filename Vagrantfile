Vagrant::Config.run do |config|
  config.vm.define :minitest do |minitest|
    minitest.vm.customize do |vm|
      vm.memory_size = 512
    end
    minitest.vm.box = 'natty64_cloudscaling_4.1'
    minitest.vm.box_url = "http://d1lfnqkkmlbdsd.cloudfront.net/vagrant/natty64_cloudscaling_4.1.box"
    minitest.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "cookbooks"
      chef.add_recipe "minitest"
      chef.add_recipe "minitest::examples"
    end
  end
end
