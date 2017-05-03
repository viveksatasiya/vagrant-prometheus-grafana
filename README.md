# vagrant-prometheus-grafana
Vagrant setup for prometheus &amp; grafana

### Prerequisites
I used vagrant so that I can easily create my prometheus & grafana setup without affecting my actual host os. I can also used it for distributing my exact same development environment to other developers. Vagrant provisions & manages vitual machines easily and it depends on virtualbox/vmware to run machines. I used virtualbox to run machines. Here are the links to install for both

* [Vagrant](https://www.vagrantup.com/intro/getting-started/install.html) - Vagrant manages virtual machines 
* [Virtualbox](https://www.virtualbox.org/wiki/Linux_Downloads) - Vagrant depends on virtualbox to run virtual machines 

### Installing

First install vagrant and virtualbox on your machine. 

After installing vagrant, just clone this github repo.

```
git clone https://github.com/viveksatasiya/vagrant-prometheus-grafana.git
cd vagrant-prometheus-grafana/
vagrant up
```

vagrant up command will download precise64 box which is ubuntu machine and run provision.sh file to install and configure prometheus & grafana into the virtual machine. 

After successful installation, you can visit urls on your host os which are mentioned below to see prometheus & grafana dashboard

```
Prometheus - http://localhost:9090/
Grafana - http://localhost:3000/
```

Ports 9090 & 3000 are exposed and bound to the host os via Vagrantfile so we can access dashboards from virtual machine to host os.

If you want to edit any configuration in virtual machine then you can do ssh via following command from the same git directory.You will get remote shell of ubuntu virtual machine from host os.

```
vagrant ssh
```

Default username & password for grafana is **admin**

Currently prometheus server is pulling metrics from node-exporter which is installed locally into the virtual machine so you can get all the metrics of that virtual machine. If you want to get metrics from other os, you need to change targets which is written into provision.sh file.