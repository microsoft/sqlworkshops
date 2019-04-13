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

In this module you will learn the fundamentals of how to deploy SQL Server OpenShift. The SQL Server engine can be fun in a container and in a Kubernetes cluster. In this module, you will learn the basic steps for how to deploy a SQL Server container in an OpenShift cluster. This module is required to complete the Modules 2, 3, and 4 of the workshop.

In the deployment of SQL Server on OpenShift, you will:

- Create a secret for the password to login to SQL Server
- Create a PersistentVolumeClaim where SQL Server databases and files will be stored
- Deploy a SQL Server container using a declarative .yaml file which will include a LoadBalancer to connect to SQL Server.

Proceed to the Activity to learn these deployment steps.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Deploy SQL Server on OpenShift</a></b></p>

Follow these steps to deploy SQL Server on OpenShift:

1. Open a shell prompt and change directories to the **SQLonOpenShift/sqlonopenshift/01_Deploy** folder.

2. Login to the OpenShift cluster with the oc.exe program using the username and password you created or was provided by your instructor.

    `oc -u <user> -p <Password>`

3. If you are running this workshop as a cluster admin and the instructor did not create a new project, then create a new project called **mssql** with the following command or execute the **step1_create_project.sh** script.

    `oc new-project mssql`

    When this completes, you should see the following messages and be placed back at the shell prompt

    <pre>Now using project "mssql" on server "https://[servername]".
    You can add applications to this project with the 'new-app' command. For example, try:
    oc new-app centos/ruby-25-centos7~https://github.com/sclorg/ruby-ex.git
    to build a new example application in Ruby.</pre>

3. Create a secret to store the System Administrator (sa) password. For this workshop, you will be connecting as the sa login. In production SQL Server environment, you would not normally use the sa login. Use the following command or execute the **step2_create_secret.sh** script found in the **01_Deploy** folder:

    `oc create secret generic mssql --from-literal=SA_PASSWORD="Sql2019isfast"`

    When this completes you should see the following message and be placed back at the shell prompt

    <pre>secret/mssql created</pre>

4. Create a PersistentVolumeClaim to store SQL Server databases and files. Use the following command or execute the **step3_storage.sh** script found in the **01_Deploy** folder:

    **Note**: The PersistentVolumeClaim created assumes the default StorageClass of the OpenShift cluster.

    `oc apply -f storage.yaml`

      When this completes you should see the following message and be placed back at the shell prompt

    <pre>persistentvolumeclaim/mssql-data created</pre>

5. Deploy SQL Server using the following command or the **step4_deploy_sql.sh** script found in the **01_Deploy** folder:

    `oc apply -f sqldeployment.yaml`

    When this compeletes, you should see the following messages and be placed back at the shell prompt

    <pre>deployment.apps/mssql-deployment created

    service/mssql-service created</pre>

    At this time, you have submitted a deployment, which is a logical collection of objects including a pod, container, load balancer service. OpenShift will schedule a SQL Server container in a pod on a node on the cluster. Proceed to the next step to check on whether the deployment was successful.

6. Verify the SQL Server deployment has succeeded by running the following command:

    `oc get deployment mssql-deployment`

    When the value of **AVAILABLE** becomes 1, the deployment is successful including a Running Container. Depending on the load of your cluster and whether the container image of SQL Server is already present, the deployment could take several minutes.

    You can run the following command to check on the status of the pod and load balancer service:

    `oc get all`

     When the deployment is successful, the STATUS of the pod is **Running** and the service will have a valid EXTERNAL-IP address.

7. The SQL Server database engine produces a file called the ERRORLOG file when it starts and can be used to gather interesting information about SQL Server or be used for troubleshooting. Since the output of the ERRORLOG is sent to stdout as part of running SQL Server as a container you can view these logs using OpenShift commands. Run the following commands to view the ERRORLOG or execute the script **step5_get_errorlog.sh** found in the **01_Deploy** folder.

    `POD=$(oc get pods | grep mssql | awk {'print $1'})`<br>
`oc logs $POD`

    The ERRORLOG will scroll across the screen and you can scroll up in your shell to see all the output.

A pod with a SQL Server container is now deployed and a load balancer service is attached to the pod. Proceed to the next Modeule to connect and run queries against your SQL Server deployment

<p style="border-bottom: 1px solid lightgrey;"></p>



<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>

- [Quickstart: Run SQL Server container images with Docker](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker?view=sql-server-linux-ver15&pivots=cs1-bash)
- [Deploy a SQL Server container in Kubernetes with Azure Kubernetes Services (AKS)](https://docs.microsoft.com/en-us/sql/linux/tutorial-sql-server-containers-kubernetes?view=sql-server-2017)

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="02_Query.md" target="_blank"><i>Connect and Query</i></a>.
