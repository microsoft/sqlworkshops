![](graphics/solutions-microsoft-logo-small.png)

# R for Data Professionals

## 01 Overview and Setup

In this course you'll cover the basics of the R language and environment from a Data Professional's perspective. While you will learn the basics of R itself, you'll quickly cover topics that have a lot more depth available. In each section you'll get more references to go deeper, which you should follow up on. Also watch for links within the text - click on each one to explore that topic.

The code sections of this course are as much a part of your learning as these overview files. You'll get not only assignments but explanations in the R code in those exercises.

Make sure you check out the **00 Pre-Requisites** page before you start. You'll need all of the items loaded there before you can proceed with the course.

You'll cover these topics in the course:

<p style="border-bottom: 1px solid lightgrey;"></p>

<dl>
  <dt>Course Outline</dt>
  <dt>1 - Overview and Course Setup <i>(This section)</i></dt>
  <dt>2 - Programming Basics</dt>
  <dt>3 Working with Data</dt>
  <dt>4 Deployment and Environments</dt>
<dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

<h2><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"> Overview</h2>

There are many "distributions" of R. The most common installation is from the CRAN - the Comprehensive R Network. The distribution you will use in this course is installed when you install SQL Server 2016 or higher with ML Services (or R Services in the earlier versions) is called Microsoft R Open (MRO), and its base code is from the CRAN distribution. MRO replaces a couple of libraries (more about those later) and adds a few to increase the speed, capabilities and features of standard CRAN R. 

You have a few ways of working with R:

- The Interactive Interpreter (Type `R` if it is in your path)
- Writing code and running it in some graphical environment (Such as VSCode, Visual Studio, RGUI, R-Studio, etc.)
- Calling an `.R` script file from the `R` command 

When you're in command-mode, you'll see that the code works more like a scripting language. Programming-mode looks like a standard programming language environment - you'll normally use that within an Integrated Programming Environment (IDE). In any case, R is an "interpreted" language, meaning you write code that R then runs through a series of steps before it returns a result.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity: Verify Your Installation and Configure R</b></p>

Open the **01_OverviewAndCourseSetup.R** file and run the code you see there. The exercises will be marked out using comments: 

`<TODO> - 01`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

- The Official R Documentation: https://mran.microsoft.com/rro
- The R tutorial (current as of the publication of this course) is in your ./assets folder as a file called `R-intro.pdf`.

Next, Continue to *02 Programming Basics*