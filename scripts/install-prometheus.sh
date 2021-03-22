version=2.25.2

useradd -rs /bin/false prometheus
curl -LO https://github.com/prometheus/prometheus/releases/download/v${version}/prometheus-${version}.linux-amd64.tar.gz
mkdir -p /opt/prometheus/data
tar -xzf prometheus-${version}.linux-amd64.tar.gz -C /opt/prometheus --strip 1
chown prometheus:prometheus -R /opt/prometheus

cat > /etc/systemd/system/prometheus.service << EOL
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/opt/prometheus/prometheus \
    --config.file /opt/prometheus/prometheus.yml \
    --web.console.templates=/opt/prometheus/consoles/ \
    --web.console.libraries=/etc/prometheus/console_libraries/ \
    --storage.tsdb.path /opt/prometheus/data/ \
    --storage.tsdb.retention.time=2d \
    --storage.tsdb.wal-compression \
    --log.level=warn

[Install]
WantedBy=multi-user.target
EOL

systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus
