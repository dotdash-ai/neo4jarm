# Azure ARM Ubuntu VM running Neo4j in a Docker container w/ peristent storage

## Deployment
1. Clone this git to a local folder.
2. Adapt the input parameters in `neo4jarm.parameters.json` to your liking.
3. Change the resource group in `azure_cli_create_setup.azcli` to where you want to deploy this solution.
4. Open a bash/zsh terminal. Important: do not use the "Azure Cloud Shell" option, as this will run remotely, i.e. you won't have access to the scripts you just cloned.
5. Login to the Azure CLI: `az login` (a web page will open). If you don't have the Azure CLI installed, follows [this link](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
6. Run the following command to deploy the ARM template: `sh azure_cli_create_setup.azcli`.

## Spark Connector
1. In order to use the Neo4j db in Databricks, take a look at [this table](https://neo4j.com/docs/spark/current/overview/#_spark_and_scala_compatibility) to determine the correct Spark Connector for your Databricks environment. ! It's imperative to select the correct version or your queries will fail!
2. Once you have determinded the correct version, you can download the corresponding `.jar` file from [this](https://github.com/neo4j-contrib/neo4j-spark-connector/releases) page.
3. Navigate to your Databricks instance > Compute > select the relevant compute instance > Libraries > Install new > select "Upload" & "JAR" > drag and drop the `.jar` from the previous step > Install
4. Still in Databricks: New (+ icon) > Notebook > Default Language: Scala; Cluster: {whichever cluster you just installed the `.jar` file to}
5. Make sure the cluster is up and running
6. Test the connection: replace "localhost" in the following code by the public IP of the VM you deployed earlier on Azure.
```Scala
%scala
import org.apache.spark.sql.{SaveMode, SparkSession}

val spark = SparkSession.builder().getOrCreate()

spark.read.format("org.neo4j.spark.DataSource")
  .option("url", "bolt://localhost:7687")
  .option("query", "MATCH (n) RETURN n")
  .load()
  .show()
```
7. If all went well, you should see a table as ouput with the top 20 matches.
8. Read the "[Reading from Neo4j](https://neo4j.com/docs/spark/current/reading/)" documentation page to get started with your own queries.

## To Do
- Include the option for an auto-shutdown of the VM.
- Update template to implement best-practices for structuring.
- Use the generated storage account to save all neo4j data, rather than the VM disk, so it's accessible.
- Include the `uniqueString` function to make sure names are unique.

## Debugging
- If you get a `Permissions XXXX for '~/.ssh/some_private_key' are too open.`, you need to apply the following command: `chmod 600 ~/.ssh/some_private_key`
- The custom ARM script is downloaded to `/var/lib/waagent/custom-script/download/0`, as it's a protected dir you need to access it using a root environment `sudo -i`
- The logs of the custom ARM scripts are located in `/var/log/azure/custom-script/handler.log`