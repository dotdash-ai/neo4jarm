# Install Docker
bash <(curl -fsSL https://get.docker.com)

sudo docker run \
    --name testneo4jext \
    -p7474:7474 -p7687:7687 \
    -d \
    -e NEO4J_AUTH=none \
    -e 'NEO4JLABS_PLUGINS=["apoc", "graph-data-science"]' \
    neo4j:5.3.0-community
