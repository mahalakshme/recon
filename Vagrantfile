# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty32"

  # Forward postgres and rails
  config.vm.network 'forwarded_port', :guest => 3000, :host => 3000
  config.vm.network 'forwarded_port', :guest => 5432, :host => 5432

  # Forward X over SSH
  config.ssh.forward_x11 = true
  config.ssh.forward_agent = true

  # Cache gems and apt archives
  config.vm.synced_folder 'tmp/vagrant/apt', '/var/cache/apt/archives', create: true
  config.vm.synced_folder 'tmp/vagrant/gems', '/var/lib/gems/2.1.0/cache', create: true, mount_options: ['dmode=777', 'fmode=666']

  # Provision as root
  config.vm.provision :shell, privileged: true, inline: <<-SCRIPT
    echo "Installing necessary packages..."
    add-apt-repository -y ppa:brightbox/ruby-ng
    apt-get -y update
    apt-get -y install build-essential git libxml2-dev libxslt1-dev imagemagick zlib1g-dev ruby2.1 ruby2.1-dev nodejs curl wget postgresql postgresql-contrib postgresql-client libpq-dev memcached

    echo "Setting up postgres authentication..."
    echo 'host all all 0.0.0.0/0 trust' > /etc/postgresql/9.3/main/pg_hba.conf
    service postgresql restart

    echo "Setting up ruby..."
    echo 'gem: --no-ri --no-rdoc' > /etc/gemrc
    gem install bundler
  SCRIPT

  # Provision as vagrant user
  config.vm.provision :shell, privileged: false, inline: <<-SCRIPT
    echo "Installing gems..."
    cd /vagrant
    bundle install --jobs 3
    rake db:create db:migrate db:seed
  SCRIPT

end
