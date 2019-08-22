![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png?raw=true)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2> 06 - What to Use When: Designing a Solution </h2>

In this workshop you have covered using SQL Server both on-premises and in-cloud configurations, as well as hybrid applications as a solution for data processing. The end of this Module contains several helpful references you can use in these exercises and in production.

This module can be used stand-alone, and does not require any <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-prerequisites.md" target="_blank">prerequisite</a> other than a laptop and some sort of design software (such as Microsoft Visio) - although you may also just use a whiteboard or paper for your design. 

There are many elements in a single solution, and in this module you'll learn how to take the business scenario and determine the best resources and processes to use to satisfy the requirements while considering the constraints within the scenario. 

In production, there are normally 6 phases to create  a solution. These can be done in-person, or through recorded documents: 

 - 01 **Discovery**: The original statement of the problem from the customer 
 - 02 **Envisioning**: A "blue-sky" description of what success in the project would look like. Often phrased as *"I can..."* statements
 - 03 **Architecture Design Session**: An initial layout of the technology options and choices for a preliminary solution
 - 04 **Proof-Of-Concept** (POC): After the optimal solution technologies and processes are selected, a POC is set up with a small representative example of what a solution might look like, as much as possible. If available, a currently-running solution in a prallel example can be used
 - 05 **Implementation**: Implementing a phased-in rollout of the completed solution based on findings from the previous phases
 - 06 **Handoff**: A post-mortem on the project with a discussion of future enhancements
 
Throughout this module, you can use various templates, icons, stencils and other assets to assist you with each phase and also use these with your exercises. These assets can also be used in your production workloads: <a href="https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources" target="_blank">https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources</a>

For this module, you'll focus on the <i>Discovery</i> and the <i>Architecture Design Session</i> phases only. If you wish to develop your solution further after the course, you can use the assets above to complete all phases.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.1 Understand the Problem Space</h2>

The first step in any project is to fully understand the problem the company needs to solve, and any requirements and constraints they have on those goals. This is often in the form of a "Problem Statement", which is a formal set of paragraphs clearly defining the circumstances, present condition, and desired outcomes for a solution. At this point you want to avoid exploring how to solve the problem, and focus on what you want to solve. 

Begin with as complete an examination of the company and organization as you can. Gather information from as many sources as possible, and simplify the descriptions to have specific measurements and depictions of the environment.

From there, lay out the problem, and then review that with all stakeholders. 

After everyone agrees on the problem statement, pull out as many requirements (*goals*) for the project as you can find, and then lay in any constraints the solution has. At this point, it's acceptable to have unrealistic constraints - later you can pull those back after showing a cost/benefit ratio on each requirement and constraint. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Review Business Scenarios</b></p>

In this activity you will review three business scenarios, and pick one to focus on for the rest of this module. The company descriptions, project goals, and constraints have already been laid out for you. 

After you make your choice, copy the problem statement into your working documents (see the [Resources](https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources) for examples) and make any changes or additions you want to make to the scenario. Feel free to adapt it to have more information where you want clarity - you can make assumptions about any part of the scenario. Are there sub-goals that have been left out? Any other constraints you can think of?

<p style="border-bottom: 1px solid lightgrey;"></p>

