![](../graphics/microsoftlogo.png)

# Workshop: SQL Server on OpenShift

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

 Kubernetes and OpenShift are *declarative* systems. You program how to run and manage objects in OpenShift using a command line tool like oc. yaml files are used to declare how to build and manage objects through the Kubernetes API Server.

In the activity for this module and others in the workshop you will often complete exercises by *executing* yaml files using a command like

`oc apply -f <file>.yaml`

Inside each yaml file is declarations of objects to deploy or commands to execute.

Proceed to the Activity to learn these deployment steps.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Deploy SQL Server on OpenShift</a></b></p>

Follow these steps to deploy SQL Server on OpenShift:

1. Open a shell prompt and change directories to the **sqlworkshops/SQLonOpenShift/sqlonopenshift/01_deploy** folder.

2. You should have already logged into the OpenShift cluster using instructions from the Prerequisites.

3. If you are running this workshop as a cluster admin and the instructor did not create a new project, then create a new project called **mssql** with the following command or execute the **step1_create_project.sh** script.

    `oc new-project mssql`

    When this completes, you should see the following messages and be placed back at the shell prompt

   <pre>Now using project "mssql" on server "https://[servername]".
   You can add applications to this project with the 'new-app' command. For example, try:
   oc new-app centos/ruby-25-centos7~https://github.com/sclorg/ruby-ex.git
   to build a new example application in Ruby.</pre>

3. Create a secret to store the System Administrator (sa) password. For this workshop, you will be connecting as the sa login. In production SQL Server environments, you would not normally use the sa login. Use the following command or execute the **step2_create_secret.sh** script:

    `oc create secret generic mssql --from-literal=SA_PASSWORD="Sql2019isfast"`

    When this completes you should see the following message and be placed back at the shell prompt

   <pre>secret/mssql created</pre>

    **IMPORTANT: Take note of the value for SA_PASSWORD (without the quotes). The scripts in all modules use this password but you may need it to interactively work with SQL Server.**

4. Create a PersistentVolumeClaim to store SQL Server databases and files. Use the following command or execute the **step3_storage.sh** script:

    **Note**: The PersistentVolumeClaim created assumes the default StorageClass of the OpenShift cluster.

    `oc apply -f storage.yaml`

      When this completes you should see the following message and be placed back at the shell prompt

   <pre>persistentvolumeclaim/mssql-data created</pre>

5. Deploy SQL Server using the following command or the **step4_deploy_sql.sh** script:

    `oc apply -f sqldeployment.yaml`

    When this completes, you should see the following messages and be placed back at the shell prompt

   <pre>deployment.apps/mssql-deployment created
   service/mssql-service created</pre>

    Take a minute to browse the **sqldeployment.yaml** file to see key pieces of how SQL Server was deployed including details of the container image, arguments, label to "tag" the deployment, what PersistentVolumeClaim to use (from the previous step) and a LoadBalancer service attached to this pod.

    At this time, you have submitted a deployment, which is a logical collection of objects including a pod, container, and LoadBalancer service. OpenShift will schedule a SQL Server container in a pod on a node on the cluster. Proceed to the next step to check on whether the deployment was successful.

6. Verify the SQL Server deployment has succeeded by running the following command:

    `oc get deployment mssql-deployment`

    When the value of **AVAILABLE** becomes 1, the deployment is successful including a Running Container. Depending on the load of your cluster and whether the container image of SQL Server is already present, the deployment could take several minutes.

    You can run the following command to check on the status of the pod and LoadBalancer service:

    `oc get all`

     It is possible for the deployment to be successful but the LoadBalancer is not created. When everything about this deployment is successful, the STATUS of the pod is **Running** and the LoadBalancer service has a valid IP address for EXTERNAL-IP.

7. The SQL Server database engine produces a file called the ERRORLOG file when it starts and can be used to gather interesting information about SQL Server or be used for troubleshooting. Since the output of the ERRORLOG is sent to stdout as part of running SQL Server as a container you can view these logs using OpenShift commands. Run the following commands to view the ERRORLOG or execute the script **step5_get_errorlog.sh**:

    `POD=$(oc get pods | grep mssql | awk {'print $1'})`<br>
`oc logs $POD`

    The ERRORLOG will scroll across the screen and you can scroll up in your shell to see all the output.

A pod with a SQL Server container is now deployed and a LoadBalancer service is attached to the pod. The LoadBalancer will be a key component to connecting to SQL Server no matter where the pod is running in the cluster.

<pre>Do not proceed to the next Module until you have a valid IP address for the EXTERNAL-IP value for the LoadBalancer service. The value will say pending while it is being created. One some OpenShift cluster systems this process can take a few minutes.</pre>

You can now proceed to Next Steps to Connect and Query SQL Server on OpenShift.

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
