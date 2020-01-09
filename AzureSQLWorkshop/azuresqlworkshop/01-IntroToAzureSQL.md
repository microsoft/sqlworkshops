![](../graphics/microsoftlogo.png)

# The Azure SQL Workshop

#### <i>A Microsoft workshop from the SQL team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>01 - Introduction to Azure SQL</h2>

In this module, you'll start with a brief history of why and how we built Azure SQL, then you’ll then learn about the various deployment options and service tiers, including what to use when. This includes Azure SQL Database and Azure SQL managed instance. Understanding what Platform as a Service (PaaS) encompasses and how it compares to the SQL Server “box” will help level-set what you get (and don’t get) when you move to the cloud. We’ll cover deployment, configuration, and other getting started related tasks for Azure SQL (hands-on). 

In each module you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic.

(<a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/00-Prerequisites.md" target="_blank">Make sure you check out the <b>Prerequisites</b> page before you start</a>. You'll need all of the items loaded there before you can proceed with the workshop.)

In this module, you'll cover these topics:  
[1.1](#1.1): History   
[1.2](#1.2): Azure SQL Overview   
[1.3](#1.3): Deploy and Configure Azure SQL  


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1.1">1.1 History</h2></a>

Before you learn about Azure SQL and where it's going, let's briefly consider where it started. In 2008, at the [Microsoft Professional Developers Conference](https://www.youtube.com/watch?v=otuf3goxLsg), Microsoft's Chief Software Architect (at the time) [Ray Ozzie announced](https://news.microsoft.com/2008/10/27/microsoft-unveils-windows-azure-at-professional-developers-conference/#IP8XlBTCMpvORgaV.97) the new cloud computing operating system, Windows Azure (or "Project Red Dog"), which was later changed to Microsoft Azure. One of the five key components of the Azure Services Platform launch was "Microsoft SQL Services." From the beginning, SQL has been a big part of Azure. SQL Azure (then renamed to Azure SQL Database and now expanded to Azure SQL) was created to provide a cloud-hosted version of SQL Server.  

[An explanation](https://social.technet.microsoft.com/wiki/contents/articles/1308.select-an-edition-of-sql-server-for-application-development/revision/7.aspx) of when you would want to use the early Azure SQL Database (2010) is as follows: [Azure SQL Database] is a cloud database offering that Microsoft provides as part of the Azure cloud computing platform. Unlike other editions of SQL Server, you do not need to provision hardware for, install or patch [Azure SQL Database]; Microsoft maintains the platform for you. You also do not need to architect a database installation for scalability, high availability or disaster recovery as these features are provided automatically by the service. Any application that uses [Azure SQL Database] must have Internet access in order to connect to the database.  

This explanation still remains valid today, though the capabilities around security, performance, availability, and scale have been enhanced greatly. There are now multiple deployment options with the flexibility to scale to your needs, and there have been over seven million deployments of some form of Azure SQL.  

Since 2008, SQL Server has changed a lot and Azure SQL has changed a lot. It's no surprise then that the role of the SQL Server professional has also changed a lot. The goal of this course is to help SQL Server professionals translate their existing skills to become not only better SQL Server professionals, but also Azure SQL professionals.  

<br>

<img style="height: 400; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="linkToPictureEndingIn.png">

<br>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1.2">1.2 Azure SQL Deployment Options</h2></a>

Within the umbrella of the "Azure SQL" term, there are many deployment options and choices to be made in order to tailor to various customers' needs. While there are a lot of options, this is not meant to confuse or complicate things, but rather to give customers the flexibility to get and pay for exactly what they need. This topic will cover some of the challenges and scenarios that lead to choosing various Azure SQL deployment options, as well as some of the technical specifications for each of those options. The deployment options discussed in this topic include Azure SQL virtual machines, Azure SQL managed instances, Azure SQL Databases, and Azure SQL "pools" (Azure SQL Instance Pools and Azure SQL Elastic Pools).  

![](../graphics/azuresql.png)  

At the highest level, when you're considering your options, the first question you may ask is, "What level of scope do I want?" As you move from virtual machines to managed instances to databases, your management scope decreases. With virtual machines, you not only get access to but are also responsible for the OS and the SQL Server. With managed instance, the OS is abstracted from you and now you have access to only the SQL Server. And the highest abstraction is SQL database where you just get a database, and you don't have access to instance-level features or the OS.  

## Azure SQL virtual machine
![](../graphics/sqlvm.png)  
*[Extended Security Updates](https://www.microsoft.com/en-us/cloud-platform/extended-security-updates) worth 75% of license every year for the next three years after End of Service (July 9, 2019). Applicable to Azure Marketplace images, customers using customer SQL Server 2008/R2 custom images can download the Extended Security Updates for free and manually apply.  
**[GigaOm Performance Study](https://gigaom.com/report/sql-transaction-processing-price-performance-testing/)

An Azure SQL virtual machine is simply a version of SQL Server that you specify running in an Azure VM. It's just SQL Server, so all of your SQL Server skills should directly transfer, though we can help automate backups and security patches. Azure SQL virtual machines are referred to as [Infrastructure as a Service (IaaS)](https://azure.microsoft.com/en-us/overview/what-is-iaas/). You are responsible for updating and patching the OS and SQL Server (apart from critical SQL security patches), but you have access to the full capabilities of SQL Server.   

The customer example for Azure SQL virtual machines is [Allscripts](https://customers.microsoft.com/en-us/story/allscripts-partner-professional-services-azure). Allscripts is a leading healthcare software manufacturer, serving physician practices, hospitals, health plans, and Big Pharma. To transform its applications frequently and host them securely and reliably, Allscripts wanted to move to Azure quickly. In just three weeks, the company lifted and shifted dozens of acquired applications running on ~1,000 virtual machines to Azure with [Azure Site Recovery](https://azure.microsoft.com/en-us/services/site-recovery/).  

This isn't the focus of this workshop, but if you're considering Azure SQL VMs, you'll want to review the [guidance on images to choose from](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-iaas-overview), the [quick checklist](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-performance) to obtain optimal performance of Azure SQL VMs, and the guidance for [storage configuration](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-sql-server-storage-configuration).  

> Note: if you installed SQL Server on an Azure VM yourself (as opposed to leveraging a [pre-installed Azure Marketplace image](https://azuremarketplace.microsoft.com/en-us/marketplace/apps?search=sql%20server&page=1&filters=virtual-machine-images%3Bmicrosoft)), [Resource Provider](http://www.aka.ms/sqlvm_rp_documentation) can bring the functionality of Azure Marketplace images to SQL Server instances self-installed on Azure VMs.  

> Note: If you're specifically looking at SQL Server on RHEL Azure VMs, there's a full operations guide available [here](https://azure.microsoft.com/en-us/resources/sql-server-on-rhel-azure-vms-operations-guide/
).  

## IaaS vs PaaS

Azure SQL virtual machines are considered IaaS. The other deployment options in the Azure SQL umbrella (Azure SQL managed instance and Azure SQL Database) are [Platform as a Service (Paas)](https://azure.microsoft.com/en-us/overview/what-is-paas/) deployments. These PaaS Azure SQL deployment options use fully managed Database Engine that automates most of the database management functions such as upgrading, patching, backups, and monitoring. Throughout this course, you'll learn much more about the benefits and capabilities that the PaaS deployment options enable and how to optimally configure, manage, and troubleshoot them, but some highlights are listed below:  

* [Business continuity](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-business-continuity) enables your business to continue operating in the face of disruption, particularly to its computing infrastructure.
* [High availability](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-high-availability) of Azure SQL Database guarantees your databases are up and running 99.99% of the time, no need to worry about maintenance/downtimes.
* [Automated backups](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-automated-backups) are created and use Azure read-access geo-redundant storage (RA-GRS) to provide geo-redundancy.
* [Long term backup retention](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-long-term-retention) enables you to store specific full databases for up to 10 years.
* [Geo-replication](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-active-geo-replication) by creating readable replicas of your database in the same or different data center (region).
* [Scale](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-scale-resources) by easily adding more resources (CPU, memory, storage) without long provisioning.
* Network Security
    * [Azure SQL Database (single database and elastic pool)](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-overview#network-security) provides firewalls to prevent network access to the database server until access is explicitly granted based on IP address or Azure Virtual Network traffic origin.
    * [Azure SQL Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-connectivity-architecture) has an extra layer of security in providing native virtual network implementation and connectivity to your on-premises environment using [Azure ExpressRoute](https://docs.microsoft.com/en-us/azure/expressroute/) or [VPN Gateway](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways).
* [Advanced security](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-index) detects threats and vulnerabilities in your databases and enables you to secure your data.
* [Automatic tuning](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-automatic-tuning) analyzes your workload and provides you the recommendations that can optimize performance of your applications by adding indexes, removing unused indexes, and automatically fixing the query plan issues.
* [Built-in monitoring](https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-azure-sql) capabilities enable you to get the insights into performance of your databases and workload, and troubleshoot the performance issues.
* [Built-in intelligence](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-intelligent-insights) automatically identifies the potential issues in your workload and provides you the recommendations that can [help you to fix the problems](https://azure.microsoft.com/en-us/blog/ai-helped-troubleshoot-an-intermittent-sql-database-performance-issue-in-one-day/). 

## Azure SQL managed instance

![](../graphics/sqlmi.png)  

[Azure SQL managed instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance) is a PaaS deployment option of Azure SQL that basically gives you an evergreen instance of SQL Server. Most of the features available in the SQL Server box products are available in Azure SQL managed instance (Azure SQL MI). This option is ideal for customers who want to leverage instance-scoped features (features that are tied to an instance of SQL Server as opposed to features that are tied to a database in an instance of SQL Server) like SQL Server Agent, Service Broker, Common Language Runtime (CLR), etc and want to move to Azure without rearchitecting their applications. While Azure SQL MI allows customers to access the instance-scoped features, customers do not have to worry about (nor do they have access to) the OS or the infrastructure underneath.     

A good customer example comes from [Komatsu](https://customers.microsoft.com/en-us/story/komatsu-australia-manufacturing-azure). Komatsu is a manufacturing company that produces and sells heavy equipment for construction. They had multiple mainframe applications for different types of data, which they wanted to consolidate to get a holistic view. Additionally, they wanted a way reduce overhead. Because Komatsu uses a large surface area of SQL Server features, they chose to move to **Azure SQL Managed Instance**. They were able to move about 1.5 terabytes of data smoothly, and [start enjoying benefits like automatic patching and version updates, automated backups, high availability, and reduced management overhead](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-technical-overview). After migrating, they reported ~49% cost reduction and ~25-30% performance gains.  

## Azure SQL Database

![](../graphics/sqldb.png)  

Azure SQL Database is a PaaS deployment option of Azure SQL that abstracts both the OS and the SQL Server instance away from the users. Azure SQL Database has the industry's highest availability [SLA](https://azure.microsoft.com/en-us/support/legal/sla/sql-database/v1_4/), along with other intelligent capabilities related to monitoring and performance, due in part to the fact that Microsoft is managing the instance. This deployment option allows you to just 'get a database' and start developing applications. Azure SQL Database (Azure SQL DB) is also the only deployment option that currently supports scenarios related to needing unlimited database storage ([Hyperscale](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-hyperscale)) and autoscaling for unpredictable workloads ([serverless](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-serverless)).  

[AccuWeather](https://customers.microsoft.com/en-us/story/accuweather-partner-professional-services-azure) is a great example of using Azure SQL Database. AccuWeather has been analyzing and predicting the weather for more than 55 years. They wanted access to the rich and rapidly advanced platform of Azure that includes big data, machine learning, and AI capabilities. They want to focus on building new models and applications, not managing databases. They selected **Azure SQL Database** to use with other services, like [Azure Data Factory](https://docs.microsoft.com/en-us/azure/data-factory/) and [Azure Machine Learning Services](https://docs.microsoft.com/en-us/azure/machine-learning/service/), to quickly and easily deploy new internal applications to make sales and customer predictions.  

## Azure SQL "pools"

You've now learned about the three main deployment options within Azure SQL: virtual machines, managed instances, and databases. For the PaaS deployment options (Azure SQL MI and Azure SQL DB), there are additional options for if you have multiple instances or databases, and these options are referred to as "pools". Using pools can help at a high level because they allow you to share resources between multiple instances/databases and cost optimize.  

[Azure SQL Instance Pools](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-instance-pools) (currently in public preview) allow you to host multiple Azure SQL MIs and share resources. You can pre-provision the compute resources which can reduce the overall deployment time and thus make migrations easier. You can also host smaller Azure SQL MIs in an Instance Pool than in just a single Azure SQL MI (more on this in future sections).

[Azure SQL Database Elastic Pools](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool) (Generally Available) allow you to host many databases that may be multi-tenanted. This is ideal for a [Software as a Service (SaaS)](https://azure.microsoft.com/en-us/overview/what-is-saas/) application or provider, because you can manage and monitor performance in a simplified way for many databases.  

A good example for where a customer leveraged Azure SQL Database Elastic Pools is [Paychex](https://customers.microsoft.com/en-us/story/paychex-azure-sql-database-us). Paychex is a human capital management firm that serves more than 650,000 businesses across the US and Europe. They needed a way to separately manage the time and pay management for each of their customers, and cut costs. They opted for [**Azure SQL Database Elastic Pools**](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-pool), which allowed them to simplify the management and enable resource sharing between separate databases to lower costs.  

## Azure SQL Deployment Options - Summary

In this section, you've learned about Azure SQL and the deployment options that are available to you. A brief visual that summarizes the deployment options is below. In the next section, we'll go through deploying and configuring Azure SQL and how it compares to deploying and configuring the box SQL Server.  

![](../graphics/azuresql2.png)


If you want to dive deeper into the deployment options and how to choose, check out the following resources:  
* [Blog announcement for Azure SQL](https://techcommunity.microsoft.com/t5/Azure-SQL-Database/Unified-Azure-SQL-experience/ba-p/815368) which explains and walks through Azure SQL and some of the resulting views and experiences available in the Azure portal.
* [Microsoft Customer Stories](https://customers.microsoft.com/en-us/home?sq=&ff=&p=0) for many more stories similar to the ones above. You can use this to explore various use cases, industries, and solutions.  
* [Choose the right deployment option in Azure SQL](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-paas-vs-sql-server-iaas) is a page in the documentation regularly updated to help provide insight into making the decisions between the Azure SQL options.
* [Choosing your database migration path to Azure](https://azure.microsoft.com/mediahandler/files/resourcefiles/choosing-your-database-migration-path-to-azure/Choosing_your_database_migration_path_to_Azure.pdf) is a white paper that talks about tools for discovering, assessing, planning and migrating SQL databases to Azure. This workshop will refer to it several times, and it's a highly recommended read. Chapter 5 deeply discusses choosing the right deployment option.  
* [Feature comparison between SQL database, SQL managed instance, and SQL Server](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-features) 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="1.3">1.3 Deploy and Configure Azure SQL </h2></a>

Now that you have a general awareness of Azure SQL, let's work through some of the tasks and additional decisions you'll have to make as the Azure SQL professional, and how it compares to SQL Server.  

## Deployment methods  

When you first set out to deploy SQL Server, you'll look at deploying the platform. In an on-prem environment, this means building the bare metal machine and installing the OS. You're probably then going to configure Hypervisor and deploy and configure a Virtual Mahine on top of that and install the OS. Then, you need to take the time to properly configure the OS including any security updates, storage, domain, and timezone. With Azure SQL, you don't have to do that. With an Azure SQL VM, you still potentially need to configure your OS, but with Azure SQL, since the OS is abstracted in Azure SQL DB and Azure SQL MI, you don't have any responsibilities for deploying the platform.  

Once the platform is ready, for the typical box SQL Server, you can use a GUI deployment with the SQL Server Setup from Media or you can leverage SQL Server setup.exe from Media and PowerShell Desired State Configuration for an unattended deployment. For Azure SQL, your main GUI deployment tool is the Azure portal, and you unattended deployment options consist of PowerShell and the Azure Command-line interface (Azure CLI).  

Finally, if you want todo an offline deployment for the box SQL Server, it's the same as the unattended deployment, and with Azure SQL, there currently is no offline deployment.  

## Configuration choices during deployment
TODO: Summary of the things you choose when you deploy/install SQL Server and how it is different than Azure.  

As you go through the deployment of SQL Server, there are specific steps that are required. Below is a list of things you typically do and how they're different in Azure:   
* Accept the EULA  
    * In Azure SQL, you do something similar
* Choose the features to be installed
    * In Azure SQL, you just get everything there is, there are no 'custom' installations with certain features turned on or off
* Choose the collation
    * In Azure SQL, you do this too
* Choose Instant File Initiation
    * In Azure SQL, 
* Choose Directories
    * In Azure SQL,
* Choose Service Accounts
    * In Azure SQL, you can do this after deployment
* Add sys admin account(s)
    * In Azure SQL, you do something similar
* Choose tempdb config
    * In Azure SQL, 
* Choose MAXDOP config
    * In Azure SQL, 
* Choose memory config
    * In Azure SQL, 

In the rest of this section, we'll go through a detailed view of the process and choices involved in deploying Azure SQL (whether it's DB, MI, or Elastic Pools).  

### Resource group  
Whenever you deploy any services (or "resources") in Azure, they must be tied to a [resource group](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal), which is simply a logical grouping of resources in an Azure subscription. This could be all of the resources for a solution, or just the onces you want to manage together. Generally, you add resources that share the same lifecycle to the same resource group so you can easily deploy, update, and delete them as a group. When you deploy any service in the Azure SQL suite, you'll need to specify an existing resource group or create a new one first.    

### Server

When you create an Azure SQL MI, giving the supplying the server name is the same as in SQL Server. However, for databases and elastic pools, an Azure SQL Database server is required. This is a logical construct that acts as a central administrative point for multiple single or pooled databases, logins, firewall rules, auditing rules, threat detection policies, and failover groups (more on these topics later). But having this logical server does not expose any instance-level access or features. More on SQL Database servers [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-servers).  

### Server admin login / Managed Instance admin login

You'll then be prompted to supply a Server admin login (or Managed Instance admin login if using Azure SQL MI or Azure SQL Instance Pools) username and password. This is the equilavent to the system admin in SQL Server. This account connects using SQL authentication (username and password) and only one of these accounts can exist. You can optionally configure an Azure Active Directory account (individual or security group). More details on logins [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-manage-logins).  

### Region

Next, you'll have to select a region where you want the service deployed. The list of available regions for Azure SQL DB and MI can be found [here](https://azure.microsoft.com/en-us/global-infrastructure/services/?products=sql-database&regions=all).

### Elastic pool

In Azure SQL DB, you then decide if you want this database to be a part of an Elastic Pool (new or existing). In Azure SQL MI, [creating an instance pool (public preview) currently requires a different flow](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-instance-pools-how-to#create-an-instance-pool) than the Azure SQL MI create experience in the Azure portal. 

### Purchasing model
You have two options for the purchasing model, [virtual core (vCore)-based](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-vcore) (recommended) or [Database transaction unit (DTU)-based](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-dtu
). The DTU model is not available in Azure SQL MI.     

The vCore-based model is recommended because it allows you to independently choose compute and storage resources, while the DTU-based model is a bundled measure of compute, storage and I/O resources, which means you have less control over paying only for what you need. This model also allows you to use [Azure Hybrid Benefit for SQL Server](https://azure.microsoft.com/pricing/hybrid-benefit/) to gain cost savings. In the [vCore model](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-vcore), you pay for:  

* Compute resources (the service tier + the number of vCores and the amount of memory + the generation of hardware).
* The type and amount of data and log storage.
* Backup storage ([read-access, geo-redundant storage (RA-GRS)](https://docs.microsoft.com/en-us/azure/storage/common/storage-designing-ha-apps-with-ragrs)).  

For the purposes of this workshop, we'll focus on the vCore purchasing model (recommended), but you can [compare vCores and DTUs here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models
).  
### Service tier
Legacy tiers  

Comparison of the three  
Include differences in their architectures in the in-class portion slides  

The next decision is choosing the service tier for performance and availability. We recommend you start with the General Purpose, and adjust as needed. There are three tiers available in the vCore model:  
* **[General purpose](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-general-purpose)**: Most business workloads. Offers budget-oriented, balanced, and scalable compute and storage options.
* **[Business critical](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-business-critical)**: Business applications with low-latency response requirements. Offers highest resilience to failures by using several isolated replicas. This is the only tier that can leverage [in-memory OLTP](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-in-memory) to improve performance.
* **[Hyperscale](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tier-hyperscale)**: Most business workloads with highly scalable storage (100TB+) and read-scale requirements. From a performance and cost perspective, it falls between General purpose and Business critical. *Currently only available for single databases, not managed instances or pools*.  

If you choose **General Purpose within Azure SQL DB** and the **vCore-based model**, you have an additional decision to make regarding the compute that you pay for:
* **Provisioned compute** is meant for more regular usage patterns with higher average compute utilization over time, or multiple databases using elastic pools. 
* **Serverless compute** is meant for intermittent, unpredictable usage with lower average compute utilization over time. Serverless has auto-pause and resume capabilities (with a time delay you set), meaning when your database is paused, you only pay for storage.  

For a deeper explanation between the two compute options (including scenarios), you can refer to the detailed [comparison in the documentation](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-serverless#comparison-with-provisioned-compute-tier).  


A member of the Product Group released a [blog](https://azure.microsoft.com/en-gb/blog/understanding-and-leveraging-azure-sql-database-sla/) and [video](https://www.youtube.com/watch?v=l7FUNJd5TSE) explaining the SLA (service level agreements that set an expectation for uptime and performance). This resource will help you make an informed decision about which configuration to move to based on the SLA you require.  

For a deeper explanation between the three service tiers (including scenarios), you can also refer to the [service-tier characteristics](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-vcore#service-tier-characteristics) in the documentation.   


> If you're looking for compute cost saving opportunities, you can prepay for compute resources with [Azure SQL Database reserved capacity](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-reserved-capacity).

### Hardware generation
The vCore model lets you choose the generation of hardware:  
* **Gen4**: Up to 24 logical CPUs based on Intel E5-2673 v3 (Haswell) 2.4-GHz processors, vCore = 1 physical core, 7 GB per core, attached SSD
* **Gen5**: Up to 80 logical CPUs based on Intel E5-2673 v4 (Broadwell) 2.3-GHz processors, vCore = 1 hyper-thread, 5.1 GB per core, fast NVMe SSD  

Basically, Gen4 hardware offers substantially more memory per vCore. However, Gen5 hardware allows you to scale up compute resources much higher. [New Gen4 databases are no longer supported in certain regions](https://azure.microsoft.com/en-us/updates/gen-4-hardware-on-azure-sql-database-approaching-end-of-life-in-2020/), where Gen5 is available in most regions worldwide. As technology advances, you can expect that the hardware will change as well. For example, Fsv2-series (compute optimized) and M-series (memory optmized) hardware options recently became available in public preview for Azure SQL DB. You can reivew the latest hardware generations and availability [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-vcore#hardware-generations).

> Note: If you choose General Purpose within Azure SQL DB and want to use the serverless compute tier, Gen5 hardware is the only option and it currently can scale up to 16 vCores.  

### Networking options

Choices for networking for Azure SQL DB and Azure SQL MI are different. When you deploy an Azure SQL Database, currently the default is that the "Allow Azure services and resources to access this server" blade is set to yes, meaning that other Azure services (e.g. Azure Data Factory or an Azure VM) can access the database if you configure it. Additionally, after deployment you can alter the firewall rules to meet your requirements.

With Azure SQL MI, you deploy it inside an Azure virtual network and a subnet that is dedicated to managed instances. This enables you to have a completely secure, private IP address. Azure SQL MI provides the ability to connect an on-prem network to a managed instance, connect a managed instance to a linked server or other on-prem data store, and connect a managed instance to other resources. You can additionally enable a public endpoint so you can connect to managed instance from the Internet without VPN. This access is disabled by default.  

The principle of private endpoints through virtual network isolation is making it's way to Azure SQL DB in something called 'private link' (currently in public preview), and you can learn more [here](https://docs.microsoft.com/en-us/azure/private-link/private-link-overview).

During deployment, in Azure SQL MI you're also able to choose the connection type. In Azure SQL DB, you can also choose the connection type, but only via PowerShell after deployment. You can keep the default (Proxy) or change to Redirect. At the highest level, in Proxy mode, all connections are proxied through the Azure SQL Database gateways, but in Redirect mode, after the connection is established leveraging the gateway, the connection is directly to the database or managed instance. The direct connection (redirect) allows for reduced latency and improved throughput, but also requires opening up additional ports.  

More information on connectivity for Azure SQL DB can be found [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-connectivity-architecture) and for Azure SQL MI [here](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-connectivity-architecture). There will also be more on this in upcoming sections/modules.  

### Data source

In Azure SQL DB, upon deployment you have the option to select the AdventureWorksLT database as the sample in the Azure portal. Using the Azure CLI (a set of command-line interface tools for working with Azure) you can also [deploy with the WideWorldImporters sample database](https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-create). In Azure SQL MI, however, you deploy the instance first, and then databases inside of it, so there is not an option to have the sample database upon deployment (similar to in SQL Server). There are several options for loading databases into Azure SQL after deployment that will be explored in a later section.

### Collation
Collations in SQL Server and Azure SQL tell the Database Engine how to treat certain characters and languages. A collation provides the sorting rules, case, and accent sensitivity properties for your data. When you're creating a new Azure SQL DB or MI, it's important to first take into account the locale requirements of the data you're working with, because the collation set will affect the characteristics of many operations in the database. In the SQL Server box product, the default collation is typically determined by the OS locale. In Azure SQL MI, you can set the server collation upon creation of the instance, and it cannot be changed later. The server collation sets the default for all of the databases in that instance of Azure SQL MI, but you can modify the collations on a database and column level. In Azure SQL DB, you can not set the server collation, it is set at the default (and most common) collation of `SQL_Latin1_General_CP1_CI_AS`. If we break that into chunks:  
* `SQL` means it is a SQL Server collation (as opposed to a Windows or Binary collation)  
* `Latin1_General` specifies the alphabet/language to use when sorting
* `CP1` references the code page used by the collation
* `CI` means it will be case insensitive, where `CS` is case sensitive
* `AS` meand it will be accent sensitive, where `AI` is accent insensitive     

There are other options available related to widths, UTF-8, etc., which you can [reference here](https://docs.microsoft.com/en-us/sql/relational-databases/collations/collation-and-unicode-support?view=sql-server-ver15).

### Timezone

Azure SQL MI is the only deployment option within Azure SQL that supports [time zone setting](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-timezone) and it must be done at instance creation. Other deployment options are set at Coordinated Universal Time (UTC), and that remains the Microsoft recommended time zone for the data tier of cloud solutions. Choice of time zones in Azure SQL MI was introduced to meet the needs of existing applications that store/call date and time values with a context of a specific time zone.  

### Advanced Data Security (ADS)   
When you deploy Azure SQL DB in the portal, you are prompted if you'd like to enable [Advanced Data Security (ADS)](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-advanced-data-security) on a free trial. After the free trial, it is billed according to the [Azure Security Center Standard Tier pricing](https://azure.microsoft.com/en-us/pricing/details/security-center/). If you choose to enable it, you get functionality related to data discovery and classification, identifying/mitigating potential database vulnerabilities, and threat detection. You'll learn more about these capabilities in the next module (<a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/02-Security.md" target="_blank"><i>02 - Security</i></a>). In Azure SQL MI, you can enable it on the instance after deployment.  


### Terms and Privacy

Finally, before deploying your Azure SQL MI (single instance or instance pool) or Azure SQL DB (single database or elastic pool), you have to agree to the [Azure Marketplace Terms](https://azure.microsoft.com/en-us/support/legal/marketplace-terms/). The term "Azure Marketplace" simply refers to any service that's offered in the Azure portal, and the terms, are similar to the End User License Agreement (EULA) that you accept when deploying SQL Server. They contain details about purchasing and billing, use rights, and privacy and data protection. Like any contract you consent to, you should [review the terms](https://azure.microsoft.com/en-us/support/legal/marketplace-terms/) before deploying.


## Verify deployment  
In SQL Server, once you've completed the installation flow, you generally go through a few steps to verify the deployment. The follow table gives an overview on how the processes vary by deployment options, with details that follow:   

| SQL Server | Azure SQL MI | Azure SQL DB |
|:-----------|:-------------|:-------------|
| Check Service Status | Check managed instance status with Azure portal or Azure CLI | Check database status with Azure portal or Azure CLI |
| Check ERRORLOG and Event Logs | Check Deployment details and Activity Log | Check Deployment details and Activity Log |
| Check setup log files | Check ERRORLOG | |
| Connect with SSMS | Connect with SSMS | Connect with SSMS |
| Run "verify deployment" queries | Run "verify deployment" queries | Run "verify deployment" queries |  

TODO: Commentary on the differences

### Initial connect with SSMS or ADS   
TODO
### Queries to verify deployment  
TODO

## Determine what features exist  
## Configure SQL Server  
## Deploy databases
## Configure databases
## Load data
## Migrate from legacy SQL Server

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Description</b></p>

TODO: Enter activity description with checkbox

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox


<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>
<ul>
    <li><a href="url" target="_blank">TODO: Enter courses, books, posts, whatever the student needs to extend their study</a></li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/02-Security.md" target="_blank"><i> 02 - Security</i></a>.