![](../graphics/microsoftlogo.png)

# Workshop: SQL Server Big Data Clusters - Architecture (CTP 3.2)

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>Planning, Installation and Configuration</h2>

In this workshop you'll cover using a Process and various Platform components to create a Big Data Cluster for SQL Server (BDC) solution you can deploy on premises, in the cloud, or in a hybrid architecture. In each module you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic.

(<a href="https://github.com/Microsoft/sqlworkshops/blob/master/sqlserver2019bigdataclusters/SQL2019BDC/00%20-%20Prerequisites.md" target="_blank">Make sure you check out the <b>prerequisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)

You'll cover the following topics in this Module:

<dl>

  <dt><a href="#3-0">3.0 Planning your Installation</a></dt>
  <dt><a href="#3-1">3.1 Installing on Azure Kubernetes Service</a></dt>
  <dt><a href="#3-2">3.2 Installing locally using KubeADM</a></dt>
  <dt><a href="#aks">Install Class Environment on AKS</a></dt>

</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3-0">3.0 Planning your Installation</a></h2>

<i>NOTE: The following Module is based on the Public Preview of the Microsoft SQL Server 2019 big data cluster feature. These instructions will change as the product is updated for the final release. <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/deploy-get-started?view=sqlallproducts-allversions" target="_blank">The latest installation instructions are located here</a>.</i>

A Big Data Cluster for SQL Server (BDC) is deployed onto a Kubernetes Cluster using the `azdata` utility which creates the appropriate Docker Containers and other constructs for the system. The installation uses various switches on the `azdata` utility, and reads from several variables contianed within <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/reference-deployment-config?view=sqlallproducts-allversions" target="_blank">an internal JSON document</a> when you run the command. Using a switch, you can change these variables. You can also dump the enitre document to a file, edit it, and then call the installation that uses that file with the `azdata` command. <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-custom-configuration?view=sqlallproducts-allversions" target="_blank">More detail on that process is located here.</a> 

For planning, it is essential that you understand the SQL Server BDC components, and have a firm understanding of Kubernetes and TCP/IP networking. You should also have an understanding of how SQL Server and Apache Spark use the "Big Four"  (*CPU, I/O, Memory and Networking*). 

Since the Kubernetes Cluster is often made up of Virtual Machines that host the Docker Images, they must be as large as possible. For the best possible performance, large physical machines that are tuned for optimal performance is a recommended physical architecture. The least viable production system is a Minimum of 3 Linux physical machines or virtual machines. The recommended configuration per machine is 8 CPUs, 32 GB of memory and 100GB of storage. This configuration would support only one or two users with a standard workload, and you would want to increase the system for each additional user or heavier workload. 


You can deploy Kubernetes in a few ways:

 - In a Cloud Platform such as Azure Kubernetes Service (AKS)

 - In your own Kubernetes deployment using `KubeADM`

Regardless of the Kubernetes target, the general steps for setting up the system are:

 - Set up Kubernetes cluster

 - Install the cluster tools on the administration machine

 - Deploy the BDC onto the Kubernetes cluster

In the sections that follow, you'll cover the general process for each of these deployments. The official documentation referenced above have the specific steps for each deployment, and the *Activity* section of this Module has the steps for deploying the BDC on AKS for the classroom enviornment.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3-1">3.1 Installing on Azure Kubernetes Service</a></h2>

The <a href="https://docs.microsoft.com/en-us/azure/aks/concepts-clusters-workloads" target="_blank">Azure Kubernetes Service</a> provides the ability to create a Kubernetes cluster in the Azure portal, with the Azure CLI, or template driven deployment options such as Resource Manager templates and Terraform. When you deploy an AKS cluster, the Kubernetes master and all nodes are deployed and configured for you. Additional features such as advanced networking, Azure Active Directory integration, and monitoring can also be configured during the deployment process.

An AKS cluster is divided into two components: The *Cluster master nodes* which provide the core Kubernetes services and orchestration of application workloads; and the *Nodes* which run your application workloads. 

<br>
<img style="height: 200; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="../graphics/aks1.png">
<br>

The cluster master includes the following core Kubernetes components:

 - *kube-apiserver* - The API server is how the underlying Kubernetes APIs are exposed. This component provides the interaction for management tools, such as kubectl or the Kubernetes dashboard.

 - *etcd* - To maintain the state of your Kubernetes cluster and configuration, the highly available etcd is a key value store within Kubernetes.

 - *kube-scheduler* - When you create or scale applications, the Scheduler determines what nodes can run the workload and starts them.

 - *kube-controller-manager* - The Controller Manager oversees a number of smaller Controllers that perform actions such as replicating pods and handling node operations.

The Nodes include the following components: 

 - The *kubelet* is the Kubernetes agent that processes the orchestration requests from the cluster master and scheduling of running the requested containers.

 - Virtual networking is handled by the *kube-proxy* on each node. The proxy routes network traffic and manages IP addressing for services and pods.

 - The *container runtime* is the component that allows containerized applications to run and interact with additional resources such as the virtual network and storage. In AKS, Docker is used as the container runtime.

<br>
<img style="height: 100; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="../graphics/aks2.png">
<br>

In the BDC in an AKS environment, for an optimal experience while validating basic scenarios, you should use at least three agent VMs with at least 4 vCPUs and 32 GB of memory each. 

With this background, you can find the <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/deploy-on-aks?view=sqlallproducts-allversions" target="_blank">latest specific steps to deploy a BDC on AKS here</a>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3-2">3.2 Installing Locally Using KubeADM</h2>

The <a href="https://kubernetes.io/docs/setup/independent/install-kubeadm/" target="_blank">kubeadm toolbox</a> helps you bootstrap a Kubernetes cluster that conforms to best practices. Kubeadm also supports other cluster lifecycle functions, such as upgrades, downgrade, and managing bootstrap tokens.

The kubeadm toolbox can deploy a Kubernetes cluster to physical or virtual machines. It works by specifying the TCP/IP addresses of the targets. 

With this background, you can find the <a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/deploy-with-kubeadm?view=sqlallproducts-allversions" target="_blank">latest specific steps to deploy a BDC using kubeadm here</a>.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Check Class Environment on AKS</a></b></p>

In this lab you will check your deployment you performed in Module 01 of the BDC on the Azure Kubernetes Service. 

Using the following steps, you will evaluate your Resource Group in Azure that holds your BDC on AKS that you deployed earlier. When you complete your course you can delete this Resource Group which will stop the Azure charges for this course. 

<b>Steps</b>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png"> <a href="https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes" target="_blank">Log in to the Azure Portal, and locate the <i>Resource Groups</i> deployed for the AKS cluster</a>. How many do you find? What do you think their purposes are?</p>
 
<br>
<p style="border-bottom: 1px solid lightgrey;"></p>
<br>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>
<ul>
    <li><a href="https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-guidance?view=sqlallproducts-allversions" target="_blank">Official Documentation for this section</a></li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="04%20-%20Operationalization.md" target="_blank"><i> Operationalization</i></a>.
