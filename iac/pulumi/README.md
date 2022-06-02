# pulumi-and-databricks

This is a basic example of creating an Azure Reource Group and Databricks workspace using Pulumi

To get started download the Pulumi cli https://www.pulumi.com/docs/get-started/install/

The Pulumi Azure getting started guide can be found here https://www.pulumi.com/docs/get-started/azure/

Make sure the following python packages are installed:

1. pulumi>=3.0.0,<4.0.0
2. pulumi-databricks>=0.4.0,<0.4.0

Pulumi relies on the Databricks SDK to authenticate requests from your computer to Databricks. Your credentials are never sent to pulumi.com. The Pulumi Databricks Provider needs to be configured with Databricks credentials before it can be used to create resources. Once the credentials obtained, there are two ways to communicate your authorization tokens to Pulumi:

Set the environment variables DATABRICKS_HOST and DATABRICKS_TOKEN:

export DATABRICKS_HOST=XXXXXXXXXXXXXX
export DATABRICKS_TOKEN=YYYYYYYYYYYYYY
Copy
Set them using configuration, if you prefer that they be stored alongside your Pulumi stack for easy multi-user access:

pulumi config set databricks:token YYYYYYYYYYYYYY --secret
pulumi config set databricks:host XXXXXXXXXXXXXX
Copy
Remember to pass --secret when setting databricks:token so that it is properly encrypted. The complete list of configuration parameters is in the Databricks Provider README.

For more examples visit https://www.pulumi.com/registry/packages/databricks/api-docs

Run "pulumi up" in a terminal that is in the correct folder


dapi9b481395d582fd42d95e984b05b1d615

