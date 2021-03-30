version=1.1.2

useradd -rs /bin/false node_exporter
curl -LO https://github.com/prometheus/node_exporter/releases/download/v${version}/node_exporter-${version}.linux-amd64.tar.gz
mkdir -p /opt/node_exporter
tar -xzf node_exporter-${version}.linux-amd64.tar.gz -C /opt/node_exporter --strip 1
chown node_exporter:node_exporter -R /opt/node_exporter

cat > /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/opt/node_exporter/node_exporter

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter
