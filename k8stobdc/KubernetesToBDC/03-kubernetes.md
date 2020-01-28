![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> 03 - Kubernetes Concepts and Implementation </h2>

In this workshop you have covered the hardware and software environment for Kubernetes. You've learned about Linux, Containers, and a quick overview of Kubernetes. With all that in place, in the previous Module you set up your environment to install Kubernetes. We didn't cover the terms you used to define and deploy your cluster.  
This module covers the concepts, terms, and tools for Kubernetes. You'll follow various exercises to ground your understanding of each topic, and the end of this Module contains several helpful references you can use in these exercises and in production.

We'll begin with a set of definitions. These aren't all the terms used in Kubernetes - you'll see more as you work through the Modules - but they do form the basics for the concepts that follow. You'll work with each of these terms throughout this Module and the rest of the course, so just familiarize yourself with them, and refer back to this list as you work through each section. 

<table style="tr:nth-child(even) {background-color: #dddddd;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 5px; border-color: gray; ">
	<tbody>
		<tr style="vertical-align:top;">
			<th>Category </th>
			<th>Term </th>
			<th>Description </th>
		</tr>
		<tr style="vertical-align:top;">
			<td><a href="https://kubernetes.io/docs/reference/tools/"><b>Tools</b></a> </td>
			<td><a href="https://kubernetes.io/docs/concepts/overview/kubernetes-api/"><i>The Kubernetes API</i></a> </td>
			<td>The foundation for the declarative configuration schema calls for the entire system. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/kubectl/overview/"><i>kubectl</i></a> </td>
			<td>A command-line control tool for a Kubernetes cluster. Used from a client workstation or a "Jump Box" that acts as the client for your environment. This tool can be installed on Windows, Linux and Mac OS/X. Uses a set of configurations set in a text file to connect to a Kubernetes cluster. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/tools/#kubeadm"><i>kubeadm</i></a> </td>
			<td>A command-line tool for easily provisioning a secure Kubernetes cluster on top of physical or cloud servers or virtual machines. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/tools/#dashboard"><i>The Kubernetes Dashboard</i></a> </td>
			<td>A web-based Kubernetes interface that allows you to deploy containerized applications to a Kubernetes cluster, troubleshoot them, and manage the cluster and its resources. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td><b><a href="https://kubernetes.io/docs/concepts/#kubernetes-objects">Object</b></a> </td>
			<td><a href="https://www.tutorialspoint.com/kubernetes/kubernetes_node.htm"><i>Node</i></a> </td>
			<td>The computers (physical or virtual) that host the rest of the Objects in a Kubernetes cluster. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/admin/kubelet/"><i>kubelet</i></a> </td>
			<td>Runs on each Node, and provides communication with the Kubernetes Master. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/admin/kube-proxy/"><i>kube-proxy </i></a> </td>
			<td>Runs on each Node, and provides a network proxy which reflects Kubernetes networking services. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/">Pod</i></a> </td>
			<td>The basic execution unit of a Kubernetes application - holds a processes running on your Cluster. It contains one or more <i>Containers</i>, the storage resources, a unique network IP, and any Container configurations. While the <i>docker daemon</i> is the most common container runtime used in a Kubernetes Pod, other container runtimes are also supported. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://kubernetes.io/docs/concepts/services-networking/service/">Service</i></a> </td>
			<td>A "description" of a set of Pods and a policy to access them. This de-couples the call to an application to it's physical representation, and allows the application running on the Pod to be more stateless. </td>
		</tr>	
        <tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/storage/volumes/"><i>Volume</i></a> </td>
			<td>A pointer to a storage directory - either "ethereal" (has the same lifetime as the Pod) or permanent. Can use various providers such as cloud storage and on-premises devices, and is set with various parameters. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://github.com/container-storage-interface/spec/blob/master/spec.md">Persistent Storage </i></a> </td>
			<td>A hardware and software combination used to persists state. One of the key aims is ensure that if a Pod is rescheduled to run on a different Node, its state is not lost as it moves from its original Node to a new one. In the early days of Kubernetes, most storage drivers were called as “In tree”, meaning that vendors who wanted Kubernetes to use their storage had to integrate the code for their drivers directly with the Kubernetes code base. The IT industry is now gravitating towards the Container Storage Interface specification which allows Kubernetes to seamlessly use any storage platform that supports this standard without having to touch the Kubernetes code base. Ultimately, the aim of the CSI standard is to promote storage portability. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"><i>Namespace</i></a> </td>
			<td>Used to define multiple virtual clusters backed by the same physical cluster. It also is the primary construct for working with Role-Based Security (RBAC).</td>
		</tr>
		<tr style="vertical-align:top;">
			<td><a href="https://kubernetes.io/docs/concepts/architecture/master-node-communication/"><b>Kubernetes Master</b></a> </td>
			<td><a href="https://kubernetes.io/docs/admin/kube-apiserver/"><i>kube-apiserver </i></a> </td>
			<td>Responds to REST calls to provide the frontend to the cluster’s shared state. This allows all commands through which all other components interact. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/"><i>kube-controller-manager</i></a> </td>
			<td>A daemon that embeds the non-terminating control loops shipped with Kubernetes that watches the shared state of the cluster through the API Server and makes changes to change the current state of the cluster to the desired state. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/"><i>kube-scheduler </i></a> </td>
			<td>A policy-driven scheduling service that is topology aware and specific to a workload. It is called for functions such as availability, performance, and capacity. </td>
		</tr>		
        <tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/cluster-administration/networking/"><i>Container Network Interface </i></a> </td>
			<td>The Nodes in the cluster communicate with each other via what is known as an <i>overlay network</i> - a software-defined network. There are a variety of CNI plugins that Kubernetes can use. This Workshop uses the the default <i>Calico</i> CNI plugin. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/security/overview/"><i>Certificate Management </i></a> </td>
			<td>Security management for a Kubernetes cluster is managed through <a href="https://kubernetes.io/docs/concepts/configuration/secret/">Secrets which can use Certificates</a>. This concept deals with those layers. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://metallb.universe.tf/"><i>Ingress Management (Optional) </i></a> </td>
			<td>A key difference between "Vanilla" Kubernetes and an Kubernetes-As-A-Service (such as Azure Kubernetes Service) is that services do not come with load balancing endpoints by default. Load balancer services for Kubernetes is enabled using software such as <i>MetalLb</i>. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td><a href="https://kubernetes.io/docs/concepts/architecture/cloud-controller/"><b>Control </b></a> </td>
			<td><a href="https://kubernetes.io/docs/concepts/architecture/controller/"><i>Controller</i></a> </td>
			<td>A "plugin" mechanism that allows cloud providers to integrate with Kubernetes easily. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/workloads/controllers/deployment/"><i>Deployment</i></a> </td>
			<td>A YAML file describing the state of Pods and ReplicaSets. Deployed to the <i>Kubernetes API</i> using <i>kubectl</i> or <i>REST</i> calls. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/"><i>DaemonSet</i></a> </td>
			<td>A service that ensures that <i>Nodes</i> run a copy of a <i>Pod</i>. As Nodes are added to the cluster, Pods are added to them. As Nodes are removed from the cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a hrf="https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/"><i>StatefulSet</i></a> </td>
			<td>The workload API object used used for stateful apps that are clustered in nature.</td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/"><i>ReplicaSet </i></a> </td>
			<td>A service that maintains a stable set of replica Pods running at any given time. Used to guarantee the availability of a specified number of identical Pods. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/"><i>Job</i></a> </td>
			<td>A Job creates one or more Pods and ensures that a specified number of them successfully terminate. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/#kubernetes-control-plane"><i>Control Plane</i></a> </td>
			<td>Contains components such as the <i>Kubernetes Master</i> and <i>kubelet</i> processes that governs how Kubernetes communicates with your cluster. The Control Plane maintains a record of all of the Kubernetes Objects in the system, and runs continuous control loops to manage those objects’ state. At any given time, the Control Plane’s control loops will respond to changes in the cluster and work to make the actual state of all the objects in the system match the desired state that you provided. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/"><i>etcd</i></a> </td>
			<td>A high performance key value store that stores the cluster’s state. Since <i>etcd</i> is  light-weight, each instance can generally share resources with other Nodes in the cluster. The Hardware recommendations section of the official http://etcd.io site provides a detailed breakdown of the hardware requirement for <i>etcd</i>. </td>
		</tr>
	</tbody>
</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.1 Kubernetes Interfaces</h2>

<TODO: Content>

kubectl

Dashboard

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.2 Deployments (YAML Manifests)</h2>

<TODO: Content>

### 3.2.1 Control Plane ###

Provision must be made for the control plane to be highly available, this includes:

- The API server

- Master nodes

- etcd instance

It is recommended that a production grade cluster has a minimum of two master nodes and three etcd instances.

### 3.2.2 Worker Nodes ###

A production grade SQL Server 2019 Big Data Cluster requires a minimum of three nodes each with 64 GB of RAM and 8 logical processors. However, consideration also needs to be made for upgrading a Kubernetes cluster from one version to another. There are two options:

- Upgrade each node in the cluster in-situ

  This requires that a ‘Taint’ is applied to a node so that it cannot accept pods, the node is then drained of its current pod workload after which it can be upgraded. When the node is drained, the pods that are running on it need somewhere else to go, therefore this approach mandates that there are N+1 worker nodes (assuming one node is upgraded at a time). This approach runs the risk that if the upgrade fails for any reason, the cluster may be left in a state with worker nodes on different versions of Kubernetes.

- Create a new cluster

  Create a new cluster, deploy a big data cluster to it and then restore a backup of the data from the original cluster. This approach requires more hardware than the in-situ upgrade method. If the upgrade spans multiple versions of Kubernetes, for example the upgrade is from version 1.15 to 1.17, this method allows a 1.17 cluster to be created from scratch cleanly and then the data from 1.15 cluster restored onto the new 1.17 cluster.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will deploy a single node big data cluster sandpit environment on an Ubuntu virtual machine using [this script](https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-script-single-node-kubeadm?view=sql-server-ver15)

### 3.2.3 Kubernetes Production Grade Deployments ###

In the last activity, we deployed a single node SQL Server 2019 big data cluster running on a single node. But what if we want to:

- Deploy a Kubernetes cluster with multiple nodes, even tens of nodes

- Deploy multiple Kubernetes clusters without having to write a script for each cluster

- Automate the tasks that have to be performed in addition to running kubeadm

Luckily help is at hand in the form of a tool that leverages kubeadm in order to achieve all of these goals.

### 3.2.4 Introducing Kubespray ###

[Kubespray](https://kubespray.io/#/) is a Kubernetes cluster life cycle management tool based on Ansible playbooks, it can:

- Create clusters

- Upgrade clusters

- Remove clusters

- Add nodes to existing clusters


Kubespray is a Cloud Native Computing Foundation project and with its own [GitHub repository](https://github.com/kubernetes-sigs/kubespray).

### 3.2.5 What Is Ansible? ###

Ansible is an open source declarative tool for deploying applications and infrastructure-as-code. Components of an application or infrastructure are specified declaratively in ‘Runbooks’. Unlike other infrastructure-as-code tools, Ansible does not require that a special node is built for the purpose of deploying applications and infrastructure. All that is required is a host on which Ansible can be installed. Files known as inventory files are used to specify Ansible deployment targets. In the case of Kubespray, the deployment targets are the hosts which nodes and etcd instances are to be created on. Communication between Ansible and the deployment targets specified in an inventory file is via ssh.

### 3.2.6 Prerequisites ###

In order to carry out the deployment of the Kubernetes cluster, a basic understanding of the following tasks is required:

- Ubuntu base operating system installation

- Ubuntu package management via apt

- Cloning a GitHub repo

- Setting up remote access to Ubuntu hosts with ssh

- Basic Ubuntu firewall configuration

### 3.2.7 Kubespray Workflow ###

Unlike other available deployment tools, Kubespray does everything for you in “One shot”. For example, Kubeadm requires that certificates on nodes are created manually, Kubespray not only leverages Kubeadm but it also looks after everything including certificate creation for you. Kubespray works against most of the popular public cloud providers and has been tested for the deployment of clusters with thousands of nodes. The real elegance of Kubespray is the reuse it promotes. If an organization has a requirement to deploy multiple clusters, once Kubespray is setup, for every new cluster that needs to be created, the only prerequisite is to create a new inventory file for the nodes the new cluster will use.
3.2.5 High Level Kubespray Workflow

The deployment of a Kubernetes cluster via Kubespray follows this workflow:

- Preinstall step

- Install Container Engine

- Install etcd

- Setup certificates

- Install Kubernetes master(s)

- Install Kubernetes worker(s)

- Configure network plugin

- Configure any add-ons

Conceptually the creation of a three-worker node cluster looks like this:

**<TODO: Insert image here>**
 

Note:
- The deployment is instigated from the jump server,
- The etcd instances can share nodes with the two masters and a worker node due to their minimal CPU and memory requirements,
- hosts.yaml contains the IP addresses of the hosts that the masters, etcd instances and workers will be deployed to,
- cluster.yml contains the play book for creating the Kubernetes cluster itself,
- The entire cluster is deployed via a single invocation of the ansible-playbook command.

### 3.2.8 Requirements ###


### 3.2.9 Post Cluster Deployment Activities ###

The primary tool for administering a Kubernetes cluster is kubectl. After deploying the cluster, the first step is to install this followed by installing and configuring a storage plugin.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

For this activity, workshop attendees will log onto the jump server and use a preinstalled version of kubectl that allows a production grade kubernetes cluster to be accessed via a read-only context.

Use the kubectl cheat sheet to familiarise yourself with various kubectl commands. One of the key commands to be aware of is kubectl get.

- Use kubectl to obtain the state of each node in the cluster, all nodes in a healthy cluster should have a state of ‘Ready’

- Ordinarily, with the exception of single node clusters that are used for learning purposes, pods should never run on master nodes. As such a NoSchedule taint should be present on each master node, use kubectl describe to verify this.

- Labels can be assigned to any object created in a Kubernetes cluster, an entity known as a ‘Selector’ is used to filter objects with labels. Use kubectl get to display the nodes with the role of master. Labels and selectors are covered by the Kubernetes documentation in detail.

- All objects that live in a Kubernetes cluster reside in a namespace, when a big data cluster is created, all its objects reside in a namespace dedicated to that big data cluster. Use kubectl to obtain the names of namespaces present in the workshop cluster.

## 3.3 Storage ##

### 3.3.1 Kubernetes Storage Concepts ###

There are two storage options available when deploying a SQL Server 2019 big data cluster:

- Ephemeral storage

- Persistent volume

Ephemeral storage, often also referred to as loopback storage, should never be used for production purposes. With ephemeral storage, the second that a pod is rescheduled to run on a different node, any data associated with that pod will be lost. Ephemeral storage should only ever be ysed for snad pit type environments, for all other use cases persistent volumes should be used.

There are three key entities are associated with persistent volumes:

1.	Volume
This can be thought of in similar terms to a mount point for a Linux or Unix file system.

2.	Persistent Volume Claim (PVC)
A request for storage that will underpin the volume.

3.	Persistent Volume (PV)
A construct that maps directly to the underlying storage platform that persistent volume claims consume storage from.
A persistent volume claim associated with a persistent volume is said to be in a ‘Bound’ state.

The following deployment illustrates the use a volume and persistent volume claim for a SQL Server instance:

```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: mssql-deployment
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: mssql
    spec:
      terminationGracePeriodSeconds: 1
      containers:
      - name: mssql
        image: mcr.microsoft.com/mssql/server/server:2017-latest
        ports:
        - containerPort: 1433
        env:
        - name: MSSQL_SA_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mssql
              key: SA_PASSWORD
        volumeMounts:
        - name: mssqldb
          mountPath: /var/opt/mssql
      volumes:
      - name: mssqldb
        persistentVolumeClaim:
          claimName: mssql-data
---
apiVersion: v1
kind: Service
metadata:
  name: mssql-deployment
spec:
  selector:
    app: mssql
  ports:
  - protocol: TCP
    port: 1433
    targetPort: 1433
  type: LoadBalancer
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mssql-data
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 8Gi
  storageClassName: my-block-storage-class
```

### 3.3.2 Manual and Automatic Provisioning ###

Persistent Volumes can be provisioned in one of two different ways:

- manually

  This requires that the cluster administrator must undertake manual activities in order to create the persistent volume.
  
- automatically

  Under an automatic provisioning scheme, once a persistent volume claim is created, a persistent volume is created automatically and the two are bound.

### 3.3.3 Storage Classes ###

When using persistent volumes, something known as a “Storage class” must be specified and a SQL Server 2019 big data cluster is no exception to this. Simply put, each storage platform that can be used to allocate storage to the cluster has its own storage class. Furthermore, the Kubernetes API allows users to create their own storage classes. There are two fundamental components in a SQL Server 2019 big data cluster that consume storage:

- The storage pool 

  For the storage of unstructured data in HDFS parquet format

- The data pool

  For the storage of traditional SQL Server data
  
  **Use Case: Collecting and Processing Telemetry Data**
  
  Imagine an application which collects log files associated with telemetry data from Internet of Things (IOT) like devices. The log files the application generates may account for hundreds of terabytes, even petabytes of data. We want to avoid paying the ‘ACID’ tax of storing this data in a relational database, therefore the best place for this data to land is in the storage pool. Once the telemetry data has been collected, we may then wish to aggregate this data for querying via T-SQL. There are two distinct patterns of usage here:

  - We want to use the raw horse power of Spark to perform the bulk of the processing in the storage pool, a storage class associated with a platform optimized for high IO bandwidth is the best   fit for this purpose.

  - We then want to aggregate the data in the data pool for rapid querying, a storage class associated with a storage platform optimized for low latency is ideally suited for this task.

  - Only a small subset of the data is being used for test and development purposes and because our production grade storage comes at a premium, we might want to use a storage class associated with a cheaper storage platform for this purpose.

### 3.3.4 Pod Mobility ###

Pods can either be stateless or stateful. One of the most fundamental tasks that Kubernetes carries out is to ensure that the desired state of a pod in terms of replicas and its actual state are one of the same. Pods typically run in either a ReplicaSet or a StatefulSet, if a replica dies by a node going offline for example, Kubernetes will schedule a new pod to run on a healthy node: 

**<TODO: Insert image here>**

Things become more nuanced once state is involved. When a pod that is stateful is scheduled to run on a different node, the state associated with that pod needs to ‘Follow’ it from its original node to its new node. This can be achieved in one of two ways.
 
- Storage Replication
Storage is replicated between nodes, such that if a pod needs to be rescheduled, it can be scheduled to run on a node that its state has been replicated to.

**<TODO: Insert image here>**

- Shared Storage
Each node in the cluster has access to the same storage. When a node fails, a pod can be re-scheduled to any other worker node in the cluster:

**<TODO: Insert image here>**

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>
 
Use the kubectl cheat sheet to  familiarise yourself with various kubectl commands in order to carry out the following on the jump server:

- List the storage classes available to the workshop Kubernetes cluster

- List the persistent volume claims present for the workshop SQL Server 2019 big data cluster

- From the list of persistent volume claims obtained in the previous step, pick a persistent volume claim and inspect it in detail using kubectl describe.

- List the persistent volumes present for the workshop SQL Server 2019 big data cluster.

- From the list of persistent volumes obtained in the previous step, pick a persistent volume claim and inspect it in detail using kubectl describe.

- Create a new namespace using the following kubectl command:

```
kubectl create namespace MyNamespace
```

In the final activity in this section we will install a storage plugin in our sand pit environments and create a persistent volume claim and persistent volume.
 
### 3.5.6 Access Modes ###

Microsoft database platform professionals will be familiar with the concept of CREATE DATABASE FOR ATTACH:

```
CREATE DATABASE MyAdventureWorks   
 ON (FILENAME = 'C:\MySQLServer\AdventureWorks_Data.mdf'),
    (FILENAME = 'C:\MySQLServer\AdventureWorks_Log.ldf')
FOR ATTACH;
```

This raises the question; if the persistent volumes for a kubernetes cluster already exist, can this be attached to a big data cluster ?. The answer is that this depends on what is known as the “Access mode” for the persistent volume, of which there are three types:

- ReadWriteOnce

  The volume can be mounted as read-write by a single node, this is usually associated with block storage platforms; the type of storage that SQL Server usually runs on that is typically accessed via the iSCSI or the Fiber Channel storage protocols.

- ReadOnlyMany

  The volume can be mounted read-only by many nodes. This access mode and ReadWriteMany are usually associated with file-based storage platforms, such platforms are usually accessed via the NFS or SMB protocols.

- ReadWriteMany

  The volume can be mounted as read-write by many nodes

### 3.5.7 ### StatefulSets

The architecture of a SQL Server 2019 big data cluster contains components that are clustered by nature, such as storage pods in the storage pool:

***<TODO: Insert image here>***

Components of an application that are clustered have some special requirements which are not catered for by ReplicaSets. Per the [Kubernetes documentation](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), clustered applications usually exhibit one or more of the following requirements:

- Stable, unique network identifiers.

- Stable, persistent storage.

- Ordered, graceful deployment and scaling.

- Ordered, automated rolling updates.

If the Kubernetes cluster's storage platform has a snapshot capability that can be used to refresh storage volumes, persistent volumes can be refreshed via snapshots. The basic work flow for this:

- ```kubectl taint nodes <node name> key=value:NoSchedule```

- ```kubectl drain <node name>```

- ```kubectl scale statefulsets <stateful-set-name> --replicas=0```

- Overwrite StatefulSet persistent volumes using snapshot(s)

- ```kubectl scale statefulsets <stateful-set-name> --replicas=<original replica count>```

- ```kubectl taint nodes <node name> key=value:NoSchedule-```

### 3.5.8 ### Storage Quality of Service Requirement Per Big Data Cluster Component


|     Resource       |  Storage Type for Data   |   Storage Type for Logs    |                   Notes                    |
|--------------------|--------------------------|----------------------------|--------------------------------------------|
|                    |                          |                            |                                            |
|                    |                          |                            |                                            | 
|                    |                          |                            |                                            |

### 3.5.8 ### Storage Plugin Options