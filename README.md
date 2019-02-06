<img style="float: right;" src="./graphics/solutions-microsoft-logo-small.png">

# SQL Server Workshops

This site is a map of learning content produced by and curated by the SQL Server team in Microsoft Engineering. These materials are meant to be instructor-led, but you can work through the materials on a test system on your own if desired. You can view all materials directly in this interface, or you can [view the raw github site for this content here](https://github.com/Microsoft/sqlworkshops). 

See the license information at the bottom of this README.md file.

Find a problem? Spot a bug? [Post an issue here](https://github.com/Microsoft/sqlworkshops/issues) and we'll try and fix it.

## SQL Server Data Platform

- [SQL Server 2019 Big Data Clusters - Architecture](https://github.com/Microsoft/sqlworkshops/tree/master/sqlserver2019bigdataclusters)

## SQL Server Programming

- [In Development](https://github.com/Microsoft/sqlworkshops)

## SQL Server Machine Learning and AI

- [In Development](https://github.com/Microsoft/sqlworkshops)


## SQL Server Business Analytics and Advanced Analytics

- [In Development](https://github.com/Microsoft/sqlworkshops)

*Disclaimer*

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

### Download all Workshops as a zip file

The entire repository can be [downloaded as a single ZIP file here](https://github.com/Microsoft/sqlworkshops/archive/master.zip). 


### Clone all Workshops using git

You can [clone the entire respository using `git` here](https://github.com/Microsoft/sqlworkshops.git). 

### Get only one Workshop
You can follow the steps below to clone individual files from a git repo using a git client. 

Example:

```
git clone -n https://github.com/Microsoft/sqlworkshops
cd sqlworkshops
git config core.sparsecheckout true
echo workshopname/*| out-file -append -encoding ascii .git/info/sparse-checkout
git checkout
```

For more information about `sparse checkout please` visit [this](https://stackoverflow.com/questions/23289006/on-windows-git-error-sparse-checkout-leaves-no-entry-on-the-working-directory) stackoverflow thread.

### Code of Conduct
This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

### License
These samples and templates are all licensed under the MIT license. See the LICENSE file in the root.

### Questions
Email questions to: sqlserversamples@microsoft.com.
