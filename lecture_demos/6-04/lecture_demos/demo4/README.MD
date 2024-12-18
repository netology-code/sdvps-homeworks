docker rm -f $(docker ps -a -q)

cd ./prometheus && docker compose  up -d

#admin foobar