![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/microsoftlogo.png)

# Workshop: SQL Ground-to-Cloud

#### <i>A Microsoft workshop from the SQL Server team</i>

<p style="border-bottom: 1px solid lightgrey;"></p>

<img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/textbubble.png?raw=true"> <h2> 06 - What to Use When: Designing a Solution </h2>

In this workshop you'll cover using SQL Server, in on-premises and in-cloud, as well as hybrid applications as a solution for data processing. In each section you'll get more references, which you should follow up on to learn more. Also watch for links within the text - click on each one to explore that topic. The end of this module contains several helpful references you can use in this course and in production.

This module can be used stand-alone, and does not require any <a href="https://github.com/microsoft/sqlworkshops/blob/master/SQLGroundToCloud/sqlgroundtocloud/00-Pre-Requisites.md" target="_blank">Pre-Requisites</a> other than a laptop and some sort of design software - although you may also just use a whiteboard or paper for your design. 

There are many elements in a single solution, and in this module you'll learn how to take the business scenario and determine the best resources and processes to use to satisfy the requirements while considering the constraints within the scenario. 

In production, there are normally 6 phases to create  a solution: 

<dl>

  <dt>01 - <b><i>Discovery</i></b>: The original statement of the problem from the customer. This may be in the form of a printed request, or a meeting.</dt>
  <dt>02 - <b><i>Envisioning</i></b>: The original statement of the problem from the customer. This may be in the form of a printed request, or a meeting.</dt>
  <dt>03 - <b><i>Architecture Design Session (ADS)</i></b>: The original statement of the problem from the customer. This may be in the form of a printed request, or a meeting.</dt>
  <dt>04 - <b><i>Proof-Of-Concept (POC)</i></b>: The original statement of the problem from the customer. This may be in the form of a printed request, or a meeting.</dt>
  <dt>05 - <b><i>Implementation</i></b>: The original statement of the problem from the customer. This may be in the form of a printed request, or a meeting.</dt>
  <dt>06 - <b><i>Discovery</i></b>: The original statement of the problem from the customer. This may be in the form of a printed request, or a meeting.</dt>

</dl>

Throughout this module, you can use various templates, icons, stencils and other assets to assist you with each phase and the exercises. These assets can also be used in your production workloads: <a href="https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources" target="_blank">https://github.com/microsoft/sqlworkshops/tree/master/ProjectResources</a>

For this module, you'll focus on the <i>Discovery</i> and the <i>Architecture Design Session</i> phases only. If you wish to develop your solution further after the course, you can use the assets above to complete all phases.

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.1 Understand the Problem Space</h2>

The first step in any project is to fully understand the problem the company needs to solve, and any requirements and constraints they have on those goals. This is often in the form of a "Problem Statement", which is a formal set of paragraphs clearly defining the circumstances, present condition, and desired outcomes for a solution. At this point you want to avoid exploring how to solve the problem, and focus on what you want to solve. 

Begin with a complete examination of the company and organization as you can. Gather information from as many sources as possible, and simplify the descriptions to have specific measurements and depictions of the environment.

From there, lay out the problem, and then review that with all stakeholders. 

After everyone agrees on the problem statement, pull out as many requirments (goals) for the project as you can find, and then lay in any constraints the solution has. At this point, it's acceptable to have unrealistic constraints - later you can pull those back after showing a cost/benefit ratio on each requirement and constraint. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Review Business Scenarios</b></p>

In this activity you will review three business scenarios, and pick one to focus on for the rest of this module. The company descritpions, project goals, and constraints have already been laid out for you. 

Are there sub-goals that have been left out? Any other constraints you can think of?

After you make your choice, note any changes or additions you want to make to the scenario. Feel free to adapt it to have more information where you want clarity - you can make assumptions about any part of the scenario.

<p style="border-bottom: 1px solid lightgrey;"></p>

