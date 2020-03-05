![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: Kubernetes - From Bare Metal to SQL Server Big Data Clusters

#### <i>A Microsoft Course from the SQL Server team</i>


<p style="border-bottom: 1px solid lightgrey;"></p>

# 02 - Hardware and Virtualization environment for Kubernetes #

In this workshop you have covered the fundamentals behind containers and container orchestration. The end of this Module contains several helpful references you can use in these exercises and in production. 

This module covers the infrastructure foundation for building a Kubernetes cluster. You will examine the cluster installation on a Hypervisor environment for the in-person class, and you will also get references for other architectures. 

> **NOTE:** This module will use Kubernetes-specific terms you have not seen yet. This is because the in-person course requires a platform to learn the Kubernetes concepts and technologies in the next module, so just take the information here as a statement, and you'll learn more about what each term means in the following modules. If you are reading through this course on your own, you can read the next module first, and then come back to this one for a more natural flow. 

<p style="border-bottom: 1px solid lightgrey;"></p>

## 2.1 Kubernetes Targets ##

Kubernetes and its variants can run on "bare metal" - a server hardware system. You can also use a Hypervisor, such as VMWare or Hyper-V. In many companies, the IT infrastructure is completely virtualized, so this module covers the installation using that platform. Most of the principles for deploying Kubernetes apply when carrying out the activity on non-virtualized hardware, and you'll learn the differences as you progress through the exercises.

<p style="border-bottom: 1px solid lightgrey;"></p>

## 2.2 Computing and Networking Hardware Setup and Configuration ##

In this instructor-led session, the hardware for the hands on lab exercises consists of the following components: 

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_2_1_workshop_hw.PNG?raw=true">

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Basic Sandbox Environment Familiarization</b></p>

1. Connect to your sandbox environment using a ssh client. Apple and Linux systems come with a built in client, as does the latest Windows operating system. You may also wish to use the graphical [Putty](https://www.putty.org/) tool. Your workshops tutors will make login credentials available to each attendee.

2. Install the `virt-what` package using the `apt-get` command in Linux, once you have connected to your environment:

`sudo apt-get install virt-what`

3. Execute `virt-what` to verify the platform that your sandbox environment is running on:

`sudo virt-what`

4. Obtain the amount of memory your sandbox environment has by running the following command:

`lsmem`

5. Obtain the processor information for your sandbox environment by running the following command:

`lscpu`

<p style="border-bottom: 1px solid lightgrey;"></p>

## 2.3 Virtualised Infrastructure Setup and Configuration ##

With the hardware and layout in place, you'll now turn to the configuration of the cluster environment. The operating system for each master and worker node is Ubuntu 18.04.3 LTS, and the storage orchestrator requires the `open-iscsi` package. To begin with, a virtual machine is required to base the template off for both the master and worker nodes:

1. First start by creating a virtual machine in VMware vCenter:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_1.PNG?raw=true">

2. Provide a name for the virtual machine:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_2_vcenter.PNG?raw=true">

3. Select a VMware ESXi server which the virtual machine will use for compute resources:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_3_vcenter.PNG?raw=true">

4. Select a VMware datastore that the virtual machine will use for storage:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_4_vcenter.PNG?raw=true">

5. Select the virtual machine compatibility level:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_5_vcenter.PNG?raw=true">

6. Select the guest OS family and version; Linux and Ubuntu 64 bit respectively in this example:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_6_vcenter.PNG?raw=true">

7. For a single node cluster sandbox environment and the Pure Storage Kubernetes storage plugin, the virtual machine requires:

- 4 logical processors
- 16GB of memory
- 100GB of storage
- a dedicated network adapter for iSCSI
- a CD/DVD drive configured to connect to the Ubuntu 64 bit 18.04.03 LTS ISO

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_7_vcenter.PNG?raw=true">

8. Review the configuration for the virtual machine and then hit `FINISH`:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_8_vcenter.PNG?raw=true">

9. Power on the virtual machine:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_9_vcenter.PNG?raw=true">

10. After the machine boots up from the ISO, configure the Ubuntu operating system by specifying the guest's operating system language:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_11_vcenter.PNG?raw=true">

11. Select the preferred keyboard layout:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_12_vcenter.PNG?raw=true">

12. The network adapter configuration screen should display entries for two adapters:

- The first for "East - West" traffic within the Kubernetes cluster,
- The second for the cluster's persistent storage accessed via iSCSI.

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_13_vcenter.PNG?raw=true">

13. Assign a static IPv4 address to the first adapter:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_14_vcenter.PNG?raw=true">

14. Specify a subnet mask in **CIDR format**, the IP address, gateway, name (DNS) server and search domain:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_16_vcenter.PNG?raw=true">

15. Specify a static IPv4 address for the iSCSI network adapter, note that it does not require any routing or a name server:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_17_vcenter.PNG?raw=true">

16. Confirm that the configuration of both network adapters is correct by hitting 'Done':

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_18_vcenter.PNG?raw=true">

17. If a proxy is required for accessing the internet, enter its details here:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_19_vcenter.PNG?raw=true">

18. Hit 'Done' to accept the default Ubuntu mirror site:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_20_vcenter.PNG?raw=true">

18. Select "Use An Entire Disk" for the filesystem:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_21_vcenter.PNG?raw=true">

19. Select the default of `/dev/sda` as the device to install Ubuntu on:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_22_vcenter.PNG?raw=true">

20. Select `Done` to confirm the filesystem configuration:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_23_vcenter.PNG?raw=true">

21. Select `Continue` to confirm that the target disk of the installation will be formatted (destructively):

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_24_vcenter.PNG?raw=true">

22. Enter details for the user to be used to login to the system:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_25_vcenter.PNG?raw=true">

23. Install the `OpenSSH` server:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_26_vcenter.PNG?raw=true">

24. Hit `Done` to confirm that no featured server snaps are to be installed, the single node cluster script will install everything that is required:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_27_vcenter.PNG?raw=true">

25. The actual installation of the Ubuntu operating system will now commence:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_28_vcenter.PNG?raw=true">

26. The full log of the installation can be viewed if so required:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_29_vcenter.PNG?raw=true">

27. Once the install has completed, the guest operating system needs to be rebooted:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_30_vcenter.PNG?raw=true">

28. In order for the reboot to take place, the DVD/CD drive needs to be removed from the virtual machine:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_31_vcenter.PNG?raw=true">

29. Perform a basic test of the virtual machine by pinging a well known URL to ensure that it can deliver and receive internet traffic: 

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_32_vcenter.PNG?raw=true">

30. **We now have a virtual machine that a single node SQL Server 2019 Big Data Cluster can be deployed to using [this script](https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-script-single-node-kubeadm?view=sql-server-ver15)**. If the objective is to deploy a production grade cluster, the following commands should be executed against the guest operating system, after which the virtual machine can be converted into a template:

```
apt-get install -q -y ebtables ethtool
apt-get install -q -y apt-transport-https
# Run the following modprobe command for Ubuntu 18 only
modprobe br_netfilter
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
echo net.ipv6.conf.all.disable_ipv6=1 > /etc/sysctl.conf
echo net.ipv6.conf.default.disable_ipv6=1 > /etc/sysctl.conf
echo net.ipv6.conf.lo.disable_ipv6=1 > /etc/sysctl.conf
sysctl net.bridge.bridge-nf-call-iptables=1
```

31. To create the virtual machine template, right click on the virtual machine, select `Power` and then `Power Off`:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_3_33_vcenter.PNG?raw=true">

32. Right click on the virtual machine, select `Template` and then `Convert to Template`.

33. Deployment of a production grade Kubernetes cluster can be carried out using:

- `Kubeadm`, as per the instructions in [Microsoft's online documentation](https://docs.microsoft.com/en-us/sql/big-data-cluster/deploy-with-kubeadm?view=sql-server-ver15).

- Or for an approach that leverages `Kubeadm` **and** automates the entire deployment process, [`Kubespray`](https://kubespray.io/#/) can be used.

<p style="border-bottom: 1px solid lightgrey;"></p>

## 2.4 Storage Orchestration ##

In this instructor-led workshop, Storage Orchestration is facilitated via the [Pure Service Orchestrator](https://github.com/purestorage/helm-charts/blob/master/pure-k8s-plugin/README.md). This component is a [Kubernetes Container Storage Interface-compliant plugin](https://github.com/container-storage-interface/spec) that automatically provisions storage across one or more Pure Storage FlashArray™ and / or FlashBlade™ storage arrays. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Installing The Storage Plugin </b></p>

The activity covers the installation of a Container Storage Interface compliant Kubernetes storage plugin using [Helm](https://helm.sh/). 

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

1. List the storage class that is currently installed on the single node cluster. For a sandbox type environment built using Microsoft's [single node kubeadm script](https://docs.microsoft.com/en-us/sql/big-data-cluster/deployment-script-single-node-kubeadm?view=sql-server-ver15), this should return the ```local-storage``` storage class.
```
kubectl get sc
```

2. Verify that each iSCSI IP address associated with the interfaces `ct0` and `ct1` is reachable from every node host in the cluster via the use of the ping command:

<img style="width=80; float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/graphics/2_4_1_purity.PNG?raw=true">

3. Confirm the version of helm that is installed by executing the command

 `helm version`

4. Versions of Helm prior to version 3.0 require that a server side component known as 'Tiller' is installed on the Kubernetes cluster, if this is not present, install Tiller using the following commands:
```
kubectl -n kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:tiller

helm init --service-account tiller
``` 

5. Download the YAML template for the storage plugin configuration:

`curl --output pso-values.yaml https://raw.githubusercontent.com/purestorage/helm-charts/master/pure-csi/values.yaml`

6. Using a text editor such as VI or nano, open the `pso-values.yaml` file.

7. Uncomment lines 82 through to 84 by removing the hash symbol (`#`)from each line.

8. On line 83, replace the `template IP addres`s` with the `management endpoint IP address` of the array that persistent volumes are to be created on.

9. On line 84, replace the `template API token` with `API token for the array` that persistent volumes are to be created on.

10. Add the repo containing the Helm chart for the storage plugin:

- For all versions of Helm run:

```
helm repo add pure https://purestorage.github.io/helm-charts
helm repo update
```

- For Helm version 2, also run:

```
helm search pure-csi
```

- For Helm version 3, also run:

```
helm search repo pure-csi
```

11. Perform a dry run install of the plugin, this will verify that the contents of the `pso-values.yaml` file is correct:

- For Helm version 2, run:

```
helm install --name pure-storage-driver pure/pure-csi --namespace <namespace> -f <your_own_dir>/pso-values.yaml --dry-run --debug
```

- For Helm version 3, run:

```
helm install pure-storage-driver pure/pure-csi --namespace <namespace> -f <your_own_dir>/pso-values.yaml --dry-run --debug
```

12. If the dry run of the installation completed successfully, the actual install of the plugin can be performed, otherwise the `pso-values.yaml` file needs to be corrected:

- For Helm version 2, run:

```
helm install --name pure-storage-driver pure/pure-csi --namespace <namespace> -f <your_own_dir>/pso-values.yaml
```

- For Helm version 3, run:

```
helm install pure-storage-driver pure/pure-csi --namespace <namespace> -f <your_own_dir>/pso-values.yaml
```

13. List the type of storage classes that are now installed, a new storage class should be present:

```
kubectl get sc
```

<p style="border-bottom: 1px solid lightgrey;"></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/k8stobdc/KubernetesToBDC/03-kubernetes.md" target="_blank"><i> Module 3 - Kubernetes</i></a>.