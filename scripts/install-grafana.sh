version=7.4.5-1

yum install -y https://dl.grafana.com/oss/release/grafana-${version}.x86_64.rpm
systemctl daemon-reload
systemctl enable grafana-server
systemctl start grafana-server
