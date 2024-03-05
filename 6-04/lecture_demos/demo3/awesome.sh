git clone https://github.com/vegasbrianc/prometheus.git
cd ./prometheus

docker compose up -d &&  sleep 180 && docker compose down -v && rm -rf prometheus