docker rm -f $(docker ps -a -q)
git clone https://github.com/vegasbrianc/prometheus.git
cd ./prometheus

docker compose up -d

#admin foobar