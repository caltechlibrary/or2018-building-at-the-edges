<!-- Slide 00 -->

# Building software at the edges of heterogeneous repositories

R. S. Doiel, Caltech Library, rsdoiel@library.caltech.edu

Thomas Morrell, Caltech Library, tomorrell@caltech.edu

https://caltechlibrary.github.io/or2018-building-at-the-edges

--
<!-- Slide 01 -->

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
<!-- Slide 02 -->

# Our Problem, a heterogeneous mix of repository systems 

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

```
    We decided to develop at the edges in common
	rather than inside separate systems in separate languages
```

--
<!-- Slide 03 -->

# What do I mean by development at the edges?

+ Web API are the edge of a system
    + Prefer Web API over direct SQL manipulation
    + Favor data models over SQL Scheme
+ When Web API is missing or two complicated
	+ Look at a plugin option that supports standards (e.g. Sword vX)
+ Focus on data models and data flow
    + Script data flow and transformation
    + Avoid system plugins and customization

Practicing this showed us **Continuous Migration**

--
<!-- Slide 04 -->


# What is "Continuous Migration"?

+ The ability to moving your data into and out of your system(s) via API
+ The act of migrating your data as a regular practice

# A few of the advantages

+ Capture everything needed for preservation
+ Lower the cost of picking a better tool in the future
+ Makes it easier to setup test systems using real data
+ Your ready to analyze your data

--
<!-- Slide 05 -->

# Lessons learned

Our experience has shown us

+ Data is more important then (legacy) system that holds it
+ Sustainability of data is enhanced by simple structures
+ Data sustainability may be easier to achieve than software sustainability

--
<!-- Slide 06 -->


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
<!-- Slide 09 -->


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
<!-- Slide 10 -->


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
<!-- Slide 11 -->


# Evolving the right tools

Bash/Python plus these three projects evolved from migrating 
systems and data, data analysis of our collections and 
building an aggregated view of EPrints and Invenio content

**https://feeds.library.caltech.edu**

--
<!-- Slide 12 -->


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
<!-- Slide 13 -->


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
<!-- Slide 14 -->


# Thank you

R. S. Doiel, rsdoiel@library.caltech.edu

Thomas Morrell, Caltech Library, tomorrell@caltech.edu

https://caltechlibrary.github.io/or2018-building-at-the-edges