![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/AdventureWorksLogo.png?raw=true")

**AdventureWorks**

[Adventure Works Cycles](https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008/ms124825(v=sql.100) ) is a large, multinational manufacturing company. The company manufactures and sells metal and composite bicycles to North American, European and Asian commercial markets. While its base operation is located in Bothell, Washington with 290 employees, several regional sales teams are located throughout their market base.

Starting in the year 2000, Adventure Works Cycles bought a small manufacturing plant, Importadores Neptuno, located in Mexico. Importadores Neptuno manufactures several critical subcomponents for the Adventure Works Cycles product line. These subcomponents are shipped to the Bothell location for final product assembly. In 2001, Importadores Neptuno, became the sole manufacturer and distributor of the touring bicycle product group.

Coming off a successful fiscal year, Adventure Works Cycles is looking to broaden its market share by targeting their sales to their best customers, extending their product availability through an external Web site, and reducing their cost of sales through lower production costs. They are also looking to modernize their data estate.

<b>Project Goals</b>

- Modernize to a newer SQL version
- Move to Cloud wherever possible
- Cloud Integration
- Increase Performance
- Publish Product Catalog to the Web
- Enable Business-To-Business (B2B) systems

<b>Project Constraints</b>

- Some systems must stay on-premises
- In some cases, no code change is possible
- The B2B system should be a "Pull" from partners

<p style="border-bottom: 1px solid lightgrey;"></p>

![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/contosologo.png?raw=true)

**Contoso**

[The Contoso company](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-overview) is a multi-national business with headquarters in Paris, France. It is a conglomerate manufacturing, sales, and support organization with over 100,000 products. They are embarking on a multi-year process of migrating from company-owned datacenters to a cloud provider. They have narrowed the list of potential vendors to three, including Microsoft. They have [high security](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-info-protect) and [interoperability with mobile device](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-mdm) concerns. There is also an Open-Source (OSS) investigation at the company.


<b>Project Goals</b>

- Move everything to Cloud
- Multi-Cloud strategy desired - standards-based
- All client apps should be available worldwide
- Server-side should be API's by default
- Interest in parity for platforms (OSS Support)

<b>Project Constraints</b>

- High Security and Auditing capabilities required
- International Compliance required
- Access Tracking required
- Must be user-friendly on mobile devices 

<!-- TODO https://docs.microsoft.com/en-us/azure/migrate/contoso-migration-overview -->

<p style="border-bottom: 1px solid lightgrey;"></p>

![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/WideWorldImportersLogo.png?raw=true)

**Wide World Importers**

[Wide World Importers](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017) (WWI) is a wholesale novelty goods importer and distributor operating from the San Francisco bay area in the United States.

As a wholesaler, WWI's customers are mostly companies who resell to individuals. WWI sells to retail customers across the United States including specialty stores, supermarkets, computing stores, tourist attraction shops, and some individuals. WWI also sells to other wholesalers via a network of agents who promote the products on WWI's behalf. While all of WWI's customers are currently based in the United States, the company is intending to push for expansion into other countries.

WWI buys goods from suppliers including novelty and toy manufacturers, and other novelty wholesalers. They stock the goods in their WWI warehouse and reorder from suppliers as needed to fulfil customer orders. They also purchase large volumes of packaging materials, and sell these in smaller quantities as a convenience for the customers.

Recently WWI started to sell a variety of edible novelties such as "chili chocolates". The company previously did not have to handle chilled items. Now, to meet food handling requirements, they must monitor the temperature in their chiller room and any of their trucks that have chiller sections.

<b>Project Goals</b>

- Enable Big Data processing
- Enable Machine Learning and Artificial Intelligence prediction capabilities
- Cloud platform desired, but may need to consider on-premises options

<b>Project Constraints</b>

- Short timeframe
- Unknown Data Sources
- Use only API calls for the predictions

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.2 Understand the Technologies and Processes for Solving the Problem</h2>

With a firm understanding of what the customer needs, you can now consider the technologies and processes at your disposal for the solution. Each technology will have benefits and considerations, so at this point you just want to list out all of your options. Everything is on the table at this phase, and ensure that you check the list you create with other professionals to ensure you have considered everything that could solve the problem.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: List the Technologies and Processes for the Problem Space</b></p>

In this activity you will list out all of the options you have for your problem space. 

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

- Open your Architecture Design Session (ADS) document and detail all technologies you have studied in this workshop, and list them out. (Order is not important during this step)
- Next, write the problem element next to each technology that it could solve
- Document any processes you should follow when using each technology
 
<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.3 The Decision Matrix</h2>

Following the process, you now know the problems you want to solve, the desired outcomes for the solution, and several tools and technique options that you can use to achieve your goals. In most situations, there are several ways to solve a given problem. Sometimes the "best" solution is too costly, inconvenient or unworkable due to the requirements or constraints the customer puts on the solution.

Because most solutions are fairly complex, and there are mutiple technology and process choices, considerations and requirements, a *Decision Matrix* that lists these elements is useful. It contains columns for the technology and process options you have, and the requirements and constraints as rows. Each column gets a score you assign from a low number (does not meet this requirement) to a higher one (does meet the requirement). These numbers are summed at the end of each row, per requirement. The highest number is usually the best technology for that aspect of the solution. 

As an example, assume you have an application that is written using T-SQL statements, and you want to store data that has high security requirements and is available online: 

<table>
	<tr><td>Requirement/Constraint</td><td>SQL Server in Azure VM</td><td>Azure SQL DB</td><td>Postgres as a Service</td></tr>
	<tr><td>Low Cost</td><td>2</td><td>3</td><td>3</td></tr>
	<tr><td>Easy to Manage</td><td>2</td><td>3</td><td>3</td></tr>
	<tr><td>Highly Securable</td><td>3</td><td>3</td><td>2</td></tr>
	<tr><td>Fully Supports T-SQL</td><td>3</td><td>3</td><td>0</td></tr>
	<tr><td></td><td></td><td></td><td></td></tr>
	<tr><td>Score: </td><td>10</td><td>12</td><td>8</td></tr>
</table>

In this simple example, Azure SQL DB is a high candidate for your solution. (In production, there would be far more requirements and constraints, and you may need to use a 1-5 scale rather than 1-3)

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Create a Decision Matrix</b></p>

In this activity you will use the scenario you selected from above and create a Decision Matrix using a spreadsheet.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

- [Open this reference and read through it](https://www.smartsheet.com/decision-matrix-templates). 
- Create a spreadsheet for your Decision Matrix, or download one of the samples from the reference.
- Fill out the Decision Matrix based on the problem requirements and constraints using the technologies and processes you developed in the previous steps

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.4 Explain the Solution</h2>

The architecture design session above is most often conducted by the technical staff with representation from the business. After the design session is complete, the findings should be condensed into an instrument (slides, notes or other graphics tool) that allow the team to explain the proposal along with a set of options. At the end of the presentation, your team should also include a description of the project, timelines, and responsibilities. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Create a Solution Presentation</b></p>

In this activity your team will create a solution briefing with options and timelines.

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

- Open this reference: <a href="https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources" target="_blank">https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources</a>
- You may use the PowerPoint template provided (6 - Handoff.pptx) or create your own briefing tool, using anything you like. 
- Make sure you include at least one alternative option and explain why you chose your original one.
- If time permits, review the schedule documents in the Resources area and assign reasonable timelines to your soluition. 

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true">References</h2>

<ul>
    <li><a href="http://www.ceptara.com/blog/how-to-write-problem-statement" target="_blank">How to Write a Problem Statement</a> - Article on writing effective problem statements</li>
    <li><a href="https://www.mindtools.com/pages/article/newTED_03.htm" target="_blank">Decision Matrix Analysis</a> - Article on creating a Decision Matrix</li>
    <li><a href="https://azure.microsoft.com/en-us/pricing/calculator/" target="_blank">Azure Pricing Calculator</a> - Create a cost analysis of your solution</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/data-guide/" target="_blank">Azure Data Architecture Guide</a> - This guide presents a structured approach for designing data-centric solutions on Microsoft Azure. It is based on proven practices derived from customer engagements</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/" target="_blank">Azure Reference Architectures</a> - Recommended practices, along with considerations for scalability, availability, manageability, and security</li>
    <li><a href="https://docs.microsoft.com/en-us/azure/architecture/cloud-adoption/" target="_blank">Microsoft Cloud Adoption Framework for Azure</a> - Article on writing effective problem statements</li>
	<li><a href="https://azure.microsoft.com/en-us/overview/trusted-cloud/" target="_blank">Microsoft Azure Trust Center</a> - Full reference site for Azure security, privacy and compliance</li>
	

</ul>

<!-- 
https://www.quickbase.com/blog/decision-matrix-make-the-best-business-decisions-possible

https://www.bing.com/search?q=decision+matrix+template+excel&FORM=QSRE7

https://www.mindtools.com/pages/article/newTED_03.htm 

https://asq.org/quality-resources/decision-matrix 

http://www.rfp-templates.com/What-is/Decision-Matrix 

https://www.designorate.com/decision-matrix-decision-making/

http://www.criticaltosuccess.com/use-an-excel-based-decision-matrix-for-critical-decisions/ 

https://www.launchexcel.com/resources/decision-matrix/ 
-->


Congratulations! You have completed this workshop on "SQL Ground-to-Cloud". You now have the tools, assets, and processes you need to extrapolate this information into other applications.