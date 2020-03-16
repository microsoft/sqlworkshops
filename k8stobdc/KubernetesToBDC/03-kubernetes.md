![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> 03 - Kubernetes Concepts and Implementation </h2>

In this workshop you have covered the hardware and software environment for Kubernetes. You've learned about Linux, Containers, and a quick overview of Kubernetes. With all that in place, in the previous Module you set up your environment to install Kubernetes. We didn't cover the terms you used to define and deploy your Cluster.  

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
			<td>A command-line control tool for a Kubernetes Cluster. Used from a client workstation or a "Jump Box" that acts as the client for your environment. This tool can be installed on Windows, Linux and Mac OS/X. Uses a set of configurations set in a text file to connect to a Kubernetes Cluster. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/tools/#kubeadm"><i>kubeadm</i></a> </td>
			<td>A command-line tool for easily provisioning a secure Kubernetes Cluster on top of physical or cloud servers or virtual machines. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/tools/#dashboard"><i>The Kubernetes Dashboard</i></a> </td>
			<td>A web-based Kubernetes interface that allows you to deploy containerized applications to a Kubernetes Cluster, troubleshoot them, and manage the Cluster and its resources. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://github.com/etcd-io/etcd/tree/master/etcdctl"><i>etcdctl</i></a> </td>
			<td>etcdctl command line tool.</td>
        </tr>
		<tr style="vertical-align:top;">
			<td><a href="https://kubernetes.io/docs/concepts/"><b>Concepts</b></a> </td>
			<td><a href="https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/"><i>Declarative API</i></a> </td>
			<td>Objects are specified according to the desired state that an object should be instantiated in. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/Cluster-administration/networking/"><i>Overlay network</i></a> </td>
			<td>A software defined network via which Nodes in the Cluster communicate, this is usually implemented via a Container Network Interface compliant plugin, the default of which is Calico. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/services-networking/ingress/"><i>Ingress</i></a> </td>
			<td>Ingress exposes HTTP and HTTPS routes from outside the Cluster to services within the Cluster. Traffic routing is controlled by rules defined on the Ingress resource. </td>
        </tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://github.com/container-storage-interface/spec/blob/master/spec.md">Persistent Storage </i></a> </td>
			<td>A hardware and software combination used to persist state. One of the key aims is ensure that if a Pod is rescheduled to run on a different Node, its state is not lost as it moves from its original Node to a new one. In the early days of Kubernetes, most storage drivers were called as “In tree”, meaning that vendors who wanted Kubernetes to use their storage had to integrate the code for their drivers directly with the Kubernetes code base. The IT industry is now gravitating towards the Container Storage Interface specification which allows Kubernetes to seamlessly use any storage platform that supports this standard without having to touch the Kubernetes code base. Ultimately, the aim of the CSI standard is to promote storage portability. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/">Bin packing</i></a> </td>
			<td>The algorithm by which Pods are assigned to Nodes based on each Node's CPU and memory requirements and the available resources on each Node.</td>
        </tr>
		<tr style="vertical-align:top;">
			<td><b><a href="https://kubernetes.io/docs/concepts/#kubernetes-objects">Object</b></a> </td>
			<td><a href="https://www.tutorialspoint.com/kubernetes/kubernetes_Node.htm"><i>Node</i></a> </td>
			<td>The computers (physical or virtual) that host the rest of the Objects in a Kubernetes Cluster. </td>
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
			<td><i><a href="https://kubernetes.io/docs/concepts/workloads/Pods/Pod-overview/">Pod</i></a> </td>
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
			<td><a href="https://kubernetes.io/docs/concepts/storage/volumes/"><i>Persistent Volume</i></a> </td>
			<td>A piece of storage in the Cluster that has been provisioned by an administrator or dynamically provisioned using Storage Classes.</td>
		</tr>
    <tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/storage/volumes/"><i>Persistent Volume Claim</i></a> </td>
			<td>A request for storage from a PersistentVolume by a user.</td>
		</tr>
    <tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/storage/volumes/"><i>StorageClass</i></a> </td>
			<td>A StorageClass provides a way for administrators to describe the “classes” of storage available to a Kubernetes Cluster.</td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/"><i>Namespace</i></a> </td>
			<td>Used to define multiple virtual Clusters backed by the same physical Cluster. Namespaces are a critical component in the Kubernetes role based access control security model.</td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://kubernetes.io/docs/concepts/workloads/Pods/Pod-overview/">Label</i></a> </td>
			<td>key/value pairs that are attached to objects, such as Pods. Labels are intended to be used to specify identifying attributes of objects that are meaningful and relevant to users, but do not directly imply semantics to the core system.</td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://kubernetes.io/docs/concepts/workloads/Pods/Pod-overview/">Selector</i></a> </td>
			<td>Mechanism by which a client/user can identify a set of objects that have specific label(s).</td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://kubernetes.io/docs/concepts/workloads/Pods/Pod-overview/">Secret</i></a> </td>
			<td>An object that contains a small amount of sensitive data such as a password, a token, or a key.</td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><i><a href="https://kubernetes.io/docs/concepts/workloads/Pods/Pod-overview/">ConfigMap</i></a> </td>
			<td>A resource for injecting containers with configuration data that allows containers to be Kubernetes agnostic.</td>
		</tr>
		<tr style="vertical-align:top;">
			<td><a href="https://kubernetes.io/docs/concepts/architecture/master-Node-communication/"><b>Kubernetes Master</b></a> </td>
			<td><a href="https://kubernetes.io/docs/admin/kube-apiserver/"><i>kube-apiserver </i></a> </td>
			<td>Responds to REST calls to provide the frontend to the Cluster’s shared state. This allows all commands through which all other components interact. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/command-line-tools-reference/kube-controller-manager/"><i>kube-controller-manager</i></a> </td>
			<td>A daemon that embeds the non-terminating control loops shipped with Kubernetes that watches the shared state of the Cluster through the API Server and makes changes to change the current state of the Cluster to the desired state. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/reference/command-line-tools-reference/kube-scheduler/"><i>kube-scheduler </i></a> </td>
			<td>A policy-driven scheduling service that is topology aware and specific to a workload. It is called for functions such as availability, performance, and capacity. </td>
		</tr>		
        <tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/Cluster-administration/networking/"><i>Container Network Interface </i></a> </td>
			<td>The Nodes in the Cluster communicate with each other via what is known as an <i>overlay network</i> - a software-defined network. There are a variety of CNI plugins that Kubernetes can use. This Workshop uses the the default <i>Calico</i> CNI plugin. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/security/overview/"><i>Certificate Management </i></a> </td>
			<td>Security management for a Kubernetes Cluster is managed through <a href="https://kubernetes.io/docs/concepts/configuration/secret/">Secrets which can use Certificates</a>. This concept deals with those layers. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://metallb.universe.tf/"><i>Ingress Management (Optional) </i></a> </td>
			<td>A key difference between "Vanilla" Kubernetes and an Kubernetes-As-A-Service (such as Azure Kubernetes Service) is that services do not come with load balancing endpoints by default. Load balancer services for Kubernetes on-premises is enabled using a component that carries out ingress management.</td>
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
			<td>A service that ensures that <i>Nodes</i> run a copy of a <i>Pod</i>. As Nodes are added to the Cluster, Pods are added to them. As Nodes are removed from the Cluster, those Pods are garbage collected. Deleting a DaemonSet will clean up the Pods it created. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a hrf="https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/"><i>StatefulSet</i></a> </td>
			<td>The workload API object used to manage stateful applications that are Clustered by nature. </td>
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
			<td>Contains components such as the <i>Kubernetes Master</i> and <i>kubelet</i> processes that governs how Kubernetes communicates with your Cluster. The Control Plane maintains a record of all of the Kubernetes Objects in the system, and runs continuous control loops to manage those objects’ state. At any given time, the Control Plane’s control loops will respond to changes in the Cluster and work to make the actual state of all the objects in the system match the desired state that you provided. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/tasks/administer-Cluster/configure-upgrade-etcd/"><i>etcd</i></a> </td>
			<td>A high performance key value store that stores the Cluster’s state. Since <i>etcd</i> is  light-weight, each instance can generally share resources with other Nodes in the Cluster. The Hardware recommendations section of the official http://etcd.io site provides a detailed breakdown of the hardware requirement for <i>etcd</i>. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/extend-kubernetes/operator/"><i>operator</i></a> </td>
			<td>A custom Kubernetes object implemented for the management of applications with complex life cycles. </td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/"><i>Node Affinity </i></a> </td>
			<td>A property of Pods that attracts them to a set of Nodes (either as a preference or a hard requirement).</td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/"><i>Taint</i></a> </td>
			<td>A property that repels Pods from particular Nodes.</td>
		</tr>
		<tr style="vertical-align:top;">
			<td> </td>
			<td><a href="https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/"><i>Toleration</i></a> </td>
			<td>A property that allows Pods to be scheduled on Nodes with taints, something you might want to do with daemonsets for example.</td>
		</tr>
	</tbody>
</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.1 Kubernetes Interfaces</h2>

"North-south" traffic (meaning interacting with the system) between a Kubernetes Cluster and the outside is made via the Kubernetes API server. There are a number of standard client tools for administering and using a Kubernetes Cluster: 

- [`kubectl`](https://kubernetes.io/docs/reference/kubectl/overview/): A command line tool for administering a Kubernetes Cluster and creating / modifying Kubernetes objects via YAML files.
- [The Kubernetes Dashboard](https://kubernetes.io/docs/tasks/access-application-Cluster/web-ui-dashboard/): A general purpose web-based graphical interface for Kubernetes.
- [Helm](https://helm.sh/): A tool for Kubernetes application package management and deployment.
- Language Client Libraries: Client libraries exist for most of the popular third generation languages, such as [Python](https://github.com/kubernetes-client/python) and others. All of these provide libraries to interact with the Kubernetes API.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">3.2 Deploying a Cluster</h2>

### 3.2.1 Control Plane ###

Provision must be made for the control plane to be highly available, this includes:

- The API server
- Master Nodes (which can only run on Linux hosts)
- An `etcd` instance

It is recommended that a production grade Cluster has a minimum of two master Nodes and three `etcd` instances, in that in the event of an etcd instance failure, the etcd cluster can only remain operational if quorum is establised.

The standard method for bootstrapping the control plane in is to use the command ```kubeadm init```.

### 3.2.2 Worker Nodes ###

The minimum requirement for a production-grade SQL Server 2019 Big Data Cluster in terms of worker nodes is for three nodes, each with 64 GB of RAM and 8 logical processors. The standard method for bootstrapping worker Nodes and joining them to the Cluster is to use the command ```kubeadm join```.

Consideration needs to be made for upgrading a Kubernetes Cluster from one version to another and allowing the Cluster to tolerate Node failure(s). There are two options:
- **Upgrade each Node in the Cluster**
  This requires that a [`Taint`](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) is applied to a Node so that it cannot accept any Pods. The Node is then "drained" of its current Pod workload, after which it can be upgraded. When the Node is drained, the Pods that are running on it need somewhere else to go, therefore this approach mandates that there are N+1 worker Nodes (assuming one Node is upgraded at a time). This approach runs the risk that if the upgrade fails for any reason, the Cluster may be left in a state with worker Nodes on different versions of Kubernetes.
- **Create a new Cluster**
  In this case, you can create a new Cluster, deploy a big data Cluster to it, and then restore a backup of the data from the original Cluster. This approach requires more hardware than the upgrade method. If the upgrade spans multiple versions of Kubernetes - for example, the upgrade is from version 1.15 to 1.17 - this method allows a 1.17 Cluster to be created from scratch cleanly and then the data from 1.15 Cluster restored onto the new 1.17 Cluster.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: An Introduction To The Workshop Sandbox Environment (Optional)</b></p>

> Depending on time, this exercise may be ommitted from your course, but you can follow the procedures here to set up a SQL Server big data cluster. If you completed the pre-requisites, you will already have this environment and will not need to repeat the steps here. In the final modules of this course, your instructor team will demonstrate a full big data cluster environment for you, and point you to a larger set of instructions to install and work with that system, since the focus of this course is heavier in the Kubernetes concepts. 

In the previous section we looked at the workshop sandbox environment from an infrastructure perspective, in the next activity we will take a first look at the Kubernetes Cluster that has been deployed to this environment. In terms of Kubernetes and its associated tools, the sandbox environment consists of:

- A single Node Kubernetes Cluster
- The `kubectl` utility
- Helm
- The Kubernetes dashboard
- A local-storage Storage Class

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. Log onto the your workshop virtual machine using a ssh client, your workshop leaders will provide you with an ip address, username and password. macOS users may use the ssh client already built into their operating system, windows users can use either [putty](https://www.putty.org/) or a shell.

To deploy the single Node Kubernetes Cluster on your own virtual machine outside of the workshop, perform the following steps:

- Download the deployment script using this command:

```
curl --output setup-bdc.sh https://raw.githubusercontent.com/microsoft/sql-server-samples/master/samples/features/sql-big-data-Cluster/deployment/kubeadm/ubuntu-single-Node-vm/setup-bdc.sh
```
- Set the permissions on this file such that it can be executed:

```
chmod +x setup-bdc.sh
```

- Execute the Cluster creation script as follows:

```
sudo ./setup-bdc.sh
```

2. List the key processes that your sandbox Kubernetes Cluster consists of:

```
ps -ef | egrep'(containerd|docker|etcd|kubelet)'
```

3. List the log files for the Pods that form your sandbox big data Cluster:

```
ls -l /var/log/Pods
```

4. Observe live process stats that include those of the comnponents that make up the sandbox Kubernetes Cluster:

```
top
```

### 3.2.3 Kubernetes Production Grade Deployments ###

The environments used for the workshop hands on activities are created via a single script that leverages `kubeadm`. A deployment of a Kubernetes Cluster that is fit for production purposes might require:

- Deployment of multi-node Clusters.
- Repeatable Cluster deployments for different environments with minimal scripting and manual command entry.

Also consider the number of steps required to deploy a Cluster using `kubeadm`:

- Import the keys and register the repository for Kubernetes on each machine that will host a Cluster Node.
- Configure docker and Kubernetes prerequisites on each machine.
- Configure docker and Kubernetes prerequisites on each machine.
- Create a `YAML` file in order to enable `RBAC` for the Cluster
- Initialize the Kubernetes master on this machine.
- Boostrap each work Node and join it to the Cluster.
- Configure an agent / `kubelet` on each worker Node.

### 3.2.4 Introducing Kubespray ###

[Kubespray](https://kubespray.io/#/) is a Kubernetes Cluster life cycle management tool based on [Ansible playbooks](https://docs.ansible.com/?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW). Kubespray has the ability to carry out these operations:

- Create Clusters
- Upgrade Clusters
- Remove Clusters
- Add Nodes to existing Clusters

Kubespray is a Cloud Native Computing Foundation project with its own [GitHub repository](https://github.com/kubernetes-sigs/kubespray).

### 3.2.4.1 An Overview of Ansible ###

Ansible is an open source declarative tool for deploying applications and infrastructure-as-code. Components of an application or infrastructure are specified declaratively in `Runbooks`. Unlike other infrastructure-as-code tools, Ansible does not require that a special Node is built for the purpose of deploying applications and infrastructure. All that is required is a host on which Ansible can be installed. Documents known as `inventory files` are used to specify Ansible deployment targets. In the case of Kubespray, the deployment targets are the hosts which Nodes and `etcd` instances are to be created on. Communication between Ansible and the deployment targets specified in an inventory file is via `ssh`.

### 3.2.4.2 Prerequisites ###

In order to carry out the deployment of the Kubernetes Cluster, a basic understanding of the following tasks is required:

- Ubuntu base operating system installation
- Ubuntu package management via apt
- Cloning a GitHub repo
- Setting up remote access to Ubuntu hosts with ssh
- Basic Ubuntu firewall configuration

### 3.2.4.3 Kubespray Workflow ###

Unlike other available deployment tools, Kubespray does everything for you in “One shot”. For example, Kubeadm requires that certificates on Nodes are created manually, Kubespray not only leverages Kubeadm but it also looks after everything including certificate creation for you. Kubespray works against most of the popular public cloud providers and has been tested for the deployment of Clusters with thousands of Nodes. The real elegance of Kubespray is the reuse it promotes. If an organization has a requirement to deploy multiple Clusters, once Kubespray is setup, for every new Cluster that needs to be created, the only prerequisite is to create a new inventory file for the Nodes the new Cluster will use.

The deployment of a Kubernetes Cluster via Kubespray follows this workflow:

- Preinstall step
- Install Container Engine
- Install `etcd`
- Setup certificates
- Install Kubernetes master(s)
- Install Kubernetes worker(s)
- Configure network plugin
- Configure any add-ons

Conceptually, the creation of a three-worker Node Cluster follows this graphic:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_2_7_kubespray-flow.png?raw=true">

**Note:**
- The deployment is instigated from the "jump" system, which acts as a workstation
- The `etcd` instances can share Nodes with the two masters and a worker Node due to their minimal CPU and memory requirements
- The `hosts.yaml` file contains the IP addresses of the hosts that the masters, the `etcd` instances and workers will be deployed to
- The `cluster.yaml` file contains the play book for creating the Kubernetes Cluster itself
- The entire Cluster is deployed via a single invocation of the `ansible-playbook` command

### 3.2.4.4 Configuration Management ###

- The names of the hosts and their ip addresses on which cluster nodes and etcd instances will be built are defined in:
  `kubespray/inventory/<cluster-name>/hosts.yml`

- General Kubernetes cluster configuration information, such as the version of Kubernetes to be deployed is specified in:
  `kubespray/inventory/<cluster-name>/group_vars/k8s-cluster/k8s-cluster.yml`

### 3.2.4.5 Cluster Lifecycle Management ###

To deploy a cluster using Kubespray:
```
ansible-playbook -i inventory/<cluster-name>/hosts.yml cluster.yml --become --become-user=root
```
To remove a cluster:
```
ansible-playbook -i inventory/<cluster-name>/hosts.yml reset.yml --become --become-user=root
```
Rebuild master nodes:
```
ansible-playbook -i inventory/<cluster-name>/hosts.yml recover-control-plane.yml --become --become-user=root
```
Add worker nodes / etcd instances:
```
ansible-playbook -i inventory/<cluster-name>/hosts.yml scale.yml --become --become-user=root
```
Remove nodes / etcd instances:
```
ansible-playbook -i inventory/<cluster-name>/hosts.yml remove-node.yml --become --become-user=root
```
Upgrade cluster to a newer version of Kubernetes:
```
ansible-playbook -i inventory/<cluster-name>/hosts.yml upgrade-cluster.yml --become --become-user=root
```

### 3.2.5 Post Cluster Deployment Activities ###

Following a successful deployment of a Kubernetes cluster, the main tools used for administering and managing the a cluster should be deployed.

### 3.2.5.1 Kubectl ###

`kubectl` is the primary tool for administering a Kubernetes Cluster. The `kubectl` utility requires a configuration file in order to access the Cluster. By default `kubectl` will look for a file named config in the `.kube` directory under the home directory of the user that is logged in:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_2_9_kubectl.png?raw=true">

The config file specifies Clusters, users and contexts. A context is a label for connection details to a Cluster in terms of a user and namespace. If `kubectl` cannot find a config file or it has been corrupted in any way when an attempt is made to run a command against a Cluster, the following error message will appear:

**`The connection to the server localhost:8080 was refused - did you specify the right host or port?`**

The [Kubernetes documentation](https://kubernetes.io/docs/tasks/access-application-Cluster/configure-access-multiple-Clusters/) explains the creation of config files and contexts for accessing multiple Clusters. The fastest and simplest way to create a config file is to copy the file `/etc/kubernetes/admin.conf` from one of the master Node hosts to the client machine that `kubectl` is installed on.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Kubectl Familiarization</b></p>

Its time to work with the `kubectl` utility,  the primary command line tool for managing and administering Kubernetes Clusters. Use the [kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) for assistance with this activity.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. Display the config containing the context for accessing the sandbox Kubernetes Cluster (hint: look for the `config` switch).
2. Use `kubectl` to obtain the state of the Cluster's single Node, do this such that the operating system the Node is running on is displayed (hint: use the `-o` switch)
3. Obtain detailed information on the sandbox Cluster's single Node using describe and make a note of the Taint associated with the Node (hint: `kubectl describe`).

4. All objects that live in a Kubernetes Cluster reside in a `Namespace`. When a SQL Server big data cluster is created, all its objects reside in a namespace dedicated to that big data Cluster. Use `kubectl` to obtain the names of namespaces present in the workshop Cluster (hint: `kubectl get`)

<p style="border-bottom: 1px solid lightgrey;"></p>

## 3.2.5.2 Dashboard ## 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Deploying The Kubernetes Dashboard</b></p>

In this activity, the Kubernetes dashboard will be deployed to your sandbox Kubernetes cluster and accessed from a web browser running on your laptop.

1. Install kubectl on your laptop. The [Kubernetes documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/) provides full instructions for installing kubectl on Windows, Linux and MacOs, following the instructions which are relevant for the operating system on your laptop.

2. Use a file copy tool, Windows users may use [WinScp](https://winscp.net/eng/download.php), MacOs users may use [Filezilla](https://filezilla-project.org/download.php?platform=osx) and Linux users may use scp, to copy /etc/kubernetes/admin.conf from your sandbox virtual machine to .kube\config under the home directory of the user account that you use for logging into your laptop.

3. Execute the following command to verify that both kubectl is installed and that it can access the context for connecting to the sandbox cluster:
```
kubectl cluster-info
```
4. Deploy the console:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
```

5. Create a service account and clusterrolebinding for accessing the dashboard:
```
kubectl create serviceaccount dashboard-admin-sa
kubectl create clusterrolebinding dashboard-admin-sa --clusterrole=cluster-admin --serviceaccount=default:dashboard-admin-sa
```

6. Obtain the secrets currently stored in the cluster:
```
kubectl get secrets
```

7. Describe the secret prefixed with dashboard-admin-sa-token, for example, if this is dashboard-admin-sa-token-kk287, issue the following command:
```
kubectl describe secret dashboard-admin-sa-token-kk287
```

8. From the outout of the describe command copy the long string of text that represents the token.

9. Issue the following command from a command shell on your laptop, and leave the command running
```
kubectl proxy
```

10. Paste the following URL into the address bar of your laptop's browser: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

11. The dashboard will ask ask you to authenticate either via a context config gile or a token, select the token option and then paste the token string into the token box.

## 3.2.7 Application Deployment (Package Management) ## 

The deployment of applications often comes with the following requirements:

- The ability to package components together.
- Version control.
- The ability to downgrade and upgrade packaged applications.

> Simply using a `YAML` file does not meet the requirements of deploying complex applications - a problem exacerbated by the rise of microservice based architectures.

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_2_10_package_mgmt.PNG?raw=true">

Kubernetes solves this problem via [Helm](https://helm.sh/). Helm packages are defined in what are called `Charts`, and charts in turn are stored in chart repositories. Whilst Helm is not required for deploying a SQL Server 2019 big data Cluster, the chances are that there are supporting objects in the rest of your Kubernetes eco-system that require the use of Helm.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Using Helm</b></p>
In this activity we will deploy a storage plugin using Helm, this activity will demonstrate:

- How to add a repository to your chart "Search space".
- The dry-run facility that Helm provides
- Specifying values for use with Helm
- Installing a software component using Helm

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

For this exercise we'll [refer back to the steps in section 2.4 - your instructor will review this section with you](https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/02-hardware.md).

## 3.3 OpenShift Container Platform - A Commercially Supported Kubernetes ##

The OpenShift Container Platform is a 100% Kubernetes compatible Platform-As-A-Service based on Kubernetes from Red Hat Software. While it uses a fork of the Kubernetes system, it has some substantial difference. [You can read more about it here](https://www.openshift.com/).

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_3_1_openshift.PNG?raw=true">

## 3.3.1 The Requirement For Commercially Supported Distributions of Kubernetes ##

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Understanding what open-source means</b></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. Use a search engine lookup the Kubernetes repository on GitHub.
2. Make a note of the license that the Kubernetes project is available under.
3. On the GitHub page for the Kubernetes repository, click on 'Issues' (top left of the page), then by clicking on 'Sort', sort the issues in ascending date order. Note the age and severity of some of the issues.
4. Note the GitHub login of the individual who has raised issue #489.
5. In a browser navigate to the link https://landscape.cncf.io/ and make a mental note of the number of projects in the CNCF landscape.

## 3.3.2  OpenShift Container Platform Compared to Kubernetes ##

<table style="width:100%">
  <tr>
    <th><b>Feature / Aspect</b></th>
    <th><b>Kubernetes</b></th>
    <th><b>Openshift Container Platform</b></th>
  </tr>
  <tr>
    <td>Kubernetes support</td>
    <td>100% compatible</td>
    <td>100% compatible</td>
  </tr>
  <tr>
    <td>Licence</td>
    <td>Apache 2.0</td>
    <td>Commercial</td>
  </tr>
  <tr>
    <td>Linux distribution support</td>
    <td>Most debian based distributions</td>
    <td>Red Hat Enterprise Linux (CentOS for OKD)</td>
  </tr>
  <tr>
    <td>Open source version</td>
    <td>Kubernetes is 100% open source</td>
    <td>Openshift Community Edition (OKD)</td>
  </tr>
  <tr>
    <td>Chart installation method</td>
    <td>Helm</td>
    <td>Helm for version < 4.3, operator for version 4.3 onward</td>
  </tr>
  <tr>
    <td>Command line interface</td>
    <td>kubectl</td>
    <td>kubectl and oc</td>
  </tr>
  <tr>
    <td>Single Node version</td>
    <td>minikube, kind, microk8s</td>
    <td>minishift</td>
  </tr>
  <tr>
    <td>Default container engine</td>
    <td>containerd</td>
    <td>cri-o</td>
  </tr>
  <tr>
    <td>Built in software to image capability ?</td>
    <td>No</td>
    <td>Yes</td>
  </tr>
  <tr>
    <td>Default Software defined network plugin</td>
    <td>Calico</td>
    <td>OpenShift SDN</td>
  </tr>
</table>

<p style="border-bottom: 1px solid lightgrey;"></p>

## 3.4 Storage ##

### 3.4.1 Kubernetes Storage Concepts ###

There are two storage options available when deploying a SQL Server 2019 big data Cluster:

- Ephemeral storage
- Persistent Volumes

`Ephemeral` storage, often also referred to as loopback storage, should never be used for production purposes. With ephemeral storage, the second that a Pod is rescheduled to run on a different Node, any data associated with that Pod will be lost. Ephemeral storage should only ever be used for in environments deployed for the purposes of learning Kubernetes. For production use cases Persistent Volumes should be used.

Three key entities are associated with Persistent Volumes:

1.	Volume - Mount point for a Linux or Unix file system inside a Pod.
2.	Persistent Volume Claim (PVC) - A request for the storage that will underpin the volume.
3.	Persistent Volume (PV) - A construct that maps directly to the underlying storage platform that Persistent Volume Claims consume storage from. A Persistent Volume Claim associated with a Persistent Volume is said to be in a ‘Bound’ state. Persistent Volumes created via the local-storage Storage Class are an exception to this rule, this is because binding only takes place once the Pod associated with Persistent Volume Claim / Persistent Volume is scheduled to run on a Node.  

The following deployment illustrates the use a volume and Persistent Volume Claim for a SQL Server instance:

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
          ClaimName: mssql-data
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

### 3.4.2 Manual and Automatic Provisioning ###

Persistent Volumes can be provisioned in one of two different ways:

- **Manually:** This requires that the Cluster administrator must undertake manual activities in order to create the Persistent Volume.
  
- **Automated:** Under an automatic provisioning scheme, once a Persistent Volume Claim is created, a Persistent Volume is created automatically and the two are bound.

### 3.4.3 Storage Classes ###

When using Persistent Volumes, a [`Storage Class`](https://kubernetes.io/docs/concepts/storage/storage-classes/) must be specified. Each storage platform that can be used to allocate storage to the Cluster has its own Storage Class, including a default `Local Storage Class` - which should not normally be used in production environments. The Kubernetes API allows users to create their own Storage Classes. There are a few fundamental components in a SQL Server 2019 big data Cluster that consume storage:

- **The Master Instance:** Stores the RDBMS and file system for SQL Server
- **The Storage Pool:** Stores data in HDFS `CSV` or `Parquet` format
- **The Data Pool:** For the storage of traditional SQL Server data at scale
  
 #### Use Case: Collecting and Processing Telemetry Data

 In the case of an application which collects log files associated with telemetry data from Internet of Things (IOT) like devices, the log files the application generates may account for hundreds of terabytes, even petabytes of data. We want to avoid the performance and storage costs of storing this data in a Relational Database, therefore the best place for this data to land is in the storage pool. Once the telemetry data has been collected, we may then wish to aggregate this data for querying via T-SQL. There are two distinct patterns of usage in this example:

  - We want to use the distributed scale of `Spark` to perform the bulk of the processing
  - We then want to aggregate the data into Relational Storage for a traditional scaled-out Data Mart
  - A small subset of the data is being used for test and development purposes and because our production grade storage comes at a premium

Each of these scenarios has different performance and latency characteristics, so specific Storage Classes can be created and assigned to each.  

#### Reclaim Policy

A [reclaim policy](https://kubernetes.io/docs/tasks/administer-Cluster/change-pv-rexlaim-policy/) is an attribute of a Storage Class that specifies what happens to a Persistent Volume when there are no Persistent Volume Claims bound to it. For Storage Classes that use dynamic provisioning the default policy is `delete`. As a best practices Microsoft recommends that the reclaim policy is set to `Retain`.

### 3.4.4 Pod Mobility ###

Pods can either be *stateless* or *stateful*. One of the most fundamental tasks that Kubernetes carries out is to ensure that the desired state of a Pod in terms of replicas and its actual state are the same. Pods typically run in either a [`ReplicaSet`](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) or a [`StatefulSet`](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/). If a replica dies by a Node going offline for example, Kubernetes will schedule a new Pod to run on a healthy Node: 

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_3_4_stateless.png?raw=true">

Things become more nuanced once state is involved. When a Pod that is stateful is scheduled to run on a different Node, the state associated with that Pod needs to ‘Follow’ it from its original Node to its new Node. This can be achieved in one of two ways.
 
- **Storage Replication:** Storage is replicated between Nodes, such that if a Pod needs to be rescheduled, it can be scheduled to run on a Node that its state has been replicated to:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_3_4_stateful_replicated.PNG?raw=true">

- **Shared Storage:** Each Node in the Cluster has access to the same storage. When a Node fails, a Pod can be re-scheduled to any other worker Node in the Cluster:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_3_4_stateful_shared.PNG?raw=true">

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Investigate The Storage Objects Associated With Your Workshop Cluster</b></p>

In this activity we will look at the different storage objects associated with your sandbox environment.
 
<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

Use the `kubectl` cheat sheet to  familiarize yourself with various `kubectl` commands in order to carry out the following on the "jump" server:

1. List the Storage Class(es) available to the workshop Kubernetes Cluster.
2. Describe the Storage Class(es) available to the workshop Kubernetes Cluster.
 
### 3.4.6 Access Modes

Microsoft database platform professionals will be familiar with the concept of CREATE DATABASE FOR ATTACH:

```
CREATE DATABASE MyAdventureWorks   
 ON (FILENAME = 'C:\MySQLServer\AdventureWorks_Data.mdf'),
    (FILENAME = 'C:\MySQLServer\AdventureWorks_Log.ldf')
FOR ATTACH;
```

This raises a question: If Persistent Volumes for a kubernetes Cluster already exist, can this be attached to a big data Cluster? The answer is that this depends on the `Access mode` for the Persistent Volume.  of which there are three types:

- **ReadWriteOnce:** The volume can be mounted as read-write by a single Node, this is usually associated with block storage platforms; the type of storage that SQL Server usually runs on that is typically accessed via the iSCSI or the Fiber Channel storage protocols.
- **ReadOnlyMany:** The volume can be mounted read-only by many Nodes. This access mode and ReadWriteMany are usually associated with file-based storage platforms, such platforms are usually accessed via the NFS or SMB protocols.
- **ReadWriteMany:** The volume can be mounted as read-write by many Nodes

### 3.4.7 StatefulSets

The architecture of a SQL Server 2019 big data Cluster contains components that are Clustered by nature, such as storage Pods in the storage pool:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_4_7_bdc_architecture.PNG?raw=true">

Components of an application that are Clustered have some special requirements which are not catered for by ReplicaSets. Per the [Kubernetes documentation](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/), Clustered applications usually exhibit one or more of the following requirements:

- Stable, unique network identifiers,
- Stable, persistent storage,
- Ordered, graceful deployment and scaling,
- Ordered, automated rolling updates.

A key feature of a StatefulSet is that each member of a Cluster application requires its own Persistent Volume Claim, for this very reason, a StatefulSet uses a Persistent Volume Claim template:

```
volumeClaimTemplates:
  - metadata:
      name: www
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: "my-storage-class"
      resources:
        requests:
          storage: 1Gi
```		  

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Working With Statefulsets</b></p>

1. List the statefulsets present on your sandbox Kubernetes Cluster:

```
kubectl get statefulset
```

2. Open the file `create-statefulset.yaml` - this should be present in the home directory of your sandbox user. Use either `nano` or `vi` for this purpose. Note the kind of object this is and the volume Claim template at the bottom of the file.

3. Create a statefulset using the following command:

```
kubectl apply -f create-statefulset.yaml
```

4. List the Persistent Volume Claims, why are there three of these associated with the statefulset that was just created ?.

### 3.4.8 Considerations for Choosing Storage

There are a few constraints you should consider for your storage choices. They include:

- **Cost:** Is this CAPEX, OPEX, priced on capacity and / or IOPS
- **Availability:** How available is the platform to serve IO in the event that it suffers a component failure, and can the platform still serve IO if a data center or availability zone is lost
- **Durability:** How durable is the data once it is written
- **Performance:** Does the storage platform meet the latency / IO bandwidth requirements of the application
- **Security:** What security features does the storage platform come with, and if the Kubernetes Cluster is used in a regulated industry that mandates certain security certifications. Does the platform adhere to these requirements
- **Supportability:** Is the platform open source or commercially supported, and does the organization belong to a regulated industry
- **Manageability:** How easy is the platform to manage, what management tools does the platform come with, how easy is it to add storage capacity to the platform,  what data protection tools does the platform come with, does the platform require any scripting / programming expertise in order to manage it, does the platform need to provide integration for any existing management frameworks and / or monitoring solutions
- **Interoperability:** Does the storage platform support any industry standard interfaces ?, Kubernetes is moving towards the container storage interface (CSI) as a standard (platforms that support this can be seamlessly interchanged), does the platform need to provide interoperability with existing infrastructure, does the organization have a preference for storage protocol support; iSCSI, Fiber Channel, NFS, SMB etc, if so does the platform support this

Your requirements should include these considerations along with other factors unique to your use-case.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Utilizing Kubernetes Persistent Storage Volumes</b></p>

In this activity you will explore more on the Persistent Storage Classes you created in Module 2. 

1. [Review the plugin instructions in Module 2](https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/02-hardware.md) in order to install the Kubernetes storage plugin.
2. A `test-pvc.yaml` file should be present in the home directory of the sandbox environment. The contents of the file should be as follows:

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  accessModes:
   - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: block-storage-class
```

The Storage Class name will vary depending on which vendor has supplied the workshop hardware.

3. Create the Persistent Volume Claim as follows:

```
kubectl apply -f test-pvc.yaml
```

4. List all the Persistent Volume Claims present in your sandboxed environment Cluster:

```
kubectl get pvc --all-namespaces
```

Note the status of `test-pvc` Persistent Volume Claim.

5. Obtain a detailed description of the `test-pvc` Persistent Volume Claim:

```
kubectl desc pvc test-pvc
```

6. List all the Persistent Volumes present in your sandbox environment Cluster:

```
kubectl get pv --all-namespaces
```

For a Storage Class that provides automatic provisioning, the Persistent Volume is automatically created for the `test-pvc` volume.

<p style="border-bottom: 1px solid lightgrey;"></p>

## 3.5 Management Of Sensitive Information

Key to managing sensitive information such as passwords is the Kubernetes `Secret` Object. Secrets encrypt information which is stored in `etcd`, at the time when a secret is required it is injected into a Pod(s) are made available via a temporary file system.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Working With Secrets</b></p>

In this activity we will look at what Secret objects come with a big data Cluster and create a secret.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. Connect to your workshop Ubuntu virtual machine using a `ssh` client.
2. List the secrets associated with your sandbox environment big data Cluster:

```
kubectl get secret -n mssql-Cluster
```

3. Now create a secret:

```
kubectl create secret generic mssql --from-literal=SA_PASSWORD="MySuperSecretP@ssw0rd"
```

## 3.6 Services 

A *Service* is an abstraction which defines a logical set of Pods and a policy by which to access them. Simply put, a service provides the means by which:

- clients running **outside** of a Kubernetes Cluster to consume functionality provided by Pods running **inside** the Cluster,
- Pods that represent particular components, a frontend type service for example can communicate with Pods that represent a different service, a backend service for example. 

There are three types of service:

- **ClusterIP**: this provides a virtual ip address that is only accessible from within the Cluster. The motivation for this type of service is to provide Pods that form different parts of an application, for example the front end back ends of the application, the means of communicating via a stable ip address. This is the default service.

- **NodePort**: exposes the service via a static port on each Node.

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_7_1_node_port.PNG?raw=true">

- **LoadBalancer**: exposes the service via a single load balancer endpoint, this in turn routes traffics to Pods running inside the Cluster.

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_7_2_load_balancer.PNG?raw=true">

- **ExternalName**: Maps the Service to the contents of the externalName field (e.g. foo.bar.example.com), by returning a CNAME record with its value. No proxying of any kind is set up.

When creating a Kubernetes Cluster using a Kubernetes-As-A-Service such as Azure Kubernetes Service, the default type of service that expose a Cluster's Pods to the outside world is `LoadBalancer`.
By default the service type for Kubernetes Clusters deployed on-premises, is a `NodePort`. `NodeNorts` and `LoadBalancers` operate in different ways, depending on what you want to expose. The term for the component that manages external access to a Cluster in the context of routing, is ["Ingress controller"](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/). 

## 3.7 Disaster Recovery

The ecosystem in which a SQL Server 2019 big data Cluster runs on Kubernetes is comprises of various layers:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/3_7_1_tech_stack.PNG?raw=true">

In the context of Kubernetes, state is stored in several places:

1. Persistent Volumes for application data.
2. `etcd` for the entire configuration of the Cluster, including secrets and configuration maps.
3. `Certificates`, which are the communication between many of the key components in a Cluster involves SSL certificates, such as when `kubelets` talk to a master Node.

Each of these are guided by the `etcd` concept, and must be backed up for security. Options for backing up `etcd` include:

- **Backup the directory where your Cluster's etcd data resides ** This could involve the use of storage snapshot technology
- **etcdctl:** Allows snapshots of etcd to be taken, restoring a etcd Cluster involves a new instance of the Cluster being created which incurrs downtime.
- **[VMware Velero](https://github.com/vmware-tanzu/velero)** (formally Heptio Ark): Integrates with 3rd party storage APIs in order to backup the entire state of a Kubernetes Cluster.

## 3.8 Kubernetes Best Practices

Now that many of the most important Kubernetes concepts have been covered, what exactly does a Kubernetes Cluster that is fit for production puproses look like ?, the simple answer is that a production grade Cluster should adhere to many of the following points:

- There should be at least two master Nodes
- Each master Node should have a `NoSchedule` taint
- There should be at least 3 `etcd` instances
- The Cluster should have a storage plugin installed with an associated Storage Class that has a retain policy on `Retain`
- Always use the latest GA version of Kubernetes.
- Make provision for extra Node capacity to allow for Pod rescheduling in the event of a Node failure **and** test this prior to putting a Cluster into production.
- General disaster recovery best practices still apply as per any platform, **always test your backups**.
- Do not deploy the Kubernetes dashboard without using `RBAC`
- Use `kubectl proxy` as the preferred method of exposing the Kubernetes dashboard, otherwise look at using an authenticating proxy or a NodePort service for this purpose.
- Follow [documented](https://kubernetes.io/docs/tasks/administer-Cluster/securing-a-Cluster/) Kubernetes best security practices, which includes checking that role base access is enabled for the Cluster. This can be verified with the following command:

```
kubectl api-versions | grep rbac
```

## 3.9 Troubleshooting

Troubleshooting a SQL Server 2019 big data Cluster, and in fact any application that runs on a Kubernetes Cluster falls into two broad categories.

### 3.9.1 Kubernetes Cluster Infrastructure Troubleshooting ###

This relates to the actual infrastructure that the big data Cluster runs on.

### 3.9.1.1 Persistent Volume Storage ###

Some generic steps to consider when troubleshooting a Kubernetes storage plugin include:

- Check that the ip address endpoint associated with the storage service can be contacted from each Node in the Cluster. Firewall rules might block this, also if VLANs are configured on a storage devices, the ip addresses by which the Kubernetes Cluster talks to this device might need to be added to a CIDR white list
- If the storage plugin uses an API token, check that this is correct
- Irrespective of the plugin vendor it is likely that each Node the Cluster uses a daemonset to mount and unmount volumes, therefore check that the Pod(s) associated with this are running on each Node and are not throwing any errors
- Check the Linux `syslog` on each Node

### 3.9.1.2 ImagePullBackOff

The term `ImagePullBackOff` is an event a Pod experiences when it cannot pull a container image, the causes of which may include:

- The required image not being present in the image registry
- A Node being unable to contact the image registry, the causes of this could include: firewall issues, a Node that is not configured correctly to access the internet or general networking issue
- The file system used on one or more Nodes to cache images running out of space

If a big data Cluster is experiencing issues with pulling images, the output from describing a Pod will contain an image pull backoff error message.

> IMPORTANT: Old versions of container images do not get removed when a new version of a big data Cluster is deployed to a Kubernetes Cluster which has hosted a big data Cluster before. It is therefore possible to run out of space on the worker Node filesystems that are used to cache SQL Server 2019 big data Clusters. Docker images are cached under /var/lib/docker by default. Microsoft's deployment guidance documentation should be consulted in order to determine the exact amount of storage required by the images a big data Cluster, as this may vary from release to release.

To establish the amount of free space free available to local image cache run the following command from within a Linux shell:

```
df -k /var
```

To remove old images, tagged CU1 for example, the following docker command can be used: 

```
docker rmi $(docker images | grep CU1 | tr -s ' ' | cut -d ' ' -f 3)
```

### 3.9.2 SQL Server 2019 Big Data Cluster Application Troubleshooting 

This relates to the deployment and running of the actual SQL Server 2019 big data Cluster as an application.

### 3.9.2.1 Big Data Cluster Deployment

#### 3.9.2.1.1 Observing A Deployment By Monitoring Object Creation

A SQL Server 2019 big data Cluster is bootstrapped through a controller Pod, this in turn creates all the other Pods in the Cluster. To begin with the big data Cluster
control plane will be created, followed by the data plane.

View the big data Cluster Pods as they are created using this command:

```
kubectl get Pods -n mssql-Cluster
```

The initial state of a Pod is *pending*. If a Node in a Kubernetes Cluster has never participated in a big data Cluster deployment, or a new version of a big data Cluster is deployed, most of the time that a Pod spends in a state of pending will involve images being pulled from Microsoft's registry.

Whilst in a state of pending, the activity a Pod is currently performing can be viewed with: 

```
kubectl describe Pod -n mssql-Cluster -o wide
```
The *events* section in the output from this command contains information relating to what the Pod is currently doing. 

#### 3.9.2.1.2 Observing A Deployment By Tailing The Controller Log

The deployment process is orchestrated by a single Pod; named `control-XXXXX` (where XXXXX is a randomly generated five character string). The status of the deployment can be observed from a controller log perspective by performing the following commands:

1. Obtain the name of the controller Pod:

```
kubectl get po -n <Cluster-namespace>
```

2. Shell into the controller container:

```
kubectl exec -it control-znvkt -n mssql-Cluster -- /bin/bash
```

3. Change directory to the controller log directory:

```
cd /var/log/controller
```

4. This directory will contain a sub-directory with a name of the format YYYY-MM-DD, cd into this directory, for example if it is name 2020-02-29, issue:

```
cd 2020-02-29
```

5. Tail the controller log file:

```
tail -f controller.log
```

### 3.9.2.2 General Big Data Cluster Health Troubleshooting

Issue:
```
kubectl get all -n mssql-Cluster
```

In the output returned by this command, check that:

- All Pods are in a state of `Running`
- The desired and current number of Pods for each `ReplicaSet` should match
- The desired and current number of Pods for each `StatefulSet` should match

The status of each Persistent Volume Claim associated with the big Cluster namespace should be bound, verify this by running the following command:

```
kubectl get pvc -n mssql-Cluster
```

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/04-bdc.md" target="_blank"><i> Module 4 - SQL Server big data clusters</i></a>.