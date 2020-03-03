![](../graphics/microsoftlogo.png)

# The Azure SQL Workshop

#### <i>A Microsoft workshop from the SQL team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/textbubble.png"> <h2>06 - Putting it all together</h2>

In this workshop, you have covered deploying and configuring a secure, performant, and highly available solution with Azure SQL. The end of this module contains several helpful references you can use in these exercises and in production.

In the final activity, we’ll validate your Azure SQL expertise with a challenging problem-solution exercise.    

This module can be used stand-alone and does not require any prerequisites other than a laptop and a place to take notes (OneNote, Paint, PowerPoint, Visio, etc.). You may also just use a whiteboard or paper for your designs. 

There are many elements in a single solution, and in this module you'll learn how to take the business scenario and determine the best resources and processes to use to satisfy the requirements while considering the constraints within the scenario. 

In production, there are normally 6 phases to create  a solution. These can be done in-person, or through recorded documents: 

 - 01 **Discovery**: The original statement of the problem from the customer 
 - 02 **Envisioning**: A "blue-sky" description of what success in the project would look like. Often phrased as *"I can..."* statements
 - 03 **Architecture Design Session**: An initial layout of the technology options and choices for a preliminary solution
 - 04 **Proof-Of-Concept** (POC): After the optimal solution technologies and processes are selected, a POC is set up with a small representative example of what a solution might look like, as much as possible. If available, a currently-running solution in a parallel example can be used
 - 05 **Implementation**: Implementing a phased-in rollout of the completed solution based on findings from the previous phases
 - 06 **Handoff**: A post-mortem on the project with a discussion of future enhancements
 
Throughout this module, if you want to leverage various templates, icons, stencils and other assets to assist you with each phase and also use these with your exercises, you can find them [here](https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources). These assets can also be used in your production workloads.  

For this module, you'll focus on a portion of the **Architecture Design Session** phase only. If you wish to develop your solution further after the course, you can use the assets above to complete all phases.

This module is slightly different than the other modules in that you will work in groups to work through a problem, and then present your findings. If you are completing this workshop in a self-study fashion, you can still work through the problems as a learning exercise.  

