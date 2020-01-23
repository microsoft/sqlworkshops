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
			<td><b>Tools</b> </td>
			<td><a href="https://kubernetes.io/docs/concepts/overview/kubernetes-api/"><i>The Kubernetes API</i></a> </td>
			<td>The foundation for the declarative configuration schema calls for the entire system. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/kubectl/overview/"><i>kubectl</i></a> </td>
			<td>Command-line control tool for a Kubernetes cluster. Used from a client workstation or a "Jump Box" that acts as the client for your environment. This tool can be installed on Windows, Linux and Mac OS/X. Uses a set of configurations set in a text file to connect to a Kubernetes cluster. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td><b><a href="https://kubernetes.io/docs/concepts/#kubernetes-objects">Object</b></a> </td>
			<td><a href="https://www.tutorialspoint.com/kubernetes/kubernetes_node.htm"><i>Node</i></a> </td>
			<td>The computers (physical or virtual) that host the rest of the Objects in a Kubernetes cluster. </td>
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
			<td><i>Volume</i> </td>
			<td>A pointer to a storage directory - either "ethereal" (has the same lifetime as the Pod) or permanent.  Can use various providers such as cloud storage and on-premises devices, and is set with various parameters </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://github.com/container-storage-interface/spec/blob/master/spec.md">Persistent Storage </i></a> </td>
			<td>A hardware and software combination used to persists state. One of the key aims is ensure that if a Pod is rescheduled to run on a different Node, its state is not lost as it moves from its original Node to a new one. In the early days of Kubernetes, most storage drivers were called as “In tree”, meaning that vendors who wanted Kubernetes to use their storage had to integrate the code for their drivers directly with the Kubernetes code base. The IT industry is now gravitating towards the Container Storage Interface specification which allows Kubernetes to seamlessly use any storage platform that supports this standard without having to touch the Kubernetes code base. Ultimately, the aim of the CSI standard is to promote storage portability. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"><i>Namespace</i></a> </td>
			<td>Used to define multiple virtual clusters backed by the same physical cluster. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td><b>Kubernetes Master</b> </td>
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
			<td><i>kube-scheduler </i> </td>
			<td>Thing </td>
		</tr>		
        <tr style="vertical-align:top;">
			<td> </td>
			<td><i>Container Network Interface </i> </td>
			<td>The Nodes in the cluster communicate with each other via what is known as an <i>overlay network</i> - a software-defined network. There are a variety of CNI plugins that Kubernetes can use. This Workshop uses the the default <i>Calico</i> CNI plugin. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>Certificate Management </i> </td>
			<td>Thing </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>Ingress Management (Optional) </i> </td>
			<td>A key difference between "Vanilla" Kubernetes and an Kubernetes-As-A-Service (such as Azure Kubernetes Service) is that services do not come with load balancing endpoints by default. Load balancer services for Kubernetes is enabled using software such as <i>MetalLb</i>. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td><b>Control </b> </td>
			<td><i>Controller</i> </td>
			<td>Thing </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>Deployment</i> </td>
			<td>Thing </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>Daemon Set</i> </td>
			<td>Thing </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>Stateful Set</i> </td>
			<td>Thing </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>Replica Set </i> </td>
			<td>Thing </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>Job</i> </td>
			<td>Thing </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>Control Plane</i> </td>
			<td>Thing </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i>etcd</i> </td>
			<td>A high performance key value store that stores the cluster’s state. Since <i>etcd</i> is  light-weight, each instance can generally share resources with other Nodes in the cluster. The Hardware recommendations section of the official etcd.io site provides a detailed breakdown of the hardware requirement for <i>etcd</i>. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td><b>Thing</b> </td>
			<td><i>Thing</i> </td>
			<td>Thing </td>
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

Provisions must be made for the control plane to be highly available, this includes:
- The API server

- Master nodes

- etcd instance
It is recommended that a production grade cluster has a minimum of two master nodes and three etcd instances.

3.2.2 Worker Nodes

A production grade SQL Server 2019 Big Data Cluster requires a minimum of three nodes each with 64 GB of RAM and 8 logical processors. However, consideration also needs to be made for upgrading a Kubernetes cluster from one version to another. There are two options:

- Upgrade each node in the cluster in-situ
This requires that a ‘Taint’ is applied to a node so that it cannot accept pods and then drained of its current pod workload. The obvious inference here is that when the node is drained, the pods that are running on it need somewhere else to go, therefore this approach mandates that there are N+1 worker nodes. This approach comes with the risk that if the upgrade fails for any reason, the cluster may be left in a state with worker nodes on different versions of Kubernetes.

- Create a new cluster
Create a new cluster, deploy a big data cluster to it and then restore a backup of the data from the original cluster. This approach requires more hardware than the in-situ upgrade method. If the upgrade spans multiple versions of Kubernetes, for example the upgrade is from version 1.15 to 1.17, this method allows a 1.17 cluster to be created from scratch cleanly and then the data from 1.15 cluster restored onto the new 1.17 cluster.

3.2.1 Prerequisites

In order to carry out the deployment of the Kubernetes cluster, it is assumed that workshop attendees have a basic understanding of the following tasks:
- Ubuntu base operating system installation

- Ubuntu package management via apt

- Cloning a GitHub repo

- Setting up remote access to Ubuntu hosts with ssh

