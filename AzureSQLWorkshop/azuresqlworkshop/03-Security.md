![](../graphics/microsoftlogo.png)

# The Azure SQL Workshop

#### <i>A Microsoft workshop from the SQL team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>03 - Security</h2>
   
> You must complete the [prerequisites](../azuresqlworkshop/00-Prerequisites.md) before completing these activities. You can also choose to audit the materials if you cannot complete the prerequisites. If you were provided an environment to use for the workshop, then you **do not need** to complete the prerequisites.    

Ensuring security and compliance of your data is always a top priority. In this module, you’ll learn how to use Azure SQL to secure your data, how to configure logins and users, how to use tools and techniques for monitoring security, how to ensure your data meets industry and regulatory compliance standards, and how to leverage the extra benefits and intelligence that is only available in Azure. We’ll also cover some of the networking considerations for securing SQL.



In this module, you'll cover these topics:  
[3.1](#3.1): Platform and network security   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Activity 1](#1): Create and manage firewall rules for Azure SQL Database  
[3.2](#3.2): Access management and Authorization   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Activity 2](#2): Getting started with Azure AD authentication    
[3.3](#3.3): Information protection and encryption  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Activity 3](#3): Confirm TDE is enabled via powershell   
[3.4](#3.4): Security management  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Activity 4](#4): Auditing  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Activity 5](#5): Advanced Data Security   


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3.1">3.1 Platform and network security</h2></a>

TODO: Topic Description

<br>

<img style="height: 400; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" src="linkToPictureEndingIn.png">

<br>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><a name="1"><b>Activity 1</a>: Create and manage firewall rules for Azure SQL Database</b></p>

In this short activity, you'll see how to review and manage your firewall rules using the Azure portal.

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Description</b></p>

During deployment of Azure SQL Database, you selected "Allow Azure services and resources access to this server" to **ON**. If you can, switching it to **OFF** is the most secure confiuration. This can be complicated, since it means you'll have to specify a range of IP addresses for all your connections. In this activity, you'll simply see how to view and edit your firewall rules. In reality, you'll want to partner with your networking team to ensure you have the most secure, functional network. A few handy resources include:  
* [Azure SQL Database network access controls](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-networkaccess-overview)
* [Connecting your applications to Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance-connect-app)
* [IP firewall rules for Azure SQL Database](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-firewall-configure)

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Steps</b></p>

**Step 1 - create and manage firewall rules with the Azure portal**  
In your Azure virtual machine, navigate to the Azure portal, specifically to your Azure SQL Database logical server. Select **Firewalls and virtual networks** from the left-hand menu.    

![](../graphics/fwvn.png)    

Switch "Allow Azure services and resources to access this server" to **OFF**. During deployment, you should have added your Client IP address already, but if one of the Rules do not match your Client IP displayed (see below), select **Add Client IP**.  

![](../graphics/clientip.png)  

Finally, select **Save**.  

To confirm you still have access from your Azure VM, navigate to SSMS and refresh your connection to the Azure SQL Database logical server. If no errors occur, you have successfully configured access to your Azure SQL Database logical server for your IP address only. You can also use commands `az sql server firewall-rule` to create, delete, and view server-level firewall rules.  

![](../graphics/dbrefresh.png)  

**Step 2 - Create and manage firewall rules with the Azure Cloud Shell**  

You can also use commands `az sql server firewall-rule` to create, delete, and view server-level firewall rules. You can use the Azure CLI through the command-line of your Azure VM or through a PowerShell notebook. For this step, you'll experiment with the Azure Cloud Shell.  

Return to the Azure portal in your Azure VM. In the top bar, select the Azure Cloud Shell button.  

![](../graphics/cloudshell.png)  

If this is your first time using the Azure Cloud Shell, you will be prompted to select a subscription to create a storage account and Microsoft Azure Files share.  

Then, you can select Bash or PowerShell. Select **Bash**. You should see a view similar to below.  

![](../graphics/acsbash.png)  

Next, run `az account list` to find the name of the subscription you are using for the workshop.  

Then, run `az account set --subscription 'my-subscription-name'` to set the default subscription for this Azure Cloud Shell session. You can confirm this worked by running `az account show`.  

Now that you're set up, you can list your server's firewall settings with the following command:  

```bash
az sql server firewall-rule list -g <ResourceGroup> -s <Server>
```
Your client IP address rule should match what you saw in the previous step using the Azure portal.  

![](../graphics/fwlist.png)

There are other commands available for creating, deleting, and updating rules, which you can explore [here](https://docs.microsoft.com/en-us/cli/azure/sql/server/firewall-rule?view=azure-cli-latest).  

Note that this method of setting the firewall rules (using the Azure portal or Azure Cloud Shell) grants your client IP address access to all of the databases that are in that logical server. After you've configured the server-level firewall rule, which you did above, you can optionally configure database-level firewall rules that apply to individual databases. This can only be done with T-SQL, using the command `EXECUTE sp_set_database_firewall_rule`. For more information, see the references in the **Description** of this activity.  

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3.2">3.2 Information protection and encryption</h2></a>

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><a name="2"><b>Activity 2</a>: Getting started with Azure AD authentication</b></p>

In this activity, you'll learn how to configure an Azure AD administrator on a server level for Azure SQL Database. Next, you'll change your connection in SSMS from SQL authentication to Azure AD authentication, and you'll see how to grant other Azure AD users access to the database like normal users in SQL Server.  
  

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Steps</b></p>

**Step 1 - Create an Azure AD admin**  

In the Azure portal, navigate to your Azure SQL Database logical server. In the left-hand task menu, select **Active Directory Admin** and **Set Admin**.  

![](../graphics/aadadmin.png)  

Search for you account. Easiest way is to type in your full email address. Click your user and then choose **Select**.  

![](../graphics/aadselect.png)  

You might think that's it, but you still have to select **Save** to confirm your actions.  

![](../graphics/aadsave.png)  


**Step 2 - Authenticate using Azure AD**  

Now that you've configured access for yourself to your Azure SQL Database logical server, let's update the connection in SSMS and ADS.  

First, in SSMS, rightclick on you Azure SQL Database logical server and select **Refresh**.  

![](../graphics/dbconnect.png)  

Notice that under *Authentication*, there are several different Azure Active Directory authentication methods, which will depend on how your organization is set up. For this workshop, select **Azure Active Directory - Password**.  

![](../graphics/connecttoserver.png)  

> Note: If you get the following error, this indicates your organization requires you to select **Azure Active Directory - Universal with MFA**. Connect accordingly.  
>
> ![](../graphics/cannotconnect.png)

Next to the server name, you should now be able to see that you are authenticated using your Azure AD account and not the `cloudadmin` SQL user as before.  

![](../graphics/aadc.png)  

**Step 3 - Grant other users access (SQL)**  

Now that you're authenticated using Azure AD, your next step might be to add other users. Just as in SQL Server, you can add new SQL users. In SSMS, using your Azure AD connection, right-click on your database and create a new query. Run the following.

```sql
-- Create a new SQL user and give them a password
CREATE USER ApplicationUser WITH PASSWORD = 'YourStrongPassword1';

-- Until you run the following two lines, ApplicationUser has no access to read or write data
ALTER ROLE db_datareader ADD MEMBER ApplicationUser;
ALTER ROLE db_datawriter ADD MEMBER ApplicationUser;
```

As you likely already know, the best practice is to create non-admin accounts at the database level, unless they need to be able to execute administrator tasks.  


**Step 3 - Grant other users access (Azure AD)**   

Azure AD authentication is a little different. From the documentation, "*Azure Active Directory authentication requires that database users are created as contained. A contained database user maps to an identity in the Azure AD directory associated with the database and has no login in the master database. The Azure AD identity can either be for an individual user or a group*."  

Additionally, the Azure portal can only be used to create administrators, and Azure RBAC roles don't propogate to Azure SQL Database logical servers, Azure SQL Databases, or Azure SQL Managed Instances. Additional server/database permissions must be granted using T-SQL.  

How you complete this next step will depend on how you are consuming this workshop. If you were given an environment, find a neighbor to work with. If you are doing this self-paced, or in a group that is multi-organization, you will just review this step, observing the screenshots.  

1. With your neighbor, first determine who will be *Person A* and who will be *Person B*.  
2. Both *Person A* and *Person B* should note their Azure VM's **Public IP Address** (can locate this in the Azure portal)
3. *Person A* should run the following T-SQL to authorize *Person B* to their server:  
```sql
-- Create the Azure AD user with access to the server
CREATE USER <Person B Azure AD account> FROM EXTERNAL PROVIDER;

-- Create firewall to allow Person B's Azure VM
EXECUTE sp_set_firewall_rule @name = N'AllowPersonB',
    @start_ip_address = 'Person B VM Public IP', 
    @end_ip_addres = 'Person B VM Public IP'
```
4. *Person B* should run the following T-SQL to authorize *Person A* to their server:
```sql
-- Create the Azure AD user with access to the server
CREATE USER <Person A Azure AD account> FROM EXTERNAL PROVIDER;

-- Create firewall to allow Person A's Azure VM
EXECUTE sp_set_firewall_rule @name = N'AllowPersonA',
    @start_ip_address = 'Person A VM Public IP', 
    @end_ip_addres = 'Person A VM Public IP'
```
5. **Person A** should now try to connect to **Person B**'s Azure SQL Database logical server.  
6. **Person B** should now try to connect to **Person A**'s Azure SQL Database logical server.  
7. Compare results.  

TODO Add screenshots and test with Bob.  

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3.3">3.3 Information protection and encryption</h2></a>

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><a name="3"><b>Activity 3</a>: Confirm TDE is enabled via powershell</b></p>

This is a quick activity to show you how easily you can confirm that TDE is enabled, or turn it on if it is not.  

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Steps</b></p>

In the Azure portal, navigate to your Azure SQL Database, and in the left-hand task menu, under security, select **Transparent data encryption**. Confirm your database is set to **ON**.  

![](../graphics/tdeon.png)  

Next, navigate to your Azure SQL Database logical server, and in the left-hand task menu, under security, select **Transparent data encrypton**. Notice that you have a different view:  

![](../graphics/tdeoption.png)  

The default is to let the Azure service manage your key. As it says, Azure will automatically generate a key to encrypt your databases, and manage the key rotations.  

You can, alternatively, bring your own key (BYOK) leveraging Azure key vault. In this scenario, you (not Azure) are responsible for and in full control of a key lifecycle management (key creation, rotation, deletion), key usage permissions, and auditing of operations on keys. For more information regarding Azure SQL TDE with BYOK, please [refer here](https://docs.microsoft.com/en-us/azure/sql-database/transparent-data-encryption-byok-azure-sql?view=sql-server-ver15).  

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="3.4">3.4 Security management</h2></a>

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><a name="4"><b>Activity 4</a>: Auditing</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Description</b></p>

TODO: Enter activity description with checkbox

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

TODO: Topic Description CONTD

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/point1.png"><a name="5"><b>Activity 5</a>: Advanced Data Security</b></p>

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

Next, Continue to <a href="https://github.com/microsoft/sqlworkshops/blob/master/AzureSQLWorkshop/azuresqlworkshop/04-Performance.md" target="_blank"><i> 04 - Performance</i></a>.