This module will be broken up into several sections:  
[6.1](#6.1): Select a scenario    
[6.2](#6.2): Architecture Design  

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="6.1">6.1 Select a scenario</h2></a>

In this section, you will review two business scenarios and pick one to focus on for the rest of this module. The company descriptions, project goals, and constraints have already been laid out for you.  

Once you've picked a scenario, the first step is to fully understand the problem the company needs to solve, and any requirements and constraints they have on those goals. This is often in the form of a *Problem Statement*, which is a formal set of paragraphs clearly defining the circumstances, present condition, and desired outcomes for a solution. At this point you want to avoid exploring how to solve the problem and focus on what you want to solve. 

After everyone agrees on the problem statement, pull out as many requirements (*goals*) for the project as you can find, and then lay in any constraints the solution has. At this point, it's acceptable to have unrealistic constraints - later you can pull those back after showing a cost/benefit ratio on each requirement and constraint.  

**Scenario 1: Global CDN system**   

*Scenario description*:  

Your customer is a provider for services and content delivery across the globe. They’ve requested your assistance in architecting a system that can handle thousands of writes per second to what is essentially an operational data mart. They also need to be able to perform real-time analytics on the data, to determine trends and identify anomalies, which they are currently doing with CLR applications. They are not looking for a data warehouse and utilize large portions of the SQL surface area, but they need to be able to scale where their users live.  

Additionally, they are trying to determine which authentication methods they should use in their hybrid environment. While the main solution and application will live in Azure, there is also an application on a non-Azure machine, a legacy application (they can't change the driver or connection string) on a non-Azure machine, and multiple users that run reports from SQL admin tools (SSMS, ADS, PowerShell) on non-Azure machines. Wherever possible, they want to eliminate hardcoding passwords/secrets in the connection strings and app config files, and they want to eliminate using passwords in SQL tools in SQL tools or find a way to enhance that authentication.        


*Scenario guidance*:
* Start with the Azure SQL deployment option that is most compatible with their current solution and available today.
* How will they scale over multiple regions with multiple queries happening at the same time, while isolating read workloads from write workloads? 
* How can they access data across the various deployments?
* Which authentication methods would you recommend for the interaction paths described in the scenario?  



**Scenario 2: Mission critical app**  

*Scenario description*:  

You are hired to architect a mission critical cloud application that requires 99.995% availability because downtime might be life threatening. 911 dispatch, stolen credit card notifications or corporate security reporting are examples of such applications. High performance is required as any delay in response carries high risk. Given the sensitivity of the collected information, data sovereignty must be guaranteed. Your main mission is to ensure that the app is designed and deployed with the appropriate data redundancy and fault resilience to meet the availability and data sovereignty goals.   

Additionally, mission critical cloud applications, especially those mentioned above, are concerned about protecting sensitive data while allowing DBAs to perform their jobs. In this scenario, DBAs must not be able to see sensitive data stored in specific columns and all access to tables containing sensitive data must be monitored. At the same time, DBAs need to be able to troubleshoot performance using the Azure portal and SSMS/ADS and to create new contained database users who must be mapped to Azure AD principals.  
        


*Scenario guidance*:
* Start by selecting the Azure SQL deployment option, service tier and configuration that creates the highest availability.  
* Consider geo-redundancy.  
* What role does co-location play in your solution?  
* Determine a security strategy for meeting the data sensitivity requirements.




<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Tasks</b></p>

1. Read each of the scenarios.   
1. Among your group, select one scenario to focus on.    
1. Come up with a problem statement. Usually, these are represented by a one-pager, but for this exercise, it can be informal and brief (1-2 sentences is fine).   
1. Pull out as many requirements for the project as you can find.      
1. Supplement your problem statement with any additional info that is required. Are there sub-goals that you want to add? Any other constraints you can think of?  
> Feel free to adapt the scenario to have more information where you want clarity - you can make assumptions about any part of the scenario.  

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/pencil2.png"><a name="6.2">6.2 Architecture Design</h2></a>

With a firm understanding of what the customer needs, you can now consider the technologies and processes at your disposal for the solution. Each technology will have benefits and considerations, so you first want to identify all your options that will address each of the project's goals.  

After you've identified the options, you can start to think about how you would design a solution. Using a decision matrix can often be helpful when narrowing the options, and you can find more information about how to create one [in an explanation from this workshop](https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/06-WhatToUseWhen.md#63-the-decision-matrix) and refer to the article at the bottom of this page.  

After you have a preliminary solution in mind, the next step is often to present it to the larger team (or customer, leadership, etc. depending on the scenario). You'll need to assemble and present your solution in a way that shares the project goals and constraints, as well as how your solution addresses those items.  


<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/checkmark.png"><b>Tasks</b></p>

1. List out the possible technologies and processes that could potentially be used in a solution.  
>Hint: For the security challenges, you might consider leveraging the Azure SQL Security Best Practices Playbook that's available in the [documentation](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-best-practice).  
1. Using a decision matrix or some other decision process, select technologies and processes that will make up your preliminary solution. 
1. Create a presentation (can use PowerPoint, a whiteboard, or a document) that presents your project goals and constraints, as well as the recommended solution designs.   

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="../graphics/owl.png"><b>For Further Study</b></p>
<ul>
    <li><a href="http://www.ceptara.com/blog/how-to-write-problem-statement" target="_blank">How to Write a Problem Statement</a> - Article on writing effective problem statements</li>
    <li><a href="https://www.mindtools.com/pages/article/newTED_03.htm" target="_blank">Decision Matrix Analysis</a> - Article on creating a Decision Matrix</li>
    <li><a href="https://azure.microsoft.com/en-us/pricing/calculator/" target="_blank">Azure Pricing Calculator</a> - Create a cost analysis of your solution</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/data-guide/" target="_blank">Azure Data Architecture Guide</a> - This guide presents a structured approach for designing data-centric solutions on Microsoft Azure. It is based on proven practices derived from customer engagements</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/" target="_blank">Azure Reference Architectures</a> - Recommended practices, along with considerations for scalability, availability, manageability, and security</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/" target="_blank">Microsoft Cloud Adoption Framework for Azure</a> - Article on writing effective problem statements</li>
	<li><a href="https://azure.microsoft.com/en-us/overview/trusted-cloud/" target="_blank">Microsoft Azure Trust Center</a> - Full reference site for Azure security, privacy and compliance</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/" target="_blank">Microsoft Cloud Adoption Framework for Azure</a> - Article on writing effective problem statements</li>
	<li><a href="https://docs.microsoft.com/en-us/azure/sql-database/sql-database-security-best-practice" target="_blank">Azure SQL Security Playbook</a> - Best practices for securing your Azure SQL deployment</li>
</ul>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="../graphics/geopin.png"><b >Next Steps</b></p>
  
Congratulations! You have completed The Azure SQL Workshop. You now have the tools, assets, and processes you need to extrapolate this information into other applications.