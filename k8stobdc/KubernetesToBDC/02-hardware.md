![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> 02 - Hardware and Virtualization environment for Kubernetes </h2>

In this workshop you have covered the fundamentals behind contains and container orchestration. The end of this Module contains several helpful references you can use in these exercises and in production. 

This module covers the infrastructure foundation for building a Kubernetes cluster. You will examine the cluster installation on a Hypervisor environment for the in-person class, and you will also get references for other architectures. 

> **NOTE:** This module will use Kubernetes-specific terms you have not seen yet. This is because the in-person course requires a platform to learn the Kubernetes concepts and technologies in the next module, so just take the information here as a statement, and you'll learn more about what each term means in the following modules. If you are reading through this course on your own, you can read the next module first, and then come back to this one for a more natural flow. 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">2.1 Kubernetes Targets</h2>

Kubernetes and it's variants, can run on "bare metal" - a server-hardware system. You can also use a Hypervisor, such as VMWare or Hyper-V. In many companies, the IT infrastructure is completely virtualized, so this module covers the installation on that platform. Most of the principles for deploying Kubernetes apply when carrying out the activity on non-virtualized hardware, and you'll learn the differences as you progress through the exercises.


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">2.2 Computing and Networking Hardware Setup and Configuration</h2>

In this instructor-led session, the general hardware you will use involves the following components: 

The base hardware consists of:

- 2 x servers each with 2 12 core processors and 512GB of RAM
- One all-Flash solid state storage array connected to the compute resource via iSCSI

In this course, each machine hosts a VMware 6.7 ESXi server, this provides the ability to provision virtual machines for:


 <table style="tr:nth-child(even) {background-color: #f2f2f2;}; text-align: left; display: table; border-collapse: collapse; border-spacing: 2px; border-color: gray;">

  <tr>
    <th style="background-color: #1b20a1; color: white;">Virtual Machine Assignment</th> 
    <th style="background-color: #1b20a1; color: white;">Operating System</th>
    <th style="background-color: #1b20a1; color: white;">Logical CPUs</th>
    <th style="background-color: #1b20a1; color: white;">Memory Assigned (GB)</th>
    <th style="background-color: #1b20a1; color: white;">Description</th>
  
  </tr>

  <tr>
      <td>Master node (x2)</td>
      <td>Ubuntu 18.04.03 LTS 64 bit <b>*</b></td>
      <td>2</td>
      <td>8</td>
      <td>Kubernetes cluster control plane</td>
  </tr>
  <tr>
      <td>Worker node (x15)</td>
      <td>Ubuntu 18.04.03 LTS 64 bit <b>*</b></td>
      <td>8</td>
      <td>64</td>
      <td>Kubernetes cluster compute and data planes</td>
  </tr>
  <tr>
      <td>Jump Box (Client) </td>
      <td>Ubuntu 18.04.03 LTS 64 bit <b>*</b></td>
      <td>2</td>
      <td>2</td>
      <td>"Guest" for Kubernetes and big data cluster deployment commands</td>
  </tr>
  <tr>
      <td>Active Directory Server</td>
      <td>Windows Server 2019 Standard Edition</b></td>
      <td>8</td>
      <td>8</td>
      <td>Active Directory authentication for Kubernetes cluster and SQL Server Pods</td>
  </tr>

</table>

<i>*Refer to https://help.ubuntu.com/community/Installation/MinimalCD</i>

The Kubernetes cluster state is stored in **etcd**, a high-performance key-value store database. Our lab will use an **etcd** configuration of three instances, one on each of the master nodes and one instance on a worker node. 

Tips
- This configuration will work equally well on blade servers and on Hyper-V,
- To speed up node creation, a template can used for creation of all node hosts. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>


<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">2.3 Virtualization (Hypervisor) Setup and Configuration</h2>

With the hardware and layout in place, you'll now turn to the configuration of the cluster environment. Note that the operating system for each master and worker node is Ubuntu 18.04.3 LTS, and the storage orchestrator requires the open-iscsi package.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">2.4 Creating the "Jump Box"</h2>

The "Jump Box" is a Virtual Machine that emulates the the workstation you would use to deploy, configure and manage your cluster using tools such as **kubespray**, **kubectl** and the **azdata** utility. This system is within the Hypervisor environment. You might use a physical machine on the same network or the Jump Box might be used in production. 

The following packages are all required by **kubespray**, the mechanism used to deploy a Kubernetes cluster. Refer to [the *requirement.txt* file in the Kubespray GitHub repository](https://github.com/kubernetes-sigs/kubespray/blob/master/requirements.txt) for the exact versions of these packages that are required:

- ansible
- jinja2
- netaddr
- pbr
- hvac
- jmespath
- ruamel.yaml


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">2.5 Storage Orchestration</h2>

In this instructor-led workshop, Storage Orchestration is facilitated via the [Pure Service Orchestrator](https://github.com/purestorage/helm-charts/blob/master/pure-k8s-plugin/README.md). This component is a [Kubernetes Container Storage Interface-compliant plugin](https://github.com/container-storage-interface/spec) that automatically provisions storage across one or more Pure Storage FlashArray™ and FlashBlade™ storage arrays. 

You will learn much more about the Storage component of a Kubernetes cluster in the next module. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>


<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">2.6 Kubernetes Cluster Deployment</h2>

Now that all of the components are in place, you can deploy your cluster. Using the layout for the "Nodes" (Virtual Machines) in the first table, and using the Jump Box tools, you can create the cluster.

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

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/03-kubernetes.md" target="_blank"><i> Module 3 - Kubernetes</i></a>.