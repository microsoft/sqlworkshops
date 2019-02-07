![](graphics/solutions-microsoft-logo-small.png)

# R for Data Professionals

## 04 Environments and Deployment

<p style="border-bottom: 1px solid lightgrey;"></p>

<dl>
  <dt>Course Outline</dt>
  <dt>1 - Overview and Course Setup</dt>
  <dt>2 - Programming Basics</dt>
  <dt>3 Working with Data</dt>
  <dt>4 Deployment and Environments <i>(This section)</i></dt>
    <dd>4.1 checkpoint and packrat</dd>
    <dd>4.2 save() and save()</dd>
<dl>

<p style="border-bottom: 1px solid lightgrey;"></p>

As you start this topic, it's important to define some terms. The word "environment" in this course has multiple levels:

- The operating system where you installed R
- The abstraction layer you work with outside of R (containers, for example)
- The variables within the R session ("EnvVar")
- Setting up an environment (a space) in code to store a bounded set of variables

In this overview course, you'll briefly cover the first three areas, and you'll find references for those. For the last item, learn more about  

The main installation of R - sometimes called "Core" or "base" - has a set of parameters it works with. Since it runs on many operating systems, these variables are set and altered in different ways. You can see these by typing the following command:

`??env`

That command will bring up a very extensive set of topics that deals with everything from the startup of the R environment to controlling which editor you default to.

To see the settings you're using now, use this function:

`Sys.getenv()`

Containers such as Docker allow an abstraction layer above the operating system, and you'll cover that in the next topic.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>4.1 Installing Libraries</b></p>

To install new Libraries, you can build the source code manually, but that's not the way it's most often done. Typically you use the library functions.

`??Library`

You can install a Package and it's Libraries using this command:

`install.packages(packagename)`

Use the Library you installed with this command:

`library(packagename)`

And you can remove a Library with this command:

`remove.packages(packagename)`

To show the currently installed and called Libraries, use this command:

`library()`

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>4.2 Reproducible R</b></p>

"Encoding" in R means to serialize a R object. Perhaps that isn't very helpful - what it really means is to take the output of whatever you did in R and make it available again in another environment or program. It's a way of saving the "state" of a program so that it can be transferred and then re-loaded. There are two functions you can use to serialize R objects and then load them:

<pre>
  ## save all data
  xx <- pi # to ensure there is some data
  save(list = ls(all = TRUE), file= "all.rda")
  rm(xx)

  ## restore the saved values to the current environment
  local({
    load("all.rda")
    ls()
  })

  xx <- exp(1:3)
  ## restore the saved values to the user's workspace
  load("all.rda") ## which is here *equivalent* to
  ## load("all.rda", .GlobalEnv)
  ## This however annihilates all objects in .GlobalEnv with the same names !
  xx # no longer exp(1:3)
  rm(xx)
  attach("all.rda") # safer and will warn about masked objects w/ same name in .GlobalEnv
  ls(pos = 2)
  ##  also typically need to cleanup the search path:
  detach("file:all.rda")

  ## clean up (the example):
  unlink("all.rda")
</pre>

There are a couple of other ways to save not only the current variables and outcomes of your R session, but the entire environment as well. As you might expect, you use a Library to do this work. The first Package to be aware of is checkpoint. Once installed and loaded, you use a `checkpoint()` command to "start" the session, do some work, and then "save" the session on disk. Here's a complete example from the documentation:

<pre>
  library(checkpoint)
  checkpoint("2015-04-26", checkpointLocation = tempdir())

  # Example from ?darts
  library(darts)
  x = c(12,16,19,3,17,1,25,19,17,50,18,1,3,17,2,2,13,18,16,2,25,5,5,
        1,5,4,17,25,25,50,3,7,17,17,3,3,3,7,11,10,25,1,19,15,4,1,5,12,17,16,
        50,20,20,20,25,50,2,17,3,20,20,20,5,1,18,15,2,3,25,12,9,3,3,19,16,20,
        5,5,1,4,15,16,5,20,16,2,25,6,12,25,11,25,7,2,5,19,17,17,2,12)
  mod = simpleEM(x, niter=100)
  e = simpleExpScores(mod$s.final)
  oldpar <- par(mfrow=c(1, 2))
  drawHeatmap(e)
  drawBoard(new=TRUE)
  drawAimSpot(e, cex = 5)
  par(oldpar)

  ## Create a folder to contain the checkpoint
  ## This is optional - the default is to use ~/.checkpoint

  dir.create(file.path(tempdir(), ".checkpoint"), recursive = TRUE, showWarnings = FALSE)

  ## Create a checkpoint by specifying a snapshot date

  library(checkpoint)
</pre>

You can read a lot more about this process here: https://cran.r-project.org/web/packages/checkpoint/vignettes/checkpoint.html

Another popular serializer is *packrat*. It works in much the same way as checkpoint, in that you start the program, do your work, save the stream, and then close the project. You can find more about packrat here: https://github.com/rstudio/packrat/. 

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/aml-logo.png"><b> Activity - Reproduceable R</b></p>

Now open the `/code/04_EnvironmentsAndDeployment.py` file and follow the instructions you see there for 4.2.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/cortanalogo.png"><b>4.3 Docker</b></p>

Two other abstraction levels are useful to think about. You're probably familiar with Virtual Machines - which uses software to emulate hardware. This lets you install a complete new "computer" in a computer's OS. One level up from that abstraction layer is a *Container*. A Container goes slightly further by including a very small kernel of an operating system (most often Linux) to operate a runtime - like R. This provides an even more consistent environment for your application, since it can also include settings and programs above the R level.

Of course, there's a lot more to these topics - read the references below to learn more.

<p><img style="float: left; margin: 0px 15px 15px 0px;" src="./graphics/thinking.jpg"><b>For Further Study</b></p>

- Description and example of working with R and Docker: http://blog.revolutionanalytics.com/2018/03/r-and-docker.html

Congratulations! You have completed this introductory course on working with data using R. As you can see, there is a great deal more to learn. The best way to do that is use what you have learned here and apply it to a real-world scenario. Try out your new skills and use the references and the materials in the `./assets` folder in your journey.