![](graphics/solutions-microsoft-logo-small.png)

# R for Data Professionals

## 02 Programming Basics

<p style="border-bottom: 1px solid lightgrey;"></p>

<dl>
  <dt>Course Outline</dt>
  <dt>1 - Overview and Course Setup</dt>
  <dt>2 - Programming Basics <i>(This section)</i></dt>
    <dd>2.1 - Getting help</dd>
    <dd>2.2 Code Syntax and Structure</dd>
    <dd>2.3 Variables<dd>
    <dd>2.4 Operations and Functions<dd>
  <dt>3 Working with Data</dt>
  <dt>4 Deployment and Environments</dt>
<dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

From here on out, you'll focus on using R in programming mode. You can open your R IDE or R Command prompt and copy and paste the code you see here, and later you'll have a set of exercises to do on your own.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.1 - Getting help and the Workspace</b></p>

The very first thing you should learn in any language is how to get help. You can [find the help documents on-line](https://mran.microsoft.com/documents/getting-started), or simply type
 
`help()`

or 

`?`
 
For help on a specific topic, put the topic in the parenthesis:
 
 `help(str)`

 To see a list of topics in an HTML viewer, type:

 `help.start()`

Need help on help()? Just type:

`?help`

As you work, your commands, the libraries (packages) that you have loaded, and other environment settings are saved in a file called the *Workspace*. You'll be prompted when you leave an R session to save the session as the current Workspace, you can save the Workspace manually, and you can load a Workspace. The Workspace is stored in a file in your current directory. To work with your directory, check out these commands (again, use help() for more info):

`# Print the current working directory`

`getwd()`

`# List objects in the current workspace`

`ls()`

`# Change to NewDirectory`

`setwd("c:/NewDirectory")`

There's more than just the Workspace - you'll cover the environment in the last module of this course. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>2.2 Code Syntax and Structure</b></p>

Let's cover a few basics about how R code is written. First, R is a *Functional* programming language. That means you'll take objects and perform functions on them, working from right to left. You can pass operations like you do in PowerShell, but in the opposite direction.

Here are few "style guide" concepts to keep in mind (For a full discussion, check out the [Style Guide for R blog from R-Bloggers](https://www.r-bloggers.com/r-style-guide/) ):

<pre>
    File Names: end in .R
    Identifiers: variable.name (or variableName), FunctionName, kConstantName
    Line Length: try to keep a maximum of 80 characters
    Indentation: two spaces, no tabs
    Curly Braces: first on same line, last on own line
    else: Surround else with braces
    Assignment: use <-, not =
    Semicolons: don't
    Commenting Guidelines: all comments begin with # followed by a space; inline comments need two spaces before  the #
</pre>

In general, use standard coding practices - don't use keywords for variables, be consistent in your naming (camel-case, lower-case, etc.), comment your code clearly, and understand the general syntax of your language, and follow the principles above. But the most important tip is to at least read R code examples on the web and decide for yourself how well that fits into your organization's standards.

Comments in R start with the hash-tag: `#`. There are no block comments (and this makes us all sad) so each line you want to comment must have a tag in front of that line. Keep the lines short (80 characters or so) so that they don't fall off a single-line display like at the command line.

R is case-sensitive, for both variables and commands. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>2.3 Variables</b></p>

Variables (more properly, *objects*) stand in for replaceable values. R is not strongly-typed, meaning you can just declare a variable name and set it to a value at the same time, and R will try and guess what data type you want. You use an `<-` sign to assign values, and `==` to compare things. The `<-` below is read as "x gets 10" or x takes 10". It's part of the functional programming model R uses:

`x <- 10`

Quotes \" or ticks \' are fine for character values, just be consistent.

`# There are some keywords to be aware of, but x and y are always good choices.`

`x <- "Buck"    # I'm a string.`

`typeof(x)`

`y <- 10        # I'm an integer.`

`typeof(y)`

`# What's in memory now?`

`objects()`

To change the type of a value, just re-enter something else:

`x <- "Buck"    # I'm a string.`

`type(x)`

`x <- 10        # Now I'm an integer.`

`typeof(x)`

Or cast it By implicitly declaring the conversion:

`x <- "10"`

`typeof(x)`

`# Or use a test:`

`is.character(x)`

`# Cast it to another type, use as not is:`

`y <- as.numeric(x)`

`typeof(y)`

To concatenate numeric values, use the `c()` (combine) function:

`x <- 10`

`y <- 20`

`c(x, y)`

To concatenate string values, use the `paste()` function - which can automatically add a space for you:

`x <- "Buck"`

`y <- "Woody"`

`paste(x, y)`

<pre>
  Buck Woody
</pre>

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/checkbox.png"><b>2.4 Operations and Functions</b></p>

R training normally starts with data types (called *Data Structures* in R) - and you'll do that in a moment. For now, know that the primary data object in R is something called a *vector*, which is similar to a row of data, each with an individual address.  

R has the following main operators:

<pre>
    +          Addition
    -          Subtraction
    *          Multiplication
    /          Division
    ^ or **	   Exponentiation
    x %% y     Modulus
    x %/% y    Integer Division
    <          Less than
    <=         Less than or equal to
    >          Greater than
    >=         Greater than or equal to
    ==         Exactly equal to
    !=         Not equal to
    !x 	       Not x
    x | y      x OR y
    x & y      x AND y
    isTRUE(x)  Test x
</pre>

Wait...that's it? That's all you're going to tell me? *(Hint: use what you've learned):*

`help("%%")`

Walk through each of these operators carefully - you'll use them when you work with data in the next module.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b>Activity - Programming basics</b></p>

Open the **02_ProgrammingBasics.R** file and run the code you see there. The exercises will be marked out using comments:

`# <TODO> - 2`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

- Introduction to the R Coding Style - http://stackabuse.com/introduction-to-the-python-coding-style/
- The Microsoft Tutorial and samples for R - https://code.visualstudio.com/docs/languages/R 

Next, Continue to *03 Working with Data*