### Networking fundamentals  

Networking is a crucial part to moving to Azure. You'll want to work closely with networking and infrastructure individuals to make sure your deployment to Azure is secure, performant, and scalable. While you may not need to be the expert, having a foundational knowledge is very important. You'll see a few explanations and links to additional courses and information to learn more.  

*Glossary of basic networking terms*  

| **Term**  | **Description** |  
|-----------|-----------------|  
| [Azure Virtual Network (VNet)](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview) | Logically isolated network on Azure <br> Allows resources to securely communicate with each other, the internet, and on-prem networks <br>Scoped to a single region <br> Segmented into one or more subnets  |  
| [Subnets](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet) | Segmentation of VNets to organize and secure resources in discrete sections  |  
| [VNet Peering](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)   | Used to connected multiple virtual networks (can be different regions)|  | [VPN Gateway](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-vpngateways)| Provides secure connection between Azure VNet and on-prem over the internet|  
| [ExpressRoute](https://docs.microsoft.com/en-us/azure/expressroute/) | Provides secure, private (not over public internet), low-latency connection between Azure and on-premises |  
| [Network security group (NSG)](https://blogs.msdn.microsoft.com/igorpag/2016/05/14/azure-network-security-groups-nsg-best-practices-and-lessons-learned/)  | Allows or denies inbound traffic to your Azure resources (like a cloud-level firewall for your network)|    
  
  
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

![Azure SQL DB Connectivity](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-connectivity-db.png?raw=true)  

The following steps describe how a connection is established to an Azure SQL database:
* Clients connect to the gateway, that has a public IP address and listens on port 1433.
* The gateway, depending on the effective connection policy, redirects or proxies the traffic to the right database cluster.
* Inside the database cluster traffic is forwarded to the appropriate Azure SQL database.  

There are three options for the connection policy setting of a SQL Database server:  
* **Redirect (recommended)**: Clients establish connections directly to the node hosting the database. After (1) the TCP session is established to the Azure SQL database, the client session is then redirected to the right database cluster with a change to the destination virtual IP from that of the Azure SQL Database gateway to that of the cluster. Thereafter, (2) all subsequent packets flow directly to the cluster, bypassing the Azure SQL Database gateway, thus improving performance for latency and throughput.  
* **Proxy**: In this mode, all connections are proxied via the Azure SQL Database gateways. Choosing this mode can result in higher latency and lower throughput, depending on nature of the workload.  
* **Default**: This is the connection policy in effect on all servers after creation unless you explicitly alter the connection policy to either *Proxy* or *Redirect*. The effective policy depends on whether connections originate from within Azure (*Redirect*) or outside of Azure (*Proxy*).

> For more information, including scripts to change connection settings, refer to the [documentation](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-connectivity-architecture) and a [video explanation from the SQL team](https://www.youtube.com/watch?v=e0tWC0XmOgc).  

#### Connectivity architecture for managed instances  

At a high level, a managed instance is a set of service components. These components are hosted on a dedicated set of isolated virtual machines that run inside the customer's virtual network subnet. These machines form a **virtual cluster**.  

A virtual cluster can host multiple managed instances. If needed, the cluster automatically expands or contracts when the customer changes the number of provisioned instances in the subnet.  

Customer applications can connect to managed instances and can query and update databases inside the virtual network, peered virtual network, or network connected by VPN or [Azure ExpressRoute](https://docs.microsoft.com/en-us/azure/expressroute/). This network must use an endpoint and a private IP address.  

![Azure SQL MI Connectivity](https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLLabs/graphics/azure-connectivity-arch.png?raw=true)

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