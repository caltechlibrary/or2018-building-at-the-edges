<!-- Slide 00 -->

# Building software at the edges of heterogeneous repositories

## the road to continuous migration

R. S. Doiel, Caltech Library, rsdoiel@library.caltech.edu

Thomas Morrell, Caltech Library, tomorrell@caltech.edu

https://caltechlibrary.github.io/or2018-building-at-the-edges

--
<!-- Slide 01 -->

# Overview

Caltech Library has shifted from a system centric
to a data centric software development.

This lead to two concepts and several tools projects.

## Concepts

+ Developing software at the edges
+ Continuous Migration

## Open Source Projects

+ [dataset](https://github.com/caltechlibrary/dataset)
	+ storing, retrieving, manage JSON documents on disc and in the cloud
+ [datatools](https://github.com/caltechlibrary/datatools)
	+ tools to help converting and extracting data a the command line easier
+ legacy projects: [mkpage](https://github.com/caltechlibrary/mkpage), [eprinttools](https://github.com/caltechlibrary/eprinttools), [cait](https://caltechlibrary/cait)


1
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

2
--
<!-- Slide 03 -->

# What do I mean by development at the edges?

+ Web API are the edge of a system
    + Prefer Web API over direct SQL manipulation
    + Favor data models over SQL Scheme
    + Avoid system plugins and customization
+ Focus on data models and data flow
    + Script data flow
    + Use copies for transformation
    + Have a mechanism to hold intermediate results

Practicing this showed us **Continuous Migration**

3
--
<!-- Slide 04 -->


# What is "Continuous Migration"?

+ The ability to moving your data into and out of your system(s) via API
+ The act of migrating your data as a regular practice

# A few of the advantages

+ Capture everything needed for preservation
+ Lower the cost of picking a better tool in the future
+ Makes it easier to setup test systems using real data
+ You are in a good position ready to analyze your data
+ A platform to test and operate on whole collections

4
--
<!-- Slide 05 -->

# Lessons learned

Our experience has shown us

+ Data is more important then (legacy) system that holds it
+ Data sustainability benefits from simple structures
+ It maybe easier to sustain data than to sustain complex software systems

5
--
<!-- Slide 06 -->


# Which brings us to three tool projects...

+ [datatools](https://caltechlibrary.github.io/datatools/) 
    + for processing data and prototyping data flows
+ [dataset](https://caltechlibrary.github.io/dataset/) 
    + for holds copies of data during processing 
    + or between steps in a data pipeline
+ Other projects include: [mkpage](https://caltechlibrary.github.io/mkpage/), [eprinttools](https://github.com/caltechlibrary/eprinttools/)

6
--
<!-- Slide 07 -->

**demo**

7
--
<!-- Slide 08 -->


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

8
--
<!-- Slide 09 -->


# Summarizing

## Technology we're using now

+ Go with Python for orchestration
+ [dataset](https://caltechlibrary.github.io/dataset)
	+ https://github.com/caltechlibrary/dataset/releases/latest
+ [datatools](https://caltechlibrary.github.io/datatools)
	+ https://github.com/caltechlibrary/datatools/releases/latest
+ [mkpage](https://caltechlibrary.github.io/mkpage)
	+ https://github.com/caltechlibrary/mkpage/releases/latest

Compiled versions for Mac, Windows,
Linux and Raspberry Pi!

9
--
<!-- Slide 10 -->


# Thank you

R. S. Doiel, rsdoiel@library.caltech.edu

Thomas Morrell, Caltech Library, tomorrell@caltech.edu

https://caltechlibrary.github.io/or2018-building-at-the-edges


