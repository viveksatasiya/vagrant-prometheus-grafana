#!/usr/bin/env bash
sudo apt-get update

echo $HOME
mkdir /home/vagrant/Downloads
cd /home/vagrant/Downloads

wget https://github.com/prometheus/prometheus/releases/download/0.15.1/prometheus-0.15.1.linux-amd64.tar.gz

mkdir -p /home/vagrant/Prometheus/server
cd /home/vagrant/Prometheus/server

tar -xvzf /home/vagrant/Downloads/prometheus-0.15.1.linux-amd64.tar.gz

./prometheus -version

mkdir -p /home/vagrant/Prometheus/node_exporter
cd /home/vagrant/Prometheus/node_exporter

wget https://github.com/prometheus/node_exporter/releases/download/0.11.0/node_exporter-0.11.0.linux-amd64.tar.gz -O /home/vagrant/Downloads/node_exporter-0.11.0.linux-amd64.tar.gz


tar -xvzf /home/vagrant/Downloads/node_exporter-0.11.0.linux-amd64.tar.gz

sudo ln -s /home/vagrant/Prometheus/node_exporter/node_exporter /usr/bin

cat <<EOF > /etc/init/node_exporter.conf
# Run node_exporter

start on startup

script
   /usr/bin/node_exporter
end script
EOF

sudo service node_exporter start

cd /home/vagrant/Prometheus/server

cat <<EOF > /home/vagrant/Prometheus/server/prometheus.yml
scrape_configs:
  - job_name: "node"
    scrape_interval: "15s"
    target_groups:
    - targets: ['localhost:9100']
EOF

nohup ./prometheus > prometheus.log 2>&1 &

wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_4.2.0_amd64.deb -O /home/vagrant/Downloads/grafana_4.2.0_amd64.deb

sudo apt-get install -y adduser libfontconfig

sudo dpkg -i /home/vagrant/Downloads/grafana_4.2.0_amd64.deb

sudo service grafana-server start

sudo update-rc.d grafana-server defaults