- Basic Ubuntu firewall configuration
3.2.2 Introducing Kubespray
Kubespray is a Kubernetes cluster life cycle management tool that is based on Ansible playbooks, it can:
- Create clusters

- Upgrade clusters

- Remove clusters

- Add nodes to existing clusters
Kubespray is a Cloud Native Computing Foundation project and with its own GitHub repo that can be found here.
3.2.3 What Is Ansible?
Ansible is an open source declarative tool for deploying applications and infrastructure-as-code. Components of an application or infrastructure are specified declaratively in what are know as ‘Runbooks’. Unlike other infrastructure-as-code tools such as Puppet, Ansible does not require that a special node is built for the purpose of deploying applications and infrastructure. All that is required is a host on which Ansible can be installed. Files known as inventory files are used to specify Ansible deployment targets. In the case of Kubespray, the deployment targets are the hosts which nodes and etcd instances are to be created on. Communication between Ansible and the deployment targets specified in an inventory file is via ssh.
3.2.4 Why Use Kubeadm?

Unlike other available deployment tools, Kubespray does everything for you in “One shot”. For example, Kubeadm requires that certificates on nodes are created manually, Kubespray not only leverages Kubeadm but it also looks after everything including certificate creation for you. Kubespray works against most of the popular public cloud providers and has been tested for the deployment of clusters with thousands of nodes. The real elegance of Kubespray is the reuse it promotes. If an organisation has a requirement to deploy multiple clusters, once Kubespray is setup, for every new cluster that needs to be created, the only prerequisite is to create a new inventory file for the nodes the new cluster will use.
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

 
 
Note:
- The deployment is instigated from the jump server,
- The etcd instances can share nodes with the two masters and a worker node due to their minimal CPU and memory requirements,
- hosts.yaml contains the IP addresses of the hosts that the masters, etcd instances and workers will be deployed to,
- cluster.yml contains the play book for creating the Kubernetes cluster itself,
- The entire cluster is deployed via a single invocation of the ansible-playbook command.

3.2.6 Requirements
Refer to the requirements section here in the Kubespray GitHub repo.
3.2.7 Post Cluster Deployment Activities
The primary tool for administering a Kubernetes cluster is kubectl. After deploying the cluster, the first step is to install this followed by installing and configuring a storage plugin.

3.2.8 Hands on Practical Exercises
Use the kubectl cheat sheet to  familiarise yourself with various kubectl commands. One of the key commands to be aware of is kubectl get.
- Use kubectl to obtain the state of each node in the cluster, all nodes in a healthy cluster should have a state of ‘Ready’

- Apart from single node clusters that are used for the purposes of learning Kubernetes such as minikube, pods should never run on master nodes. As such a NoSchedule taint should be present on each master node, use kubectl describe to verify this.

- Labels can be assigned to any object created in a Kubernetes cluster, an entity known as a ‘Selector’ is used to filter objects with labels. Use kubectl get to display the nodes with the role of master. Labels and selectors are covered by the Kubernetes documentation in detail.

- All objects that reside in a Kubernetes cluster reside in a namespace, when a big data cluster is created, all its objects reside in a namespace dedicated to that big data cluster. Use kubectl to obtain the names of namespaces present in the workshop cluster.



<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.3 Pods</h2>

<TODO: Content>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.4 Services (Networking)</h2>

<TODO: Content>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.5 Storage</h2>

<TODO: Content>

3.1.1 The Kubernetes Storage Sub System
The touch point for storage at the pod level is a volume. There are two critical Kubernetes objects that need to be created for storage to be made available to the volume:

- A PersistentVolume (PV) is storage that has been provisioned manually or dynamically using Storage Classes. It is a resource in the cluster just like a node is a cluster resource. PVs have a lifecycle independent of any individual Pod that uses the PV. 

- A PersistentVolumeClaim (PVC) is a request for storage by a user that provides the bridge between a volume and persistent volume. For a persistent volume claim 


While PersistentVolumeClaims allow a user to consume abstract storage resources, it is common that users need PersistentVolumes with varying properties, such as performance, for different problems. Cluster administrators need to be able to offer a variety of PersistentVolumes that differ in more ways than just size and access modes, without exposing users to the details of how those volumes are implemented. For these needs, there is the StorageClass resource.

Containers run inside a pod, containers in a pod share the same life cycle and are always scheduled to run on the same node. Pods can either be stateless or stateful. One of the most fundamental tasks that Kubernetes carries out is to ensure that the desired state of a pod in terms of replicas and its actual state are one of the same.

Pods typically run in either a replicaset or a statefulset, if a replica dies, for example, a node might go offline, Kubernetes will schedule a new pod to run on a healthy node: 

Things get more nuanced when state is involved, when a pod that is stateful is scheduled to run on a different node, the state associated with that pod needs to ‘Follow’ it from its original node to its new node. This can be achieved in one of two ways.
 
Storage Replication
Storage is replicated between nodes, such that if a pod needs to be rescheduled, it can be scheduled to run on a node that its state has been replicated to.
 
Shared Storage
Each node in the cluster has access to the same storage. When a node fails, a pod can be re-scheduled to any other node in the cluster:

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.6 Management and Monitoring</h2>

<TODO: Content>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b> For Further Study</b></p>

<ul>
    <li><a href="<TODO: Enter Link address>" target="_blank"><TODO: Enter Name of Link></a> <TODO: Enter Explanation of Why the link is useful.</li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/04-bdc.md"><i> Module 4 - Big Data Clusters</i></a>.