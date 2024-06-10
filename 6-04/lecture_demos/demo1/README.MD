docker run -d \
  --net="host" \
  --pid="host" \
  --name node_exporter \
  -v "/:/host:ro,rslave" \
  quay.io/prometheus/node-exporter:latest \
  --path.rootfs=/host

docker run -d \
  --net="host" \
  --pid="host" \
  --name pushgateway \
  prom/pushgateway


docker run -d \
  --net="host" \
  --pid="host" \
  --name alertmanager \
  quay.io/prometheus/alertmanager

docker run -d \
  --net="host" \
  --pid="host" \
  -v ./prometheus.yml:/etc/prometheus/prometheus.yml \
  -v ./alert_rules.yml:/etc/prometheus/alert_rules.yml \
  --name prometheus \
  prom/prometheus

docker run -d \
  --net="host" \
  --pid="host" \
  --name=grafana \
  -v ./custom.ini:/etc/grafana/grafana.ini \
  grafana/grafana

ss -tlpn
curl http://127.0.0.1:9100/metrics
curl http://127.0.0.1:9091/metrics

docker restart prometheus

https://grafana.com/grafana/dashboards/1860-node-exporter-full/
https://www.yamllint.com/
https://guifier.com/yaml
https://github.com/samber/awesome-prometheus-alerts

docker container rm -f prometheus && docker container rm -f node_exporter && docker container rm -f pushgateway && docker container rm -f grafana && docker container rm -f alertmanager