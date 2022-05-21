- name: Test jena-fuseki usind SOH
  env:
    SSH_AUTH_SOCK: /tmp/ssh_agent.sock
  run: |
    ssh -o StrictHostKeyChecking=no root@${{ secrets.DIGITAL_OCEAN_IP_ADDRESS }} << 'ENDSSH'
      cd /app
      source .env
      echo XXXXXXX01
      docker exec $(docker ps -q) test -f && echo "yes" || echo "no"
      docker exec $(docker ps -q) ruby -v
      docker exec $(docker ps -q) ls -lat
      docker exec $(docker ps -q) echo HELLO-WORLD
      docker exec $(docker ps -q) ls -lat test
      docker exec $(docker ps -q) ls -lat bin
      docker exec $(docker ps -q) ls -lat configuration
      docker exec $(docker ps -q) echo DIGITAL_OCEAN_IP_ADDRESS ==> ${{ secrets.DIGITAL_OCEAN_IP_ADDRESS }}
      docker exec $(docker ps -q) bin/s-put http://localhost:3030/example/data default test/turtle_example.ttl
      docker exec $(docker ps -q) bin/s-get http://localhost:3030/example/data default
      docker exec $(docker ps -q) bin/s-query --service http://localhost:3030/example/query 'SELECT * {?s ?p ?o}'
      docker exec $(docker ps -q) test/base_test.sh
      echo YYYYYYY02
    ENDSSH


docker exec $(docker ps -q) test/base_test.sh | xargs -I % test % = "ok" && echo "OKIDOKI" || echo "NONONO"
