# Install Docker
bash <(curl -fsSL https://get.docker.com)

sudo docker pull neo4j:5.3.0-community

sudo docker run -it --rm \
    --publish=7474:7474 --publish=7687:7687 \
    --user="$(id -u):$(id -g)" \
    -e NEO4J_AUTH=none \
    -e NEO4J_apoc_export_file_enabled=true \
    -e NEO4J_apoc_import_file_enabled=true \
    -e NEO4J_apoc_import_file_use__neo4j__config=true \
    -e NEO4JLABS_PLUGINS=\[\"apoc\", \"graph-data-science\"\]
