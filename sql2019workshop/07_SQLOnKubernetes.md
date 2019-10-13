![](../graphics/microsoftlogo.png)

# Workshop: SQL Server 2019 Workshop

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"><b>     SQL Server on Kubernetes</b></h2>

Kubernetes is an open source container orchestration engine for automating deployment, scaling, and management of containerized applications. The open source project is hosted by the Cloud Native Computing Foundation (CNCF).
 
Kubernetes comes with built-in basic high-availability, networking, storage, and container interfaces. You can read more about the Kubernetes platform at https://kubernetes.io/.

Kubernetes is deployed in both private and public clouds. It could be you deploying your own open-source Kubernetes cluster using or using Kubernetes in a cloud service like Azure Kubernetes Service (AKS).

A Kubernetes deployment is known as a cluster and consists of software components to run the cluster, and various objects such as nodes, pods, services, and storage.

In this module you will learn how to deploy, use, manage a SQL Server running in Kubernetes.

You will cover the following topics in this Module:

<dl>

  <dt><a href="#7-0">7.0 Deploying SQL Server on Kubernetes</a></dt>
  <dt><a href="#7-1">7.1 SQL Server High Availability on Kubernetes</a></dt>
    
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="7-0">     7.0 Deploying SQL Server on Kubernetes</a></b></h2>

Since SQL Server supports containers as a stateful application it is a perfect fit to deploy and use on a Kubernetes platform.

<h3><b><a name="challenge">The Challenge</a></b></h3>

Users that want to deploy SQL Server containers need a platform that supports built-in high availability, networking, and storage to power a SQL Server database. Users and developers who want to deploy multiple SQL Server containers need a scalable platform instead of having to manage all the containers manually.

<h3><b><a name="solution">The Solution</a></b></h3>

Kubernetes is a natural fit for these challenges. Kubernetes support built-in high availability through a concept called a ReplicaSet or StatefulSet using persistent volume storage.

Kubernetes comes built-in with networking services such as a Load Balancer and NodePort to expose connection information to a SQL Server no matter what it lives in the cluster.

Kubernetes is available as a consistent platform to run a SQL Server container on private and public clouds and supports built-in scalability for clusters needing hundreds or even thousands of containers. Kubernetes is the platform that powers SQL Server Big Data Clusters which you will learn more about in Module 09 of this workshop.

In this module you will learn the fundamentals of how to deploy and use a SQL Server container in a Kubernetes cluster. This module also includes activities to learn the built-in basic high availability Kubernetes provides SQL Server as a container application.

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activity7.0">     Activity: Deploying SQL Server on Kubernetes</a></b></h2>

In this activity you will learn the basics of how to deploy a SQL Server container in a Kubernetes cluster. You will learn various aspects of deploying in Kubernetes including common patterns such a namespace, node, pod, service, persistent volume claim, deployment, and ReplicaSet.

This activity is designed to be used with an Azure Kubernetes Service (AKS) cluster but most of the scripts and steps can be used with any Kubernetes cluster. This activity only requires a single-node Kubernetes cluster with only 6Gb RAM. Therefore this activity could be used even on a minikube cluster. While this module could be used on a RedHat OpenShift cluster you should use the workshop specifically designed for RedHat OpenShift at https://github.com/Microsoft/sqlworkshops/tree/master/SQLonOpenShift.

One of the key elements to using Kubernetes is declarative programming. The **kubectl** tool communicates with the Kubernetes API Server to execute API in the cluster. Much of the API can be executed by applying a YAML file. You will use kubectl and a series of command and YAML files to deploy a pod with a SQL Server Container.

This activity assumes the following:

- You have access to a Kubernetes cluster
- You have installed the **kubectl** tool on your preferred client whether that be Windows, Linux, or MacOS. You can read more about how to install kubectl at https://kubernetes.io/docs/tasks/tools/install-kubectl/. Kubectl needs to be in the path on your computer.

>**NOTE**: *If at anytime during the Activities of this Module you need to "start over" you can run the script **cleanup.ps1** or **cleanup.sh** and go back to the first Activity in 7.0 and run through all the steps again.*

<h3><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="actvitysteps7.0">Activity Steps</a></b></h3>

All scripts for this activity can be found in the **sql2019workshop\07_SQLOnKubernetes\deploy** folder.

There are two subfolders for scripts to be used in different shells:

- **powershell** - Use scripts here for kubectl on Windows
- **bash** - Use these scripts for kubectl on Linux or MacOS

In this module, you will see the steps for kubectl on Powershell but the same sequence can be used with bash shell scripts:

**STEP 1: Connect to the cluster**

Consult your administrator for how to connect to your Kubernetes cluster. For Azure Kubernetes Service (AKS) you will use the Azure CLI (az) to get credentials to use kubectl. Modify the script **step1_connectcluster.ps1** to put in your *clustername* and *resource group*. 

*>**NOTE**: For instructor led workshops, you instructor will provide you the name of the Azure Resource Group and AKS cluster name.*

Run the script **step1_connectcluster.ps1** which runs the following command:

