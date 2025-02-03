
## Compile wrk2

cd ../wrk2
make


## python venv

source dsb-venv/bin/activate
python3 -m venv dsb-venv

pip install aiohttp

deactivate

## Fix jaeger version

change latest to 1.62.0



sudo docker-compose up -d

python3 scripts/init_social_graph.py --graph socfb-Reed98

../wrk2/wrk -D exp -t 120 -c 400 -d 30 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R 2

sudo docker rm -v -f $(sudo docker ps -qa)





## Compile dockers from source

sudo apt install libthrift-dev
sudo apt install thrift-compiler

sudo  apt-get install libmongoc-dev
sudo  apt-get install libbson-dev
sudo  apt-get install libbson-1.0-0
sudo apt install nlohmann-json3-dev


sudo apt install librabbitmq-dev



# Build the microservices : 

sudo docker build -t social-network-cust Dockerfile
sudo docker compose -f docker-compose-cust.yml up -d


# Setup the initial network : 

python3 scripts/init_social_graph.py --graph socfb-Reed98

# Generate load : 

../wrk2/wrk -D exp -t 120 -c 400 -d 30 -L -s ./wrk2/scripts/social-network/compose-post.lua http://localhost:8080/wrk2-api/post/compose -R 2


# Ports : 

web 8080
jaeger 16686
media 8081