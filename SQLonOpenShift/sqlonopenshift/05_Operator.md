![](../graphics/microsoftlogo.png)

# Workshop: SQL Server on OpenShift

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>Using an Operator with SQL Server on OpenShift</h2>

You'll cover the following topics in this Module:

<dl>

  <dt><a href="#5-0">5.0 Deploy an Always On Availability Group on OpenShift with an operator</a></dt>
  <dt><a href="#5-1">5.1 Connect and Query a database in an Availability Group</a></dt>
  <dt><a href="#5-2">5.2 Testing a failover of the Availability Group</a></dt>
  
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="5-0">5.0 Deploy an Always On Availability Group on OpenShift with an operator</a></h2>

In this module you will learn xxxxx

Proceed to the Activity to learn these deployment steps.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Deploy an Always On Availability Group on OpenShift with an operator</a></b></p>

Follow these steps to deploy an Always On Availability Group on OpenShift using an operator.

1. Open a shell prompt and change directories to the **sqlworkshops/SQLonOpenShift/sqlonopenshift/05_Operator** folder.

2. First, create a project for this activity. Use the following command or execute the **step1_create_project.sh** script:

    `oc new-project ag1`

    When this complete, you should see output like the following

    <pre>Now using project "ag1" on server "https://masterdnsx5rquio6c54pu.eastus.cloudapp.azure.com:443".

   You can add applications to this project with the 'new-app' command. For example, try:

   oc new-app centos/ruby-25-centos7~https://github.com/sclorg/ruby-ex.git

   to build a new example application in Ruby.</pre>

3. Create the SQL Server operator by executing the following command or execute the **step2_apply_operator.sh** script:

    `oc apply -f operator.yaml --namespace ag1`

    When this completes, you should see output like the following

    <pre>Warning: oc apply should be used on resource created by either oc create --save-config or oc apply
   namespace/ag1 configured
   serviceaccount/mssql-operator created
   clusterrole.rbac.authorization.k8s.io/mssql-operator-ag1 configured
   clusterrolebinding.rbac.authorization.k8s.io/mssql-operator-ag1 configured
   deployment.apps/mssql-operator created</pre>

    You can ignore the Warning. To ensure the operator was deployed successfully, run the following command

    `oc get pods`

    The STATUS of the mssql-operator should be **Running**.

4. Next, create a secret for the system administrator (sa) password and a password for the master key using the following command or the script **step3_generate_secret.sh**

    `oc create secret generic sql-secrets --from-literal=sapassword="Sql2019isfast" --from-literal=masterkeypassword="Sql2019isfast"  --namespace ag1`

    When this completes, you should see output like the following

   <pre>secret/sql-secrets created</pre>

5. Using the sqlserver.yaml file you will deploy the SQL Server instances for a primary and two secondary replicas. This will coordinate with the deployed operator to install a SQL Server Always On Availability Group configuration. No database will be deployed. That will be done in the next section of this Module. Run the following command or use the script **step4_apply_sqlserver.sh**

    `oc apply -f sqlserver.yaml --namespace ag1`

    When this completes, you should see the following

    <pre>sqlserver.mssql.microsoft.com/mssql1 created
   service/mssql1 created
   sqlserver.mssql.microsoft.com/mssql2 created
   service/mssql2 created
   sqlserver.mssql.microsoft.com/mssql3 created
   service/mssql3 created</pre>

    To proceed to the rest of the activity, you need to ensure the deployment of all pods and LoadBalancer services are successful. The deployment could take several minutes. Execute the following command

    `oc get all`

    When the deployment is successful, these pods should be in a STATUS of Running

    <pre>pod/mssql1-0                          2/2       Running     0          4m
   pod/mssql2-0                          2/2       Running     0          4m
   pod/mssql3-0                          2/2       Running     0          4m</pre>

    And these LoadBalancer services should have a valid EXTERNAL-IP address like the following:

    <pre>service/mssql1   LoadBalancer   172.30.217.34   23.96.27.207   1433:32145/TCP      4m
   service/mssql2   LoadBalancer   172.30.242.37   23.96.58.167   1433:31976/TCP      4m
   service/mssql3   LoadBalancer   172.30.6.212    23.96.53.245   1433:30611/TCP      4m</pre>

    Run the `oc get all` command until the pods and LoadBalancer services are in this state.

6. Even though each SQL Server pod has a LoadBalancer service, you need to create a LoadBalancer service that will always point to the primary replica and a LoadBalancer service that will point to any secondary replicas. Execute the following command or the script **step5_apply_agservices.sh**

    `oc apply -f ag_services.yaml --namespace ag1`
    
    When this completes, you should see the following

    <pre>service/ag1-primary created
   service/ag1-secondary created</pre>

    Use the following command to check the status of these services. Wait until each of these services has a valid IP address for EXTERNAL-IP before proceeding to the next step. This could take several minutes
    
    `oc get service`

    You are now ready to create a database, add to the availability group, and add some data to ensure it is being synchronized to secondary replicas.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="5-1">5.1 Connect and Query a database in an Availability Group</a></h2>

In this section, you will learn how to connect, add databases, add data, and query data to replicas in an availability group deployed in OpenShift.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Connect and Query a database in an Availability Group</a></b></p>

Follow the steps in his activity to connect, add databases, add data, and query data to replicas in an availability group deployed in OpenShift.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="5-2">5.2 Testing a failover of the Availability Group</a></h2>

In this section, you will learn how to connect, add databases, add data, and query data to replicas in an availability group deployed in OpenShift.

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Testing a failover of the Availability Group</a></b></p>

Follow the steps in his activity to connect, add databases, add data, and query data to replicas in an availability group deployed in OpenShift.

<p style="border-bottom: 1px solid lightgrey;"></p>



<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>

<p style="border-bottom: 1px solid lightgrey;"></p>

