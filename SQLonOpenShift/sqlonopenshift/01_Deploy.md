![](../graphics/microsoftlogo.png)

# Workshop: SQL Server 2019 on OpenShift (CTP 2.5)

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>Deploy SQL Server on OpenShift</h2>

You'll cover the following topics in this Module:

<dl>

  <dt><a href="#3-0">1.0 SQL Server Deployment on OpenShift</a></dt>
  
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3-0">1.0 SQL Server Deployment on OpenShift</a></h2>

In this module you will learn the fundamentals of how to deploy SQL Server on OpenShift. The SQL Server engine can be run in a container and on a Kubernetes cluster. In this module, you will learn the basic steps for how to deploy a SQL Server container in an OpenShift cluster. This module is required to complete Modules 2, 3, and 4 of the workshop.

In the deployment of SQL Server on OpenShift, you will:

- Create a new project to deploy SQL Server.
- Create a secret for the password to login to SQL Server
- Create a PersistentVolumeClaim where SQL Server databases and files will be stored
- Deploy a SQL Server container using a declarative .yaml file which will include a LoadBalancer service to connect to SQL Server.

 Kubernetes and OpenShift are *declarative* systems. You program how to run and manage objects in OpenShift using a command line tool like `oc`. Yaml files are used to declare how to build and manage objects through the Kubernetes API Server.

In the activity for this module, and others in the workshop, you will often complete exercises by *executing* `yaml` files using a command similar to this format:

`oc apply -f <file>.yaml`

Inside each `yaml` file is declarations of objects to deploy or commands to execute.

Proceed to the **Activity** below to learn these deployment steps.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Deploy SQL Server on OpenShift</a></b></p>

Follow these steps to deploy SQL Server on OpenShift:

>**NOTE**: *At any point in this Module if you need to "start over", use the script **cleanup.sh** to delete the project and go back the first step of the Activity.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Change directories for the scripts for this module</p>

Run the following command from the shell:

`cd ~/sqlworkshops/SQLonOpenShift/sqlonopenshift/01_deploy`

>**NOTE**: *You must log into the OpenShift cluster first, using instructions from the Prerequisites*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Ensure your scripts are executable</p>

Run the following command (depending on your Linux shell and client you may need to preface this with `sudo`):

`chmod u+x *.sh`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Create a new Project</p>

If you are running this workshop as a cluster admin and the instructor did not create a new project, then create a new project called **mssql** with the following command or execute the **step1_create_project.sh** script:

>**NOTE**: *This activity assumes a project named called mssql so if a cluster administrator will create a project for workshop users it must be called mssql.*

`oc new-project mssql`

When this completes, you should see the following messages and be placed back at the shell prompt.

   <pre>Using project "mssql" on server "https://[servername]".
   You can add applications to this project with the 'new-app' command. For example, try:
   oc new-app centos/ruby-25-centos7~https://github.com/sclorg/ruby-ex.git
   to build a new example application in Ruby.</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Create credentials</p>

Next you'll create a `secret` to store the System Administrator (**sa**) password. For this workshop, you will be connecting as the **sa** login. 

>**NOTE**: *In production SQL Server environments, you would not use the **sa** login.* 

Use the following command or execute the **step2_create_secret.sh** script:

`oc create secret generic mssql --from-literal=SA_PASSWORD="Sql2019isfast"`

>**NOTE**: *If you choose a different sa password then what is supplied in this activity, you will need to make changes to future steps which assume the password used in this step.*

When this completes you should see the following message and be placed back at the shell prompt:

<pre>secret/mssql created</pre>

**IMPORTANT**: *Take note of the value for **SA_PASSWORD** (without the quotes). The scripts in all modules use this password and you may need it to interactively work with SQL Server.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Create a <b>PersistentVolumeClaim</b> to store SQL Server databases and files</p>

A PersistentVolumeClaim allows you to persist SQL Server database files even if the container for SQL Server is stopped or moved by OpenShift.

Use the following command or execute the **step3_storage.sh** script:

`oc apply -f storage.yaml`

