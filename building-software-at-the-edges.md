
# Building software at the edges of heterogeneous repositories

R. S. Doiel, Caltech Library, rsdoiel@library.caltech.edu

Thomas Morrell, Caltech Library, tomorrell@caltech.edu

https://caltechlibrary.github.io/or2018-building-at-the-edges


--

# Overview

Caltech Library has shifted from a system centric
to a data centric approach in developing software. 
This lead to two concepts and three tools projects.

## Concepts

+ Developing software at the edges
+ Continuous Migration

## Open Source Projects

+ [datatools](https://github.com/caltechlibrary/datatools)
	+ tools to help converting and extracting data a the command line easier
+ [dataset](https://github.com/caltechlibrary/dataset)
	+ storing, retrieving, manage JSON documents on disc and in the cloud
+ [mkpage](https://github.com/caltechlibrary/mkpage)
	+ A deconstructed web content management system

--

# Our Problem

Caltech Library has a heterogeneous mix of repository systems 

+ [EPrints](http://www.eprints.org/uk) - Apache/Perl/MySQL + EPrints Markup
	+ [CaltechAUTHORS](https://authors.library.caltech.edu), 
	+ [CaltechTHESIS](https://thesis.library.caltech.edu)
+ [Invenio](http://invenio-software.org/) - Apache/Python/MySQL
	+ [CaltechDATA](https://data.caltech.edu)
	+ Hosted by tind.io
+ [Islandora](https://www.islandora.ca/) - Apache/PHP (Drupal)/MySQL + tomcat and Fedora Repository
	+ Various image repositories for https://archives.caltech.edu
+ [ArchivesSpace](http://archivesspace.org/) - Java/jRuby/MySQL
	+ Collection management for https://archives.caltech.edu

Lots of languages to support. No single system fulfills our needs.

Development became limited to configuration, customization, writing plugins or modules for a given system.

And all systems eventually became legacy systems over time...

--

# Constraints

+ Caltech is small
+ Caltech Library has limited staff for development
    + 2 software developers
    + 2 librarian developers

```
    We decided to develop at the edges in common
	rather than inside separate systems in separate languages
```

--

# What do I mean by development at the edges?

+ Web API are the edge of a system
    + Prefer Web API over direct SQL manipulation
    + Favor data models over SQL Scheme
+ Focus on data models and data flow
    + Script data flow and transformation
    + Avoid system plugins and customization

Practicing this showed us **Continuous Migration**

--

# Continuous Migration

+ Always be able to move data into and out of your system(s) via API
+ Migrate your data as part of your regular practice
	+ analogous to testing in software development

# A few of the advantages

+ Capture everything needed for preservation
+ Lower the cost of picking a better tool in the future
+ Makes it easier to setup test systems using real data
+ Your ready to analyze your data

--

# Continuous Migration, lessons learned

Our experience has shown us

+ Data is more important then (legacy) system that holds it
+ Sustainability of data is enhanced by simple structures
+ Data sustainability may be easier to achieve than software sustainability

Which allows us to

+ Take a "data science" approach to the problem solving
    + Leverage existing tools
    + Build purpose driven tools when required
+ Spot patterns and use that to generalize processes
  and the software you write

--

## A really common implementation pattern

+ Harvest
+ Transform
+ Redeploy

--

# Which brings us to three tool projects...

+ [datatools](https://caltechlibrary.github.io/datatools/) 
    + for processing data and prototyping data flows
+ [dataset](https://caltechlibrary.github.io/dataset/) 
    + for holds copies of data during processing 
    + or between steps in a data pipeline
+ [mkpage](https://caltechlibrary.github.io/mkpage/) 
    + a Markdown/JSON friendly rendering engine 
    + and terribly simple web server

--

# [datatools](https://caltechlibrary.github.io/datatools/)

Lots of command line tools...

+ csv2json, csvcleaner, csv2mdtable, csvfind, csvjoin, csv2xlsx
+ jsonjoin, jsonmunge, jsonrange (for iterating over JSON structures by value or key)
+ string (various common string operations that are inconvenient at times in Bash)
+ reldate (for calculating a relative date, e.g. -3 weeks ago)
+ xlsx2csv, xlsx2json for extracting sheets from an XLSX Workbook file

Combining these with Unix work horses like *cURL*, *sed*, and *grep* 
you can get pretty far with your data munging without leaving the 
command line or simple Bash script.

But if you need to work with a large number of JSON objects ...

--

# [dataset](https://caltechlibrary.github.io/dataset/)

[dataset](https://caltechlibrary.github.io/dataset/) is about storing and retrieving JSON objects by collection unique IDs.

+ store on local disc or in cloud (e.g. S3, GCS)
+ Move between trees and grids

# [mkpage](https://caltechlibrary.github.io/mkpage)

A "page" level content system including a terribly simple static web server

+ Markdown friendly
+ JSON friendly
+ A simple set of cli tools to script a content system 

--

# Evolving the right tools

Bash/Python plus these three projects evolved from migrating 
systems and data, data analysis of our collections and 
building an aggregated view of EPrints and Invenio content

**https://feeds.library.caltech.edu**

--

# Use case

## feeds.library.caltech.edu

### Harvesting

+ We are moving to Python scripts for harvesting
+ Store harvested data in a dataset collections

### API harvested

+ Internal: 
	+ CaltechAUTHORS/CaltechTHESIS (EPrints)
	+ CaltechDATA -(Invenio)
+ External:
	+ [ORCID](https://orcid.org) API
	+ [CrossRef](https://api.crossref.org) API

### Transformation

We build lists of object keys, then build arrays of objects
to render

+ Python 3.6 scripts
+ [dataset](https://caltechlibrary.github.io/dataset)

### Redeploy

+ We use Python 3.6 scripts walk through site and create/update views
+ [dataset](https://caltechlibrary.github.io/dataset)
+ [mkpage](https://caltechlibrary.github.io/mkpage)

--

# Summerizing

## Technology we're using

+ Go with Python for orchestration
+ [dataset](https://caltechlibrary.github.io/dataset)
	+ https://github.com/caltechlibrary/dataset/releases/latest
+ [datatools](https://caltechlibrary.github.io/datatools)
	+ https://github.com/caltechlibrary/datatools/releases/latest
+ [mkpage](https://caltechlibrary.github.io/mkpage)
	+ https://github.com/caltechlibrary/mkpage/releases/latest

Compiled versions for Mac, Windows,
Linux and Raspberry Pi!

--

# Thank you

R. S. Doiel, rsdoiel@library.caltech.edu
Thomas Morrell, Caltech Library, tomorrell@caltech.edu

https://caltechlibrary.github.io/or2018-building-at-the-edges

