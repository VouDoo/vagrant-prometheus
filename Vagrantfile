# -*- mode: ruby -*-
# vi: set ft=ruby :

selected_box = "centos/7"
vbox_group   = "promlab"

Vagrant.configure("2") do |config|
  config.vm.define "prometheus" do |prometheus|
    prometheus.vm.box = selected_box
    prometheus.vm.hostname = "prometheus"
    prometheus.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "prometheus"
      virtualbox.cpus = 1
      virtualbox.memory = 1024
      virtualbox.customize ["modifyvm", :id, "--groups", "/#{vbox_group}"]
    end
    prometheus.vm.network "private_network", ip: "192.168.77.10"
    prometheus.vm.network "forwarded_port", guest: 9090, host: 19090
    prometheus.vm.provision "file", source: "files/prometheus.yml", destination: "./prometheus.yml"
    prometheus.vm.provision "shell", path: "scripts/install-prometheus.sh"
  end
  config.vm.define "grafana" do |grafana|
    grafana.vm.box = selected_box
    grafana.vm.hostname = "grafana"
    grafana.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "grafana"
      virtualbox.cpus = 1
      virtualbox.memory = 1024
      virtualbox.customize ["modifyvm", :id, "--groups", "/#{vbox_group}"]
    end
    grafana.vm.network "private_network", ip: "192.168.77.20"
    grafana.vm.network "forwarded_port", guest: 3000, host: 13000
    grafana.vm.provision "shell", path: "scripts/install-grafana.sh"
  end
  config.vm.define "node" do |node|
    node.vm.box = selected_box
    node.vm.hostname = "node"
    node.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "node"
      virtualbox.cpus = 1
      virtualbox.memory = 512
      virtualbox.customize ["modifyvm", :id, "--groups", "/#{vbox_group}"]
    end
    node.vm.network "private_network", ip: "192.168.77.30"
    node.vm.network "forwarded_port", guest: 9100, host: 19100
    node.vm.provision "shell", path: "scripts/install-node_exporter.sh"
  end
end
