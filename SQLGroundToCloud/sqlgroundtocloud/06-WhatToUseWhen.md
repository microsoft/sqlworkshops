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

TODO: Topic Description

<br>

TODO: Thing

<br>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: Review Business Scenarios</b></p>

In this activity you will review three business scenarios, and pick one to focus on for the rest of this module.  

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/AdventureWorksLogo.png?raw=true"><b>AdventureWorks</b></p>

[Adventure Works Cycles](https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008/ms124825(v=sql.100) ) is a large, multinational manufacturing company. The company manufactures and sells metal and composite bicycles to North American, European and Asian commercial markets. While its base operation is located in Bothell, Washington with 290 employees, several regional sales teams are located throughout their market base.

Starting in the year 2000, Adventure Works Cycles bought a small manufacturing plant, Importadores Neptuno, located in Mexico. Importadores Neptuno manufactures several critical subcomponents for the Adventure Works Cycles product line. These subcomponents are shipped to the Bothell location for final product assembly. In 2001, Importadores Neptuno, became the sole manufacturer and distributor of the touring bicycle product group.

Coming off a successful fiscal year, Adventure Works Cycles is looking to broaden its market share by targeting their sales to their best customers, extending their product availability through an external Web site, and reducing their cost of sales through lower production costs. They are also looking to modernize their data estate.

<b>Project Goals</b>

- Cloud Integration
- Performance
- Publishing Data
- B2B

<b>Project Constraints</b>

- B2B should be pull

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/contosologo.png?raw=true"><b>Contoso</b></p>

[The Contoso company](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-overview) is The Contoso Corporation is a multi-national business with headquarters in Paris, France. It is a conglomerate manufacturing, sales, and support organization with over 100,000 products. They are embarking on a multi-year process of migrating from company-owned datacenters to a cloud provider. They have narrowed the list of potential vendors to three, including Microsoft. They have [high security](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-info-protect) and [interoperability with mobile device](https://docs.microsoft.com/en-us/microsoft-365/enterprise/contoso-mdm) concerns. 


<b>Project Goals</b>

- Security
- Multi-Cloud
- API's by default

<b>Project Constraints</b>

- International Compliance
- Access Tracking
 

TODO: https://docs.microsoft.com/en-us/azure/migrate/contoso-migration-overview

<p style="border-bottom: 1px solid lightgrey;"></p>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/WideWorldImportersLogo.png?raw=true"><b>Wide World Importers</b></p>

[Wide World Importers](https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-what-is?view=sql-server-2017) (WWI) is a wholesale novelty goods importer and distributor operating from the San Francisco bay area in the United States.

As a wholesaler, WWI's customers are mostly companies who resell to individuals. WWI sells to retail customers across the United States including specialty stores, supermarkets, computing stores, tourist attraction shops, and some individuals. WWI also sells to other wholesalers via a network of agents who promote the products on WWI's behalf. While all of WWI's customers are currently based in the United States, the company is intending to push for expansion into other countries.

WWI buys goods from suppliers including novelty and toy manufacturers, and other novelty wholesalers. They stock the goods in their WWI warehouse and reorder from suppliers as needed to fulfil customer orders. They also purchase large volumes of packaging materials, and sell these in smaller quantities as a convenience for the customers.

Recently WWI started to sell a variety of edible novelties such as chilli chocolates. The company previously did not have to handle chilled items. Now, to meet food handling requirements, they must monitor the temperature in their chiller room and any of their trucks that have chiller sections.

<b>Project Goals</b>

- Big Data
- ML/AI

<b>Project Constraints</b>

- Short timeframe
- Unknown Data Sources
- API calls for the predictions


<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.2 Understand the Constraints</h2>

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Description</b></p>

TODO: Enter activity description with checkbox

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.2 Understand the Technologies</h2>

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Description</b></p>

TODO: Enter activity description with checkbox

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/pencil2.png?raw=true">6.3 Create a Decision Matrix</h2>

TODO: Topic Description

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/point1.png?raw=true"><b>Activity: TODO: Activity Name</b></p>

TODO: Activity Description and tasks

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Description</b></p>

TODO: Enter activity description with checkbox

<p><img style="margin: 0px 15px 15px 0px;" src="https://github.com/microsoft/sqlworkshops/blob/master/graphics/checkmark.png?raw=true"><b>Steps</b></p>

TODO: Enter activity steps description with checkbox

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

https://www.quickbase.com/blog/decision-matrix-make-the-best-business-decisions-possible

https://www.bing.com/search?q=decision+matrix+template+excel&FORM=QSRE7

https://www.mindtools.com/pages/article/newTED_03.htm 

https://asq.org/quality-resources/decision-matrix 

http://www.rfp-templates.com/What-is/Decision-Matrix 

https://www.designorate.com/decision-matrix-decision-making/

http://www.criticaltosuccess.com/use-an-excel-based-decision-matrix-for-critical-decisions/ 

https://www.launchexcel.com/resources/decision-matrix/ 


<ul>
    <li><a href="url" target="_blank">TODO: Enter courses, books, posts, whatever the student needs to extend their study</a></li>
</ul>

Congratulations! You have completed this workshop on "SQL Ground-to-Cloud". You now have the tools, assets, and processes you need to extrapolate this information into other applications.