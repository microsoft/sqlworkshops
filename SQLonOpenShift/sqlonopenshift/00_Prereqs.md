![](../graphics/microsoftlogo.png)

# Workshop: SQL Server on OpenShift

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>Prerequisites</h2>

You'll cover the following topics in this Module:

<dl>

  <dt><a href="#3-0">0.0 Prerequisites</a></dt>
  
</dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3-0">0.0 Prerequisites</a></h2>

In this module you will learn xxxxx

TODO: Put in here in the basic skills you will need which is mainly to use a Linux bash shell.

Proceed to the Activity to learn these deployment steps.

Here is what is required

OpenShift 3.11 cluster with at leat 1 user node that has at least 8Gb RAM and capable of attaching 4 disks
The permissions to go through the workshop are 1) cluster admin 2) A user with at minimum anyuid permissions. Note that Module 05 requires cluster admin permissions.

A client computer with the following capabilities (Can be Windows, Linux, or MacOS)
A bash shell to run shell scripts
OpenShift CLI toosl (oc.exe)
SQL Server tools (sqlcmd)
Azure Data Studio

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b><a name="aks">Activity: Prerequsites</a></b></p>

If you have cloned our repo be sure to first run git pull to get the latest version of the workshop

Follow these steps to TODO: Put in instructions to login to the OpenShift cluster

These instructions are based on your login as the OpenShift Cluster Administrator. You might be given different login details by your instructor.

Note: Put in a statement to ignore "This site is not secure" message from Browser when going to OpenShift Master Console. Click Details and then "Go on to the webpage". 

Type in your cluster admin user and password into the login screen

Copy Login option from upper right corner

Paste into shell

Should look something like

oc login https://"master node":443 --token="token string"

You should see the following after a successful login

Logged into "https://masterdnsx5rquio6c54pu.eastus.cloudapp.azure.com:443" as "ocpadmin" using the token provided.

You have access to the following projects and can switch between them with 'oc project <projectname>':

  * default
    kube-public
    kube-service-catalog
    kube-system
    management-infra
    openshift
    openshift-ansible-service-broker
    openshift-console
    openshift-infra
    openshift-logging
    openshift-monitoring
    openshift-node
    openshift-sdn
    openshift-template-service-broker
    openshift-web-console

Using project "default".


<p style="border-bottom: 1px solid lightgrey;"></p>



<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="01_Deploy.md" target="_blank"><i>
Deploy SQL Server on OpenShift</i></a>.
