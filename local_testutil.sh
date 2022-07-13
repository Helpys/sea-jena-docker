#!/bin/sh

# execute testutil locally
export FUSEKI_PASSWORD=Alain
export FUSEKI_HOST=http://localhost
export GRAPHQL_HOST=http://localhost

docker stop $(docker ps -a -q); \
docker rm $(docker ps -a -q); \
docker volume rm $(docker volume ls -q); \
docker rmi $(docker images -a -q);

docker network create sea_network || true
docker run -d --name sea_fuseki_container -p 3030:3030 -e ADMIN_PASSWORD=$FUSEKI_PASSWORD --network sea_network helpys/jena-fuseki

./testutil.sh
