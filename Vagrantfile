# -*- mode: ruby -*-
# vi: set ft=ruby :


# Vagrantfile
#
# DESCRIPTION
# ~~~~~~~~~~~
# Deploy a Prometheus environment
# Grafana can be used to create dashboards from metrics collected by Prometheus
#
# NOTES
# ~~~~~
# This Vagrantfile uses VirtualBox as provider
# Make sure that VirtualBox is installed on your machine
# To install it, please visit the official Website:
#   https://www.virtualbox.org/wiki/Downloads
#
# Use the following command to spin up the boxes:
#   vagrant up

vbox_group = "prometheus"

Vagrant.configure("2") do |config|
  config.vm.define "prometheus" do |prometheus|
    prometheus.vm.box = "centos/7"
    prometheus.vm.hostname = "prometheus"
    prometheus.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "prometheus"
      virtualbox.cpus = 1
      virtualbox.memory = 1024
      virtualbox.customize ["modifyvm", :id, "--groups", "/#{vbox_group}"]
    end
    prometheus.vm.network "private_network", ip: "192.168.77.10"
    prometheus.vm.network "forwarded_port", guest: 9090, host: 19090
    prometheus.vm.provision "shell", path: "scripts/install-prometheus.sh"
    prometheus.vm.provision "file", source: "files/prometheus.yml", destination: "/tmp/prometheus.yml"
    prometheus.vm.provision "shell", inline: <<-SHELL
      mv /tmp/prometheus.yml /opt/prometheus/prometheus.yml
      chown prometheus:prometheus /opt/prometheus/prometheus.yml
      kill -1 $(pidof prometheus)
    SHELL
  end
  config.vm.define "grafana" do |grafana|
    grafana.vm.box = "centos/7"
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
    node.vm.box = "centos/7"
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
