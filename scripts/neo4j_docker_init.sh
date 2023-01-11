# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
echo "Docker installed"

sudo docker run \
    --name testneo4jext \
    -p7474:7474 -p7687:7687 \
    -d \
    -e NEO4J_AUTH=none \
    -e 'NEO4JLABS_PLUGINS=["apoc", "graph-data-science"]' \
    neo4j:5.3.0-community
echo "neo4j container running, give it about 20 seconds to set-up"