When this completes you should see the following message and be placed back at the shell prompt:

<pre>persistentvolumeclaim/mssql-data created</pre>

>**NOTE**: *The **PersistentVolumeClaim** created assumes the default **StorageClass** of the OpenShift cluster.*


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Deploy SQL Server</p>

Use the following command or execute the **step4_deploy_sql.sh** script to deploy SQL Server:

`oc apply -f sqldeployment.yaml`

When this completes, you should see the following messages and be placed back at the shell prompt:

<pre>
deployment.apps/mssql-deployment created
ervice/mssql-service created
</pre>

Deployment is an asynchronous operation. A complete of this command does not mean the deployment is complete.

You have now submitted a deployment, which is a logical collection of objects including a *pod*, a *container*, and **LoadBalancer** service. OpenShift will schedule a SQL Server container in a *pod* on a *node* on the cluster. 

Proceed to the next step to check whether the deployment was successful.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Verify the SQL Server deployment</p>

Check to see if the deployment succeeded by running the following command:

`oc get deployment mssql-deployment`

When the value of **AVAILABLE** becomes **1**, the deployment was successful and your container is running. 

>**NOTE**: *Depending on the load of your cluster and whether the container image of SQL Server is already present, the deployment may take several minutes. The first time you deploy SQL Server on a cluster requires the docker iamge to be pulled from the Microsoft container registry.*

Take a minute to browse the **sqldeployment.yaml** file to see key pieces of how SQL Server was deployed, including details of the container image, arguments, label to "tag" the deployment, which **PersistentVolumeClaim** to use (from the previous step) and the **LoadBalancer** service that is attached to this pod.

You can run the following command to check on the status of the pod and LoadBalancer service:

`oc get all`

You can also run the following command to track events in the cluster

`oc get event`

>**NOTE**: *It is possible for the deployment to be successful but the LoadBalancer is not created. When everything about this deployment is successful, the STATUS of the pod is **Running** and the **LoadBalancer** service has a valid IP address for **EXTERNAL-IP**.*

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/checkbox.png">Check the SQL Server logs</p>

The SQL Server database engine produces a file called the ERRORLOG when it starts. The ERRORLOG file can be used to gather interesting information about SQL Server or be used for troubleshooting. Since the output of the **ERRORLOG** is sent to stdout as part of running SQL Server as a container you can view these logs using OpenShift commands. Run the following commands to view the **ERRORLOG** or execute the script **step5_get_errorlog.sh**:

`POD=$(oc get pods | grep mssql | awk {'print $1'})`<br>
`oc logs $POD`<br>

The ERRORLOG will scroll across the screen and you can scroll up in your shell to see all the output, or pipe the command to the `less` or `more` command in Linux.

A *pod* with a SQL Server container is now deployed and a **LoadBalancer** service is attached to the pod. The LoadBalancer will be a key component to connecting to SQL Server no matter where the pod is running in the cluster.

>**NOTE**: *Do not proceed to the next Module until you have a valid IP address for the **EXTERNAL-IP** value for the **LoadBalancer** service. The value will say pending while it is being created. One some OpenShift cluster systems this process can take a few minutes.*

You can now proceed to **Next Steps** to Connect and Query SQL Server on OpenShift.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>

- [Quickstart: Run SQL Server container images with Docker](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-linux-ver15&pivots=cs1-bash)
- [Deploy a SQL Server container in Kubernetes with Azure Kubernetes Services (AKS)](https://docs.microsoft.com/en-us/sql/linux/tutorial-sql-server-containers-kubernetes?view=sql-server-2017)
- [How Deployments Work in OpenShift](https://docs.openshift.com/online/dev_guide/deployments/how_deployments_work.html)
- [Using a LoadBalancer in OpenShift](https://docs.openshift.com/container-platform/3.11/dev_guide/expose_service/expose_internal_ip_load_balancer.html)
- [Using PersistentVolumeClaims in OpenShift](https://docs.openshift.com/container-platform/3.11/dev_guide/persistent_volumes.html)

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="02_Query.md" target="_blank"><i>Connect and Query</i></a>.
