![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>


<p style="border-bottom: 1px solid lightgrey;"></p>

# 02 - Hardware and Virtualization environment for Kubernetes #

In this workshop you have covered the fundamentals behind contains and container orchestration. The end of this Module contains several helpful references you can use in these exercises and in production. 

This module covers the infrastructure foundation for building a Kubernetes cluster. You will examine the cluster installation on a Hypervisor environment for the in-person class, and you will also get references for other architectures. 

> **NOTE:** This module will use Kubernetes-specific terms you have not seen yet. This is because the in-person course requires a platform to learn the Kubernetes concepts and technologies in the next module, so just take the information here as a statement, and you'll learn more about what each term means in the following modules. If you are reading through this course on your own, you can read the next module first, and then come back to this one for a more natural flow. 

<p style="border-bottom: 1px solid lightgrey;"></p>

## 2.1 Kubernetes Targets ##

Kubernetes and it's variants, can run on "bare metal" - a server-hardware system. You can also use a Hypervisor, such as VMWare or Hyper-V. In many companies, the IT infrastructure is completely virtualized, so this module covers the installation on that platform. Most of the principles for deploying Kubernetes apply when carrying out the activity on non-virtualized hardware, and you'll learn the differences as you progress through the exercises.


<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: <TODO: Activity Name></b></p>

In this activity you will <TODO: Explain Activity>

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

<TODO: Enter specific steps to perform the activity> 

<p style="border-bottom: 1px solid lightgrey;"></p>

<p style="border-bottom: 1px solid lightgrey;"></p>

## 2.2 Computing and Networking Hardware Setup and Configuration ##

In this instructor-led session, the hardware for the hands on lab exercises consists of the following components: 

- 3 x servers each with 2 12 core processors and 512GB of RAM
- One all-Flash solid state storage array connected to the compute resource via iSCSI

<TODO: insert image here>

<p style="border-bottom: 1px solid lightgrey;"></p>

## 2.3 Virtualised Infrastructure Setup and Configuration ##

With the hardware and layout in place, you'll now turn to the configuration of the cluster environment. The operating system for each master and worker node is Ubuntu 18.04.3 LTS, and the storage orchestrator requires the open-iscsi package. To begin with, a virtual machine is required to base the template off for both the master and worker nodes:

1. First start by creating a virtual machine in VMware vCenter:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_1_vcenter.png?raw=true">

2. Provide a name for the virtual machine:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_2_vcenter.png?raw=true">

3. Select a VNMware ESXi server which the virtual machine will use for compute resources:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_3_vcenter.png?raw=true">

4. Select a VNMware datastore that the virtual machine will use for storage

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_4_vcenter.png?raw=true">

5. Select the virtual machine compatibility level:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_5_vcenter.png?raw=true">

6. Select the guest OS family and version; Linux and Ubuntu 64 bit respectively in this example:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_6_vcenter.png?raw=true">

7. For a single node cluster sandbox enivoronment and the Pure Storage Kubernetes storage plugin, the virtual machine requires:

- 4 logical processors
- 16GB of memory
- 100GB of storage
- a dedicated network adapter for iSCSI
- a CD/DVD drive configured to connect to the Ubuntu 64 bit 18.04.03 LTS ISO

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_7_vcenter.png?raw=true">

8. Review the configuration for the virtual machine and then hit FINISH:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_8_vcenter.png?raw=true">

9. Power on the virtual machine and install VMware tools:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_9_vcenter.png?raw=true">

10. Now that the basic virtual machine is configured and powered on, it is time to configure the Ubuntu operating system after the machine boots up from the ISO,
the first step is to specify the language that the guest operating system will use:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_11_vcenter.png?raw=true">

11. Select the preferred keyboard layout

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_12_vcenter.png?raw=true">

12. The network adapter configuration screen should display entries for two adapters; the first for "East - West" traffic within the Kubernetes cluster and the second for the clusters persistent storage accessed via iSCSI:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_13_vcenter.png?raw=true">

13. Assign a static IPv4 address to the first adapter:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_14_vcenter.png?raw=true">

14. specify a subnet mask in **CIDR format**, the ip address, gateway, name (dns) server and search domain:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_15_vcenter.png?raw=true">

15. Repeat the same steps for the adapter for the iSCSI network, note that this does not require a default gateway or name server:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_16_vcenter.png?raw=true">

16. Enter a http proxy, if one is used for accessing the internet:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_17_vcenter.png?raw=true">

17. Accept the default mirror site for Ubuntu:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_18_vcenter.png?raw=true">

18. Select "Use An Entire Disk" for the filesystem:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_19_vcenter.png?raw=true">

19. Select the default of /dev/sda as the device to install Ubuntu on:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_20_vcenter.png?raw=true">

20. Select done to confirm the filesystem configuration:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_21_vcenter.png?raw=true">

21. Select continue to confirm that the target disk of the installation will be formatted:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_22_vcenter.png?raw=true">

22. Enter details for the user to be used to login to the system:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_23_vcenter.png?raw=true">

23. Install the OpenSSH server:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_24_vcenter.png?raw=true">

24. Hit done to confirm that no featured server snaps are to be installed, the single node cluster script will install everything that is required:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_25_vcenter.png?raw=true">

25. Installation of the Ubuntu operating system will now commence:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_26_vcenter.png?raw=true">

26. The full log of the installation can be viewed if required

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_27_vcenter.png?raw=true">

27. Once the install has completed, the guest operating system needs to be rebooted:

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_28_vcenter.png?raw=true">

28. In order for the reboot to take place, the DVD/CD drive needs to be removed from the virtual machine

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_29_vcenter.png?raw=true">

29. Perform a basic test of the virtual 

<p style="border-bottom: 1px solid lightgrey;"></p>

## 2.5 Storage Orchestration ##

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