# Azure ARM Ubuntu VM running Neo4j in a Docker container w/ peristent storage

## Deployment
1. Clone this git to a local folder.
2. Adapt the input parameters in `neo4jarm.parameters.json` to your liking.
3. Change the resource group in `azure_cli_create_setup.azcli` to where you want to deploy this solution.
4. Open a bash/zsh terminal. Important: do not use the "Azure Cloud Shell" option, as this will run remotely, i.e. you won't have access to the scripts you just cloned.
5. Login to the Azure CLI: `az login` (a web page will open).
6. Run the following command to deploy the ARM template: `sh azure_cli_create_setup.azcli`.

## To Do
- Include the option for an auto-shutdown of the VM
- Udate template to impleemnt best-practices
- Implement an SSH key generation on start-up
- USe the generated storage account to save all neo4j data, rather than the VM disk, so it's accessible.