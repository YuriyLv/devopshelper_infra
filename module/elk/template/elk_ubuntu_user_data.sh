#!/bin/bash
#________________________update
sudo apt-get update
sudo apt-get upgrade -y

#________________________Install necessary packages
sudo apt-get install -y git curl wget tar adduser libfontconfig1 ansible awscli

#________________________ssm
sudo apt-get update && sudo apt-get upgrade
sudo snap install -y amazon-ssm-agent --classic
sudo snap start amazon-ssm-agent

#________________________node_exporter
sudo useradd --no-create-home --shell /bin/false node_exporter
# Download node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
sudo tar xvf node_exporter-1.5.0.linux-amd64.tar.gz
sudo cp node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin
# Set user and group ownership to node_exporter user
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
# Delete downloaded file
sudo rm -rf node_exporter-1.5.0.linux-amd64.tar.gz node_exporter-1.5.0.linux-amd64
#Create_service_for_node_exporter
cat <<EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target
[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

#________________________elk