![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/AdventureWorksLogo.png?raw=true")

**AdventureWorks**

[Adventure Works Cycles](https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008/ms124825(v=sql.100) ) is a large, multinational manufacturing company. The company manufactures and sells metal and composite bicycles to North American, European and Asian commercial markets. While its base operation is located in Bothell, Washington with 290 employees, several regional sales teams are located throughout their market base.

Starting in the year 2000, Adventure Works Cycles bought a small manufacturing plant, Importadores Neptuno, located in Mexico. Importadores Neptuno manufactures several critical subcomponents for the Adventure Works Cycles product line. These subcomponents are shipped to the Bothell location for final product assembly. In 2001, Importadores Neptuno, became the sole manufacturer and distributor of the touring bicycle product group.

Coming off a successful fiscal year, Adventure Works Cycles is looking to broaden its market share by targeting their sales to their best customers, extending their product availability through an external Web site, and reducing their cost of sales through lower production costs. They are also looking to modernize their data estate.

<b>Project Goals</b>

- Modernize to a newer SQL version
- Cloud Integration
- Increase Performance
- Publish Product Catalog to the Web
- Enable B2B systems

<b>Project Constraints</b>

- Some systems must stay online
- In some cases, no code change is possible
- The B2B system should be a "Pull" from partners

<p style="border-bottom: 1px solid lightgrey;"></p>

![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/contosologo.png?raw=true)

**Contoso**

[The Contoso company](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-overview) is The Contoso Corporation is a multi-national business with headquarters in Paris, France. It is a conglomerate manufacturing, sales, and support organization with over 100,000 products. They are embarking on a multi-year process of migrating from company-owned datacenters to a cloud provider. They have narrowed the list of potential vendors to three, including Microsoft. They have [high security](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-info-protect) and [interoperability with mobile device](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-mdm) concerns. 


<b>Project Goals</b>

- Move to Cloud
- Multi-Cloud
- All client apps should be avaialable worldwide
- Server-side should be API's by default

<b>Project Constraints</b>

- High Security and Auditing capabilities
- International Compliance
- Access Tracking
 

TODO: https://docs.microsoft.com/en-us/azure/migrate/contoso-migration-overview

<p style="border-bottom: 1px solid lightgrey;"></p>

![](https://github.com/microsoft/sqlworkshops/blob/master/graphics/WideWorldImportersLogo.png?raw=true)

**Wide World Importers**

[Wide World Importers](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017) (WWI) is a wholesale novelty goods importer and distributor operating from the San Francisco bay area in the United States.

As a wholesaler, WWI's customers are mostly companies who resell to individuals. WWI sells to retail customers across the United States including specialty stores, supermarkets, computing stores, tourist attraction shops, and some individuals. WWI also sells to other wholesalers via a network of agents who promote the products on WWI's behalf. While all of WWI's customers are currently based in the United States, the company is intending to push for expansion into other countries.

WWI buys goods from suppliers including novelty and toy manufacturers, and other novelty wholesalers. They stock the goods in their WWI warehouse and reorder from suppliers as needed to fulfil customer orders. They also purchase large volumes of packaging materials, and sell these in smaller quantities as a convenience for the customers.

Recently WWI started to sell a variety of edible novelties such as chilli chocolates. The company previously did not have to handle chilled items. Now, to meet food handling requirements, they must monitor the temperature in their chiller room and any of their trucks that have chiller sections.

<b>Project Goals</b>

- Enable Big Data processing
- Enable Machine Learning and Artificial Intelligence prediction capabilities

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

- Open a note and detail all technologies you have studied in this workshop, and list them out. (Order is not important during this step)
- Next, write the problem element next to each technology that it could solve
- Document any processes you should follow when using each technology
 
<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.3 The Decision Matrix</h2>

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TCreate a Decision Matrix</b></p>

TODO: Activity Description and tasks


<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

- [Open this reference and read through it](https://www.smartsheet.com/decision-matrix-templates). 
- Create a spreadsheet for your Decision Matrix, or download one of the samples from the reference.
- Fill out the Decision Matrix based on the problem requirements and constraints using the technologies and processes you developed in the previous steps

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.4 Explain the Solution</h2>

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Description</b></p>

TODO: Enter activity description with checkbox

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/owl.png?raw=true"><b>For Further Study</b></p>

    <u>
        <li><a href="http://www.ceptara.com/blog/how-to-write-problem-statement" target="_blank">How to Write a Problem Statement</a> - Article on writing effective problem statements</li>
    </ul>
    
https://www.quickbase.com/blog/decision-matrix-make-the-best-business-decisions-possible

https://www.bing.com/search?q=decision+matrix+template+excel&FORM=QSRE7

https://www.mindtools.com/pages/article/newTED_03.htm 

https://asq.org/quality-resources/decision-matrix 

http://www.rfp-templates.com/What-is/Decision-Matrix 

https://www.designorate.com/decision-matrix-decision-making/

http://www.criticaltosuccess.com/use-an-excel-based-decision-matrix-for-critical-decisions/ 

https://www.launchexcel.com/resources/decision-matrix/ 



Congratulations! You have completed this workshop on "SQL Ground-to-Cloud". You now have the tools, assets, and processes you need to extrapolate this information into other applications.