```powershell
az aks get-credentials --resource-group <resource group> --name <clustername>
```
For example, if your r*esource group* is called **myaksrg** and your *clustername* is called **myaks**, the command should look like this:

```powershell
az aks get-credentials --resource-group myaksrg --name myaks
```

When this command completes you should see a message like

<pre>Merged *clustername* as current context in *path*\.kube\config</pre>

where path is the *path* to your home directory on your computer.

**STEP 2: Create a namespace**

A Kubernetes namespace is a scope object to organize your Kubernetes deployment and objects from other deployments. Run the script **step2_create_namespace.ps1** which runs the following command:

```powershell
kubectl create namespace mssql
```
When this command completes you should see a message like

<pre>namespace/mssql created</pre>

**STEP 3: Set the default context**

To now deploy in Kubernetes you can specify which namespace to use with parameters. But there is also a method to set the *context* to the new namespace. Modify the script **step3_context.ps1** to put in your <clustername> and <resource group>.

*>**NOTE**: For instructor led workshops, you instructor will provide you the name of the Azure Resource Group and AKS cluster name.*

Run the script **step3_setcontext.ps1** which runs these commands:

```Powershell
kubectl config set-context mssql --namespace=mssql --cluster=<clustername> --user=clusterUser_<resource group>_<clustername>
kubectl config use-context mssql
```

For example if your resource group is called **myaksrg** and your clustername is **myaks**, the following script should be modified to look like this:

```Powershell
kubectl config set-context mssql --namespace=mssql --cluster=myaks --user=clusterUser_myaksrg_myaks
kubectl config use-context mssql
```
When this command completes you should see messages like

<pre>Context "mssql" created.
Switched to context "mssql".</pre>

**STEP 4: Create a Load Balancer Service**

Deploy objects in Kubernetes is done in a declarative fashion. One of the key objects to create is a LoadBalancer service which is supported by default in Azure Kubernetes Service (AKS). A LoadBalancer provides a static public IP address mapped to a public IP address in Azure. You will be able to map the LoadBalancer to a SQL Server deployment including a port to map to the SQL Server port 1433. Non-cloud Kubernetes clusters also support a similar concept called a NodePort.

Run the script step4_create_service.ps1 to create the Load Balancer. This script uses the following command to create the LoadBalancer

```Powershell
kubectl apply -f sqlloadbalancer.yaml --record
```
This is an example of declarative programming with Kubernetes. The contents of the sqlloadbalancer.yaml file looks like this:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mssql-service
spec:
  selector:
    app: mssql
  ports:
    - protocol: TCP
      port: 31433
      targetPort: 1433
  type: LoadBalancer
```
The **kind:Service** is the built-in support for a Service in Kubernetes with a **type: LoadBalancer**. The name of the service is mssql-service which you will use when deploying the pod later in this Activity. The **app:mssql** is a *label* which can be used for various ways to refer to a collection of objects of the same project. Finally, the **ports:** section declares the protocol and how to map a public port to the port in the container of the pod which for SQL Server is 1433.

When this command completes you should see a message like:

<pre>service/mssql-service created</pre>

The creation of the LoadBalancer service happens in the background. You will check the status of this service being created later in this Activity.

STEP 5: Create a secret to hold the sa password

STEP 6: Create persistent storage for databases

STEP 7: Deploy a pod with a SQL Server container

STEP 8: Look at logs from the pod

STEP 9: Look at events from the cluster

STEP 10: Look at details of the deployment

STEP 11: Look at details of the pod

STEP 12: Run a query against SQL Server

TODO: Copy in a database backup and restore it

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

xxxxxxxxxxx

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><b><a name="7-1">     7.1 SQL Server High Availability on Kubernetes</a></b></h2>

xxxxxxxxxx

<h3><b><a name="challenge">The Challenge</a></b></h3>

xxxxx

<h3><b><a name="solution">The Solution</a></b></h3>

xxxxxx

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b><a name="activity7.1">     Activity: Testing High Availability for SQL Server on Kubernetes</a></b></h2>

XXXXXXXXX

>**NOTE**: *If at anytime during the Activities of this Module you need to "start over" you can go back to the first Activity in 3.0 and run through all the steps again.*

<h3><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b><a name="actvitysteps7.1">Activity Steps</a></b></h3>

All scripts for this activity can be found in the **sql2019workshop\07_SQLOnKubernetes\ha** folder.

When you are done proceed to the **Activity Summary** section for the Activity below.

<h3><b><a name="activitysummary">Activity Summary</a></b></h3>

xxxxxxxxxxx

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>     For Further Study</b></h2>

- [Accelerated Databased Recovery](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-accelerated-database-recovery)

- [The Constant Time Recovery Paper](https://www.microsoft.com/en-us/research/publication/constant-time-recovery-in-azure-sql-database )

- [What is Azure Data Studio?](https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is)

- [How to use Notebooks in Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/sql-notebooks)

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b>     Next Steps</b></h2>

Next, Continue to <a href="08_DataVirtualization.md" target="_blank"><i>Data Virtualization</i></a>.
