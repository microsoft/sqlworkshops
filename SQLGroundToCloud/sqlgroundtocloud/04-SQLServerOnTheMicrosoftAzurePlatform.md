![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2> 04 - SQL Server on the Microsoft Azure Platform </h2>

In the previous modules, you learned about SQL Server 2019, big data, and more. In this module, you'll learn more about Azure SQL, including the benefits, the options, and how to get there. Near the end of the module, you'll learn how to assess your on-premises estate (via Tailspin Toys) with tools like [Azure Migrate](https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview) and [Data Migration Assistant](https://docs.microsoft.com/en-us/sql/dma/dma-overview?view=sql-server-2017). The activities in this module include:  

[4.1](#4.1): Introduction to Azure SQL   
[4.2](#4.2): Fundamentals of Azure SQL  
[4.3](#4.3): Migrating to Azure SQL   
[4.4](#4.4): Database Discovery and Assessment   
&ensp;&ensp;&ensp;[Activity 1](#4.4.1): Prepare: Set up Azure Migrate  
&ensp;&ensp;&ensp;[Activity 2](#4.4.2): Prepare: Restore TailspinToys on the SQLServer2008 VM  
&ensp;&ensp;&ensp;[Activity 3](#4.4.3): Assess: Perform assessment for migration to Azure SQL Database  
&ensp;&ensp;&ensp;[Activity 4](#4.4.4): Assess: Perform assessment for migration to Azure SQL Database Managed Instance  


(<a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank">Make sure you check out the <b>Prerequisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)  

SELF-PACED USERS ONLY: If you are using this module self-paced, carefully read through Module 4 of this workshop and the references provided before completing the lab in Module 4.4 Then continue to Module 5.  

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="4.1">4.1 Azure SQL</h2></a>

### Scenario Review: Tailspin Toys Gaming

Tailspin Toys is the developer of several popular online video games. Founded in 2010, and acquired shortly after by Wide World Importers, the company has experienced exponential growth since releasing the first installment of their most popular game franchise to include online multiplayer gameplay. They have since built upon this success by adding online capabilities to the majority of their game portfolio.

Adding online gameplay has greatly increased popularity of their games, but the rapid increase in demand for their services has made supporting the current setup problematic. To facilitate online gameplay, they host gaming services on-premises using rented hardware. For each game, their gaming services setup consists of three virtual machines running the gaming software and five game databases hosted on a single SQL Server 2008 R2 instance. In addition to the dedicated gaming VMs and databases, they also host authentication and gateway VMs and databases, which are shared by all their games. At its foundation, Tailspin Toys is a game development company, made up primarily of software developers. The few dedicated database and infrastructure resources they do have are struggling to keep up with their ever-increasing workload.

Tailspin Toys is hoping that migrating their services from on-premises to the cloud can help to alleviate some of their infrastructure management issues, while simultaneously helping them to refocus their efforts on delivering business value by releasing new and improved games. They are looking for a proof-of-concept (PoC) for migrating their gamer information web application and database into the cloud. They maintain their gamer information database, `TailspinToys`, on an on-premises SQL Server 2008 R2 database. This system is used by gamers to update their profiles, view leader boards, purchase game add-ons and more. Since this system helps to drive revenue, it is considered a business-critical application, and needs to be highly-available. They are aware that SQL Server 2008 R2 is approaching end of support, and are looking at options for migrating this database into Azure. They have read about some of the advanced security and performance tuning options that are available only in Azure and would prefer to a migrate the database into a platform-as-a-service (PaaS) offering, if possible. Tailspin Toys is using the Service Broker feature of SQL Server for messaging within the `TailspinToys` database. This functionality is being used for several critical processes, and they cannot afford to lose this capability when migrating their operations database to the cloud. They have also stated that, at this time, they do not have the resources to rearchitect the solution to use an alternative message broker.  

> If you'd like to conduct a deep whiteboard design session for this scenario, it is available [here](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure/tree/master/Whiteboard%20design%20session).

### Azure SQL  deployment options

Tailspin Toys has requested your help in determining where and how they should land their data in Azure. This is a decision that all businesses moving to the cloud have to make, and the result will depend on their unique business requirements. Microsoft has recently introduced Azure SQL, which brings all the SQL Server products in Azure under one suite. If you're already familiar with [Azure SQL Database](https://azure.microsoft.com/en-us/services/sql-database/), this slight shift means that Azure SQL also includes [Azure SQL VMs](https://azure.microsoft.com/en-us/services/virtual-machines/sql-server/), which Microsoft is continuously investing in and enhancing the benefits associated with it.  
<!-- TODO: point to Ninar's blog and video when they god live (August 21)-->

There are several different options within Azure SQL, and one visual is shown below.  
 ![Azure SQL Overview](../graphics/media/azuresql-overview.png)  

Every business is going to have unique requirements that make some options better for them than others. There won't necessarily be one 'correct' answer, but there are gives and gets to consider. Let's look at some examples of Azure SQL customers and what they decided:  

* [Allscripts](https://customers.microsoft.com/en-us/story/allscripts-partner-professional-services-azure): Allscripts is a leading healthcare software manufacturer, serving physician practices, hospitals, health plans, and Big Pharma. To transform its applications frequently and host them securely and reliably, Allscripts wanted to move to Azure, quickly. In just three weeks, the company lifted and shifted dozens of acquired applications running on 1,000 virtual machines to Azure with [Azure Site Recovery](https://azure.microsoft.com/en-us/services/site-recovery/). After the migration, Allscripts began to evaluate and test Azure SQL Managed Instance, and started to move some workloads there. 
* [Komatsu](https://customers.microsoft.com/en-us/story/komatsu-australia-manufacturing-azure): Komatsu is a manufacturing company that produces and sells heavy equipment for construction. They had multiple mainframe applications for different types of data, which they wanted to consolidate to get a holistic view. Additionally, they wanted a way reduce overhead. Because of the large SQL Server surface area, they were able to move about 1.5 terabytes of data smoothly to Azure SQL Managed Instance, and [start enjoying benefits like automatic patching and version updates, automated backups, high availability, and reduced management overhead](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-technical-overview). After migrating, they reported ~49% cost reduction and ~25-30% performance gains.  
* [AccuWeather](https://customers.microsoft.com/en-us/story/accuweather-partner-professional-services-azure): AccuWeather has been analyzing and predicting the weather for more than 55 years. They wanted access to the rich and rapidly advanced platform of Azure that includes big data, machine learning, and AI capabilities. They want to focus on building new models and applications, not managing databases. They selected Azure SQL Database (single database) to use with other services, like [Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/) and [Azure Machine Learning Services](https://docs.microsoft.com/en-us/azure/machine-learning/service/), to quickly and easily deploy new internal applications to make sales and customer predictions.   
* [Paychex](https://customers.microsoft.com/en-us/story/paychex-azure-sql-database-us): Paychex is a human capital management firm that serves more than 650,000 businesses across the US and Europe. They needed a way to separately manage the time and pay management for each of their businesses, and cut costs. They opted for [elastic pools](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool), which allowed them to simplify the management and enable resource sharing between separate databases to lower costs.  

If you want to dive deeper into the deployment options and how to choose, check out the following resources:  
* [Microsoft Customer Stories](https://customers.microsoft.com/en-us/home?sq=&ff=&p=0) for many more stories similar to the ones above. You can use this to explore various use cases, industries, and solutions.  
* [Choose the right deployment option in Azure SQL](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-paas-vs-sql-server-iaas) is a page in the documentation regularly updated to help provide insight into making the decisions between the Azure SQL options.
* [Choosing your database migration path to Azure](https://azure.microsoft.com/mediahandler/files/resourcefiles/choosing-your-database-migration-path-to-azure/Choosing_your_database_migration_path_to_Azure.pdf) is a white paper that talks about tools for discovering, assessing, planning and migrating SQL databases to Azure. This workshop will refer to it several times, and it's a highly recommended read. Chapter 5 deeply discusses choosing the right deployment option.  
* [Feature comparison between SQL database and SQL managed instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-features) 
* There are also tools covered later in this module that can help in recommending a deployment option.  


### Azure SQL service tiers

Once you've landed on a deployment option, the next thing to determine is the service tier.  

#### SQL Server on Azure Virtual Machines options

For Azure SQL VMs, you'll want to review the [guidance on images](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-iaas-overview), the [quick checklist](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-performance) to obtain optimal performance of SQL Server on Azure Virtual Machines, and the guidance for [storage configuration](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-storage-configuration).  

Recently, [Resource Provider](http://www.aka.ms/sqlvm_rp_documentation) was [announced](http://www.aka.ms/sqlvm_rp), which brings the functionality of Azure Marketplace images to SQL Server instances self-installed on Azure VMs.  

> Note: If you're specifically looking at SQL Server on RHEL Azure VMs, there's a full operations guide available [here](https://azure.microsoft.com/en-us/resources/sql-server-on-rhel-azure-vms-operations-guide/
).  
  
> Note: In an earlier module of this workshop, you learned about some of the problems SQL Server 2019 is solving. The same applies in an Azure SQL VM (if you choose 2019 as the target).  

#### Azure SQL Database options  

For Azure SQL Database, which is the focus of this module, there are several options and tiers available, and the choices will depend on the scenario.  

There are a few main decisions to be made, which will be explored next.    

*Decision 1: Choose the purchasing model*  
You have two options, [virtual core (vCore)-based](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-vcore) (recommended) or [Database transaction unit (DTU)-based](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models
). For the purposes of this workshop, we'll focus on the vCore purchasing model (recommended), but you can [compare vCores and DTUs here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models
).  

The vCore-based model allows you to independently choose compute and storage resources. This model also allows you to use [Azure Hybrid Benefit for SQL Server](https://azure.microsoft.com/pricing/hybrid-benefit/) to gain cost savings. In the [vCore model](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-vcore), you pay for:  

* Compute resources (the service tier + the number of vCores and the amount of memory + the generation of hardware).
* The type and amount of data and log storage.
* Backup storage (RA-GRS).

*Decision 2: Choose service tier for availability*  
There are three tiers available in the vCore model for Azure SQL Database:
* **[General purpose](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-general-purpose)**: Most business workloads. Offers budget-oriented, balanced, and scalable compute and storage options.
* **[Business critical](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-business-critical)**: Business applications with high I/O requirements. Offers highest resilience to failures by using several isolated replicas.
* **[Hyperscale](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-hyperscale)**: Most business workloads with highly scalable storage and read-scale requirements. *Currently only available for single databases, not managed instances*.  

A member of the Product Group recently released a [blog](https://azure.microsoft.com/en-gb/blog/understanding-and-leveraging-azure-sql-database-sla/) and [video](https://www.youtube.com/watch?v=l7FUNJd5TSE) explaining the SLA (service level agreements that set an expectation for uptime and performance). This resource will help you make an informed decision about which tier to move to.  

For a deeper explanation between the three tiers (including scenarios), you can also refer to the [service-tier characteristics](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-vcore#service-tier-characteristics) in the documentation.  

*Decision 3: Provisioned or serverless compute?*  
If you choose **General Purpose within Single databases**, you have an additional decision to make regarding the compute that you pay for:
* **Provisioned compute** is meant for more regular usage patterns with higher average compute utilization over time, or multiple databases using elastic pools. 
* **Serverless compute** is meant for intermittent, unpredictable usage with lower average compute utilization over time. Serverless has auto-pause and resume capabilities (with a time delay you set), meaning when your database is paused, you only pay for storage.  

For a deeper explanation between the two compute options (including scenarios), you can refer to the detailed [comparison in the documentation](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-serverless#comparison-with-provisioned-compute-tier).  

> If you're looking for compute cost saving opportunities, you can prepay for compute resources with [Azure SQL Database reserved capacity](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-reserved-capacity).

*Decision 4: Choose hardware generation*  
The vCore model lets you choose the generation of hardware:  
* **Gen4**: Up to 24 logical CPUs based on Intel E5-2673 v3 (Haswell) 2.4-GHz processors, vCore = 1 PP (physical core), 7 GB per core, attached SSD
* **Gen5**: Up to 80 logical CPUs based on Intel E5-2673 v4 (Broadwell) 2.3-GHz processors, vCore = 1 LP (hyper-thread), 5.1 GB per core, fast eNVM SSD  

Basically, Gen4 hardware offers substantially more memory per vCore. However, Gen5 hardware allows you to scale up compute resources much higher. 

> Note: If you choose General Purpose within Single databases and want to use the serverless compute tier, Gen5 hardware is the only option.  

*Summary*  
As you've hopefully noticed, while there are a lot of options, Azure is able to provide flexibility so you get exactly what you need, nothing less. A summary of the service tier options with some additional considerations is included below, but be sure to check out [pricing information](https://azure.microsoft.com/en-us/pricing/details/sql-database/managed/) for the latest details.

![Azure SQL tiers](../graphics/media/service-tiers-summary.png)


> Note: Data Migration Assistant (covered later in this module) runs scans that can help you choose some of the options as well as the SKU. [Learn more here](https://docs.microsoft.com/en-us/sql/dma/dma-sku-recommend-sql-db?view=sql-server-2017).





<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="4.2">4.2 Fundamentals of Azure SQL</h2></a>

There is not enough time in this workshop to review all of the fundamentals at a deep level here. You'll receive pointers and an overview of Azure SQL platform benefits. Then, basic networking for Azure SQL will be covered. This section will go quickly in the workshop, but it's recommended to spend some time reviewing the many resources provided in this section.    

### Azure SQL fundamentals    

Azure SQL Database (including single databases, elastic pools, and managed instances) is a fully managed Database Engine that handles most of the database management functions such as upgrading, patching, backups, and monitoring without user involvement. To learn more about the capabilities, see below:  
* [Business continuity](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-business-continuity) enables your business to continue operating in the face of disruption, particularly to its computing infrastructure.
* [High availability](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-high-availability) of Azure SQL Database guarantees your databases are up and running 99.99% of the time, no need to worry about maintenance/downtimes.
* [Automated backups](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-automated-backups) are created and use Azure read-access geo-redundant storage (RA-GRS) to provide geo-redundancy.
* [Long term backup retention](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-long-term-retention) enables you to store specific full databases for up to 10 years.
* [Geo-replication](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-geo-replication-overview) by creating readable replicas of your database in the same or different data center (region).
* [Scale](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-scale-resources) by easily adding more resources (CPU, memory, storage) without long provisioning.
* [Advanced security](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-index) detects threats and vulnerabilities in your databases and enables you to secure your data.
* [Automatic tuning](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-automatic-tuning) analyzes your workload and provides you the recommendations that can optimize performance of your applications by adding indexes, removing unused indexes, and automatically fixing the query plan issues.
* [Built-in monitoring](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-azure-sql) capabilities enable you to get the insights into performance of your databases and workload, and troubleshoot the performance issues.
* [Built-in intelligence](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-intelligent-insights) automatically identifies the potential issues in your workload and provides you the recommendations that can [help you to fix the problems](https://azure.microsoft.com/en-us/blog/ai-helped-troubleshoot-an-intermittent-sql-database-performance-issue-in-one-day/). 

In addition to the resources linked to above, several [slide decks](https://aka.ms/azuresqlslides) are available (with notes and animations) that you can review to learn more. You can also check out the [Core Cloud Services - Azure architecture and service guarantees](https://docs.microsoft.com/en-us/learn/modules/explore-azure-infrastructure/) module from Microsoft Learn.  

> Note: Many benefits typically thought of as Platform as a Service (PaaS) are surfacing in Infrastructure as a Service (IaaS). You can learn more about automated updates, automated backups, high availability, and performance provided in Azure SQL VMs [here](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-iaas-overview).

### Networking fundamentals  

Networking is a crucial part to moving to Azure. You'll want to work closely with networking and infrastructure individuals to make sure your deployment to Azure is secure, performant, and scalable. While you may not need to be the expert, having a foundational knowledge is very important. You'll see a few explanations and links to additional courses and information to learn more.  

*Glossary of basic networking terms*
|                                                                                                     |                                                                                                         | 
|-----------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------| 
| **Term**                                                                                                | **Description**                                                                                             | 
| [Azure Virtual Network (VNet)](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)	|Logically isolated network on Azure <br> Allows resources to securely communicate with each other, the internet, and on-prem networks <br>Scoped to a single region <br> Segmented into one or more subnets                                                               |                                                                                                         | 
| [Subnets](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet)                                                                                             | Segmentation of VNets to organize and secure resources in discrete sections                             | 
| [VNet Peering](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)                                                                                        | Used to connected multiple virtual networks (can be different regions)                                  | 
| [VPN Gateway](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways)                                                                                         | Provides secure connection between Azure VNet and on-prem over the internet                             | 
| [ExpressRoute](https://docs.microsoft.com/en-us/azure/expressroute/)                                                                                        | Provides secure and private connection between Azure and on-prem                                        | 
| [Network security group (NSG)](https://blogs.msdn.microsoft.com/igorpag/2016/05/14/azure-network-security-groups-nsg-best-practices-and-lessons-learned/)                                                                        | Allows or denies inbound traffic to your Azure resources (like a cloud-level firewall for your network) | 


#### What is a virtual network?  

A [virtual network](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview) is a logically isolated network on Azure. Azure virtual networks will be familiar to you if you've set up networks on Hyper-V, VMware, or even on other public clouds. A virtual network allows Azure resources to securely communicate with each other, the internet, and on-premises networks. A virtual network is scoped to a single region; however, multiple virtual networks from different regions can be connected together using [virtual network peering](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview).
Virtual networks can be segmented into one or more subnets. Subnets help you organize and secure your resources in discrete sections.  

For example, a web, application, and data tier architecture may each have a single VM or service. All three are in the same virtual network but are in separate subnets. Users interact with the web tier directly, so that VM has a public IP address along with a private IP address. Users don't interact with the application or data tiers, so these VMs/services each have a private IP address only.  

You can also keep your service or data tiers in your on-premises network, placing your web tier into the cloud, but keeping tight control over other aspects of your application. A [VPN gateway (or virtual network gateway)](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways), enables this hybrid scenario. It can provide a secure connection between an Azure Virtual Network and an on-premises location over the internet.  

Azure manages the physical hardware for you. You configure virtual networks and gateways through software, which enables you to treat a virtual network just like your own network. You choose which networks your virtual network can reach, whether that's the public internet or other networks in the private IP address space.  

Additionally, a [network security group (NSG)](https://blogs.msdn.microsoft.com/igorpag/2016/05/14/azure-network-security-groups-nsg-best-practices-and-lessons-learned/) allows or denies inbound traffic to your Azure resources. Think of a network security group as a cloud-level firewall for your network.  

> If you want to learn more about Azure networking (above is just the beginning), check out the following modules on Microsoft Learn:
> * [Core Cloud Services - Azure networking options](https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-networking/)  
> * [Deeper module on Azure networking and configuration](https://docs.microsoft.com/en-us/learn/modules/configure-network-for-azure-virtual-machines/)  
> * [Connect your on-prem network to Azure with VPN Gateway](https://docs.microsoft.com/en-us/learn/modules/connect-on-premises-network-with-vpn-gateway/)  
> * [Design network for performance and scale in Azure](https://docs.microsoft.com/en-us/learn/modules/design-for-performance-and-scalability-in-azure/)
> * [Distribute services across Azure virtual networks and integrate them with VNet peering](https://docs.microsoft.com/en-us/learn/modules/integrate-vnets-with-vnet-peering/)
> * [Secure and isolate access to Azure resources by using network security groups and service endpoints](https://docs.microsoft.com/en-us/learn/modules/secure-and-isolate-with-nsg-and-service-endpoints/)
> * [Connect your on-premises network to the Microsoft global network by using ExpressRoute](https://docs.microsoft.com/en-us/learn/modules/connect-on-premises-network-with-expressroute/)

> You'll then want to check out the following guides:
> * [Best practices to set up networking for workloads moving to Azure](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/migrate-best-practices-networking)
> * [Azure virtual network FAQ](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-faq#virtual-network-service-endpoints)
> * [Networking limits](https://docs.microsoft.com/en-us/azure/azure-subscription-service-limits?toc=%2fazure%2fvirtual-network%2ftoc.json#networking-limits)

#### Connectivity architecture for single databases and elastic pools  

The following diagram provides a high-level overview of the connectivity architecture.

![Azure SQL DB Connectivity](../graphics/media/azure-connectivity-db.png)  

The following steps describe how a connection is established to an Azure SQL database:
* Clients connect to the gateway, that has a public IP address and listens on port 1433.
* The gateway, depending on the effective connection policy, redirects or proxies the traffic to the right database cluster.
* Inside the database cluster traffic is forwarded to the appropriate Azure SQL database.  

There are three options for the connection policy setting of a SQL Database server:  
* **Redirect (recommended)**: Clients establish connections directly to the node hosting the database. After (1) the TCP session is established to the Azure SQL database, the client session is then redirected to the right database cluster with a change to the destination virtual IP from that of the Azure SQL Database gateway to that of the cluster. Thereafter, (2) all subsequent packets flow directly to the cluster, bypassing the Azure SQL Database gateway, thus improving performance for latency and throughput.  
* **Proxy**: In this mode, all connections are proxied via the Azure SQL Database gateways. Choosing this mode can result in higher latency and lower throughput, depending on nature of the workload.  
* **Default**: This is the connection policy in effect on all servers after creation unless you explicitly alter the connection policy to either *Proxy* or *Redirect*. The effective policy depends on whether connections originate from within Azure (*Redirect*) or outside of Azure (*Proxy*).

> For more information, including scripts to change connection settings, refer to the [documentation](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-connectivity-architecture).  

#### Connectivity architecture for managed instances  

At a high level, a managed instance is a set of service components. These components are hosted on a dedicated set of isolated virtual machines that run inside the customer's virtual network subnet. These machines form a **virtual cluster**.  

A virtual cluster can host multiple managed instances. If needed, the cluster automatically expands or contracts when the customer changes the number of provisioned instances in the subnet.  

Customer applications can connect to managed instances and can query and update databases inside the virtual network, peered virtual network, or network connected by VPN or Azure ExpressRoute. This network must use an endpoint and a private IP address.  

![Azure SQL MI Connectivity](../graphics/media/azure-connectivity-arch.png)

Management and deployment services (which run outside the virtual network) connect and manage the managed instance with a management endpoint that maps to an external load balancer. This endpoint is inside the instance's virtual cluster. The management endpoint is protected by a built-in firewall on the network level. Microsoft services and a managed instance (via the management endpoint) connect over the endpoints that have public IP addresses, so when a managed instance creates an outbound connection, it looks like it's coming from this public IP address. Find more information about determining the management endpoint's IP address, traffic, and the built-in firewall [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-connectivity-architecture#management-endpoint).  


Managed instances must be deployed in a dedicated subnet inside the virtual network. There are [certain network requirements for the subnet](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-connectivity-architecture#network-requirements) that is to contain a managed instance. You should review and prepare accordingly.  

Deeper dive into connectivity architecture for managed instances can be found [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-connectivity-architecture).  


> If you want to dive deeper into networking for Azure SQL, check out the following resources:  
> * [The ultimate guide for creating and configuring Azure SQL Managed Instance environment](https://medium.com/azure-sqldb-managed-instance/the-ultimate-guide-for-creating-and-configuring-azure-sql-managed-instance-environment-91ff58c0be01)
> * [Azure SQL Database and Data Warehouse network access controls](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-networkaccess-overview)
> * [Azure SQL Network Security](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-overview#network-security)
> * [Create a virtual network of Azure SQL Database Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-create-vnet-subnet)
> * [Video: VNET Azure SQL Database](https://www.youtube.com/watch?v=jAeAjOlkxAU&t=188s)

<br>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="4.3">4.3 Migration process</h2></a>

Tailspin Toys has spent some time with you learning more about the benefits of Azure SQL and the Azure platform overall. They're feeling more comfortable with the networking and security aspects as well. Based on their research, they've decided to migrate the Tailspin Toys database to Azure as a PoC for migrating larger workloads.  

The general process for [migrating assets to Azure](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/getting-started/migrate) (whether it's apps, infrastructure, or data) is as follows:  
* **Assess**: Evaluate an existing asset and establish a plan for migration of the asset.
* **Migrate**: Replicate the functionality of an asset in the cloud.
* **Optimize**: Balance the performance, cost, access, and operational capacity of a cloud asset.
* **Secure and manage**: Ensure a cloud asset is ready for ongoing operations.


In guiding Tailspin Toys through the *data* migration journey, it's helpful to leverage the following process that is specific to data:  
![Data migration process](../graphics/media/data-migration-process.png)  

Let's take a closer look at the steps in this three-phase process. There are also some references and tools to learn more.    

| STAGE          | PHASE                             | DESCRIPTION                                                                                                                | RESOURCES                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|----------------|-----------------------------------|----------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Pre-migration  | Discover                          | Inventory database assets, and application stack discovery.                                                                | <li>[Azure Migrate](https://docs.microsoft.com/azure/migrate/migrate-overview) for managing the whole migration process</li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|                | Assess                            | Assess workloads and fix recommendations.                                                                                  | <li>[MAP Toolkit for inventory, assessment, and reporting](https://www.microsoft.com/en-us/download/details.aspx?id=7826) </li> <li>[Data workload assessment model and tool](https://github.com/Microsoft/DataMigrationTeam/tree/master/Data%20Workload%20Assessment%20Model%20and%20Tool)</li> <li>[Database Experimentation Assistant (DEA)](https://www.microsoft.com/en-us/download/details.aspx?id=54090) for upgrades</li>   <li>[DMA SKU Recommender](https://docs.microsoft.com/en-us/sql/dma/dma-sku-recommend-sql-db?view=sql-server-2017)  for Azure SQL </li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|                | Convert                           | Convert the source schema to work in the target environment. This is only relevant for heterogeneous migrations.           | <li>[SQL Server Migration Assistant](https://docs.microsoft.com/en-us/sql/ssma/sql-server-migration-assistant?view=sql-server-2017)</li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Migration      | Migrate schema, data, and objects | Migrate the source schema, and then migrate the source data to the target.                                                 | <li>[Migrate with Azure Database Migration Services (DMS)](https://docs.microsoft.com/en-us/azure/dms/) (pull model) </li><li>[Migrate to Azure with Data Migration Assistant (DMA)](https://docs.microsoft.com/en-us/sql/dma/dma-migrateonpremsqltosqldb?view=sql-server-2017) (push model) </li><li>[Online migrations](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online#register-the-microsoftdatamigration-resource-provider) with DMS </li><li>[Offline migrations](https://docs.microsoft.com/azure/dms/tutorial-sql-server-managed-instance-online#register-the-microsoftdatamigration-resource-provider) with DMS  </li><li>[Utility](https://github.com/Microsoft/DataMigrationTeam/tree/master/IP%20and%20Scripts/MoveLogins)  to move on-premises SQL Server logins to Azure SQL MI </li><li> [Bulk database creation](https://github.com/Microsoft/DataMigrationTeam/tree/master/Bulk%20Database%20Creation%20with%20PowerShell)  with PowerShell  </li><li>[Bulk schema deployment](https://github.com/Microsoft/DataMigrationTeam/tree/master/Bulk%20Schema%20Deployment%20with%20MSSQL-Scripter%20&%20PowerShell) with MSSQL-Scripter and PowerShell  </li><li>[Migrate SSIS](https://docs.microsoft.com/azure/dms/how-to-migrate-ssis-packages) packages to Azure  </li><li> SSRS  can be deployed using SQL Server on an Azure VM or rewritten in Power BI  </li><li> Migrate [SSAS to Azure Analysis Services](https://azure.microsoft.com/en-us/resources/videos/azure-analysis-services-moving-models/)</li>|
|                | Sync data                         | Sync your target schema and data with the source. This is only relevant for minimal-downtime migrations.                   | <li>[Azure Data Sync](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-sync-data) for syncing data bi-directionally on-prem and in Azure  </li><li>[Transactional replication](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-transactional-replication) for migrations by continuously publishing the changes  </li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|                | Cutover                           | Cut over from the source to the target environment. This is only relevant for minimal-downtime migrations.                 | <li>[Cutover with DMS](https://docs.microsoft.com/en-us/azure/dms/tutorial-sql-server-managed-instance-online#performing-migration-cutover)</li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Post-migration | Remediate applications            | Iteratively make any necessary changes to your applications.                                                               |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|                | Perform tests                     | Iteratively run functional and performance tests.                                                                          | <li>[Data Quality Solution available from the partner QuerySurge](http://www.querysurge.com/company/partners/microsoft) </li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|                | Optimize                          | Based on the tests you performed, address any performance issues, and then retest to confirm the performance improvements. | <li>[Post-migration Validation and Optimization Guide](https://docs.microsoft.com/en-us/sql/relational-databases/post-migration-validation-and-optimization-guide)  </li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |


Above is a survey of some of the resources and tips available for going through the migration journey to Azure (you can find a [full list of tools based on phase and target here](https://docs.microsoft.com/en-us/azure/dms/dms-tools-matrix)).  

Don't get overwhelmed, the number of resources shows the dedication Microsoft and partners have to helping you move successfully to the cloud. We recommend using the [Data migration guide](https://datamigration.microsoft.com/) which allows you to pick your source and target, and then guides you step-by-step through your specific migration journey.  

Additionally, you can check out the [Azure migration center](https://azure.microsoft.com/en-us/migration/) which includes detailed information about the migration journey, the [Azure Migrate Program (AMP)](https://azure.microsoft.com/en-us/migration/migration-program/) where you can get support, migration partners, webinars, and more.  

With your help, Tailspin Toys Gaming decided to apply for the Azure Migrate Program, to get support and guidance from Microsoft and partners. Then, they leveraged the integration of Azure Migrate, Data Migration Assistant, and Azure Database Migration Service to migrate their databases.  

Once the Tailspin Toys Gaming division has migrated to Azure, the overall corporation may choose to scale the migration to Azure. In that case, [refer to guidance here](https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/migrate/azure-best-practices/contoso-migration-scale
).
 

<br>


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true"><a name="4.4">4.4 Database discovery and assessment</h2></a>



In this series of hands-on labs (throughout Modules 4 and 5), you will implement a proof-of-concept (PoC) for migrating an on-premises SQL Server 2008 R2 database into Azure SQL Database Managed Instance (SQL MI). You will perform assessments to reveal any feature parity and compatibility issues between the on-premises SQL Server 2008 R2 database and the managed database offerings in Azure. You will then migrate the customer's on-premises gamer information, web application and database into Azure, with minimal to no down-time. Finally, you will enable some of the advanced SQL features available in SQL MI to improve security and performance in the customer's application.

At the end of these hands-on labs, you will be better able to implement a cloud migration solution for business-critical applications and databases.  

> **Important Note!** These labs were modified from an existing day-long, hands-on-labs workshop to fit into this workshop. If you'd like to access the extended version of these labs refer to [MCW: Migrating SQL databases to Azure](https://github.com/microsoft/MCW-Migrating-SQL-databases-to-Azure).



## Solution architecture

Below is a diagram of the solution architecture that Tailspin Toys decided to go with, and what you will build in this lab. Please study this carefully, so you understand the whole of the solution as you are working on the various components.

![This solution diagram includes a virtual network containing SQL MI in a isolated subnet, along with a JumpBox VM and Database Migration Service in a management subnet. The MI Subnet displays both the primary managed instance, along with a read-only replica, which is accessed by reports from the web app. The web app connects to SQL MI via a subnet gateway and point-to-site VPN. The web app is published to App Services using Visual Studio 2019. An online data migration is conducted from the on-premises SQL Server to SQL MI using the Azure Database Migration Service, which reads backup files from an SMB network share.](../graphics/media/preferred-solution-architecture.png "Preferred Solution diagram")

Throughout the solution, you can use [Azure Migrate](https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview) as the central hub to track the discovery, assessment, and migration of Tailspin Toys. The solution begins with using the [Microsoft Data Migration Assistant](https://docs.microsoft.com/en-us/sql/dma/dma-overview?view=sql-server-2017) to perform assessments of feature parity and compatibility of the on-premises SQL Server 2008 R2 database against both Azure SQL Database (Azure SQL DB) and Azure SQL Database Managed Instance (SQL MI), with the goal of migrating the `TailspinToys` database into an Azure PaaS offering with minimal or no changes. After completing the assessments and reviewing the findings, the SQL Server 2008 R2 database is migrated into SQL MI using the Azure Database Migration Service's online data migration option. This allows the database to be migrated with little to no downtime, by using a backup and transaction logs stored in an SMB network share.  

They'll also leverage their existing licenses to get [Azure Hybrid Benefits](https://azure.microsoft.com/en-us/pricing/hybrid-benefit/), and they'll prepay for [reserved capacity](https://azure.microsoft.com/en-us/blog/announcing-general-availability-of-azure-sql-database-reserved-capacity/
). This will help them save money from the start.  

The web app is deployed to an Azure App Service Web App using Visual Studio 2019. Once the database has been migrated and cutover, the `TailspinToysWeb` application is configured to talk to the SQL MI VNet through a virtual network gateway using [point-to-site VPN](https://docs.microsoft.com/en-us/azure/vpn-gateway/point-to-site-about), and its connection strings are updated to point to the new SQL MI database.

In SQL MI, several features of Azure SQL Database are examined. [Advanced Data Security (ADS)](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security?view=sql-server-2017) is enabled and [Data Discovery and Classification](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-data-discovery-and-classification?view=sql-server-2017) is used to better understand the data and potential compliance issues with data in the database. The ADS [Vulnerability Assessment](https://docs.microsoft.com/en-us/azure/sql-database/sql-vulnerability-assessment?view=sql-server-2017) is used to identify potential security vulnerabilities and issues in the database, and those finding are used to mitigate one finding by enabling [Transparent Data Encryption](https://docs.microsoft.com/en-us/azure/sql-database/transparent-data-encryption-azure-sql?view=sql-server-2017) in the database. [Dynamic Data Masking (DDM)](https://docs.microsoft.com/en-us/sql/relational-databases/security/dynamic-data-masking?view=sql-server-2017) is used to prevent sensitive data from appearing when querying the database. Finally, [Read Scale-out](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out) is used to point reports on the Tailspin Toys web app to a read-only secondary, allowing reporting to occur without impacting the performance of the primary database.  

<h2><p>Activities</h2></p>


Proceed directly to the following Activities from **Lab: Database Discovery and Assessment for Migrating to Azure** for the hands-on exercises for Tailspin Toys Gaming. When are you done with these activities come back here for the next section as guided by your instructor.  

> **Note:**  
> If you are attending this lab as part of a day-long workshop, all of the activities below **except** Activity 2 should be skipped (they will be demoed in class). **You must complete Activity 2** prior to moving to the next module.

<h3><p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="4.4.1"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-DatabaseDiscoveryAndAssessementForMigratingToAzure.md#Activity-1">Activity 1: Set up Azure Migrate</p></a></h3>

In this activity, you'll set up Azure Migrate, and explore some of the new integrations between Microsoft's Data Migration Assistant (DMA) and Azure Database Migration Services (DMS).  

<h3><p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="4.4.2"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-DatabaseDiscoveryAndAssessementForMigratingToAzure.md#Activity-2">Activity 2: Restore TailspinToys on the SQLServer2008 VM</h3></p></a>

> If you are attending this lab as part of a day-long workshop, you **must complete this activity prior to moving to the next module**. The rest of the activities in this lab can be skipped, they were demoed earlier.

<!--TODO: Can we make it so this part is done on each VM for each user ahead of the labs?-->

Before you begin the assessments, you need to restore a copy of the `TailspinToys` database in your SQL Server 2008 R2 instance. In this task, you will create an RDP connection to the SqlServer2008 VM and then restore the `TailspinToys` database onto the SQL Server 2008 R2 instance using a backup provided by Tailspin Toys.

<h3><p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="4.4.3"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-DatabaseDiscoveryAndAssessementForMigratingToAzure.md#Activity-3">Activity 3: Perform assessment for migration to Azure SQL Database</h3></p></a>

In this task, you will use the Microsoft Data Migration Assistant (DMA) to perform an assessment of the `TailspinToys` database against Azure SQL Database (Azure SQL DB). The assessment will provide a report about any feature parity and compatibility issues between the on-premises database and the Azure SQL DB service.  

<h3><p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><a name="4.4.4"><a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/Lab-DatabaseDiscoveryAndAssessementForMigratingToAzure.md#Activity-4">Activity 4: Perform assessment for migration to Azure SQL Database Managed Instance</h3></p></a>

With one PaaS offering ruled out due to feature parity, you will now perform a second assessment. In this task, you will use DMA to perform an assessment of the `TailspinToys` database against Azure SQL Database Managed Instance (SQL MI). The assessment will provide a report about any feature parity and compatibility issues between the on-premises database and the SQL MI service.





<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>
<ul>
    <li><a href="https://datamigration.microsoft.com/
    " target="_blank">Azure Database Migration Guide</a> contains lots of resources that will help in guiding and supporting database migrations to Azure.</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview
    " target="_blank">Azure Migrate Documentation</a> contains more information, guidance, and pointers on how to migrate your entire on-premises estate to Azure.</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/migrate/migrate-services-overview
    " target="_blank">Data Migration Assistant Documentation</a> contains more information and best practices around the DMA tool explored in this module.</li>
    <li><a href="https://azure.microsoft.com/mediahandler/files/resourcefiles/choosing-your-database-migration-path-to-azure/Choosing_your_database_migration_path_to_Azure.pdf
    " target="_blank">Choosing your database migration path to Azure</a> is a white paper created by Microsoft for deeper understanding of how to modernize and migrate on-premises SQL Server to Azure.</li>
    <li><a href="https://aka.ms/azuresqlslides
    " target="_blank">In one location, ready to use or review slides</a> about Azure SQL are hosted online, including a few design sessions that could be redelivered. Feel free to use these resources with your customers or at events.</li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/geopin.png?raw=true"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/anna/SQLGroundToCloud/sqlgroundtocloud/05-MigratingToAzureSQL.md" target="_blank"><i> 05 - Migrating to Azure SQL</i></a>.