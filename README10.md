#sea_country

mix phx.new sea_country --live

mix phx.gen.live Playground Country countries name:string code:string

 mix phx.gen.release --docker --no-ecto


#docker locally
export FUSEKI_PASSWORD=alain
export DIGITAL_OCEAN_IP_ADDRESS=134.122.65.198

docker stop $(docker ps -q -a -f name="sea_fuseki_container");
docker rm $(docker ps -q -a -f name="sea_fuseki_container");
docker network create sea_network

docker run -d --name sea_fuseki_container -p 3030:3030 -e ADMIN_PASSWORD=$FUSEKI_PASSWORD --network sea_network helpys/jena-fuseki
curl -s 'http://$DIGITAL_OCEAN_IP_ADDRESS:3030/$/datasets' -H "Authorization: Basic $(echo -n admin:alain | base64)" -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' --data "dbName=example&dbType=tdb"

result=$(apache_jena_script/s-query --service http://sea_fuseki_container:3030/example/query "$sparql")
