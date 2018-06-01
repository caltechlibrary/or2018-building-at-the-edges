
# Building software at the edges of heterogeneous repositories

R. S. Doiel, Caltech Library, rsdoiel@library.caltech.edu

Thomas Morrell, Caltech Library, tomorrell@caltech.edu

https://caltechlibrary.github.io/or2018-building-at-the-edges


--

# Overview

Caltech Library has shifted from a system centric to a data centric
approach in developing software. This lead to two concepts and three
tool projects.

## Concepts

+ Developing software at the edges
+ Continuous Migration

## Open Source Projects

+ [datatools](https://github.com/caltechlibrary/datatools)
	+ tools to help converting and extracting data a the command line easier
+ [dataset](https://github.com/caltechlibrary/dataset)
	+ storing, retrieving, manage JSON documents on disc and in the cloud
+ [mkpage](https://github.com/caltechlibrary/mkpage)
	+ A diconstructed web content management system

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

Lots of languages to support. No single system fullfilled our needs.

Development became limited to configuration, customization, writing plugins or modules for a given system.

And all systems eventually became legacy systems over time...

--

# Constraints

+ Caltech is small
+ Caltech Library has limited staff for development
    + 2 software developers
    + 2 librarian developers

--

# But there is a windfall

+ Our developers are experienced
+ We have a diverse computing background
+ Our new and legacy systems have Web accessible API
+ Our external services have Web accessible API
	+ E.g. CrossRef, ORCID

```
    We decided to develop at the edges in common
	rather than inside separate systems in separate languages
```

--

# What do I mean by development at the edges?

+ API are the edge of a system
+ We choose to focus on data model and data flow via API

# Development at the edges in practice

+ Prefer web API over direct SQL manipulation
+ Favor data models over SQL Scheme
+ Prefer data flow over plugins and customization

Practicing this showed us **Continuous Migration**

--

# Continuous Migration, concept

+ Always be able to move data into and out of your system(s) via API
+ Migrate your data as part of your regular practice
	+ analogous to testing in software development practice

# Advantages

+ Ensures you know how to capture everything needed for preservation
+ By capturing what you need in an ongoing basis you
  lower the cost of picking a better tool in the future
+ Makes it easier to setup test systems using real data
+ Lowers the cost/expectation on a given system letting last longer

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

# Continuous Migration,

## A really common implementation pattern

+ Harvest
+ Transform
+ Redeploy

--

# Which brings us to three tool projects...

+ [datatools](https://caltechlibrary.github.io/datatools/) for processing data and prototyping data flows
+ [dataset](https://caltechlibrary.github.io/dataset/) for holding copies of data during processing and between steps in a data pipeline
+ [mkpage](https://caltechlibrary.github.io/mkpage/) a JSON friendly rendering engine and terribly simple web server

--

# [datatools](https://caltechlibrary.github.io/datatools/)

Working at the edges has lead us to develop three open source tools projects.  The first is _datatools_.

The goal of _datatools_ is to ease working with CSV, XLSX Workbooks and JSON documents on the command line or in Bash scripts. These include

+ csv2json, csvcleaner, csv2mdtable, csvfind, csvjoin, csv2xlsx
+ jsonjoin, jsonmunge, jsonrange (for iterating over JSON structures by value or key)
+ string (various common string operations that are inconvenient at times in Bash)
+ reldate (for calculating a relative date, e.g. -3 weeks ago)
+ xlsx2csv, xlsx2json for extracting sheets from an XLSX Workbook file

Combining these with Unix work horses like *cURL*, *sed*, and *grep* you can get pretty far with your data munging without leaving the command line or simple Bash script.

But if you need to work with a large number of JSON objects ...

--

# [dataset](https://caltechlibrary.github.io/dataset/)

Where _datatools_ collection is about transforming and extracting,
[dataset](https://caltechlibrary.github.io/dataset/) is all about storing and retrieving JSON objects by collection unique IDs. Harvesting a bunch of DOI metadata from CrossRef or public profiles from ORCID? You can write the JSON to disc but we've found it more convenient to organize those into collection.

Here's an example of getting an my ORCID profile and storing it.
 
<!--

TODO:

Need to create a simple show and tell of extracting something from a XLSX workbook,
Flip into a JSON collection and then join with data harvested from :w

-->

--

# mkpage

A "page" level content system including a terribly simple static web server

+ Markdown friendly
+ JSON friendly
+ simple set of tools to script a content system 

--

# Evolving the right tools

Bash/Python plus these three projects evolved out or migrating systems and data, data analysis of our collections and building

	https://feeds.library.caltech.edu

--

# Use case

## feeds.library.caltech.edu

Building an aggregated view of our repositories

### Harvesting

+ cURL (for exploring API)
+ Go and Python based utilities
+ Store results as JSON (plus attachments if needed) in 
  a dataset collection(s)

### Transformation

+ Bash/Python scripts
+ [dataset](https://caltechlibrary.github.io/dataset)

### Redeploy

+ [dataset](https://caltechlibrary.github.io/dataset), Python and [mkpage](https://caltechlibrary.github.io/mkpage)

<!-- DEMO HERE -->

--

# Use case

(internal facing)

## Data import and enhancement

+ Vendor supplied data in XLSX format (1Science)
+ Need to create an set of EPrint XML documents to import

Problem is a model for enhancement in general. We plan to use
this approach in batch adding ORCID, normalizing Funder names, etc.

### Harvest

+ xlsx2csv (from [datatools](https://caltechlibrary.github.io/datatools)

### Transformation

+ Python and [dataset](https://caltechlibrary.github.io/dataset)

#### Redeploy

+ Build EPrint XML documents for import with Python and [dataset](https://caltechlibrary.github.io/dataset) and [mkpage](https://caltechlibrary.github.io/mkpage)


<!-- DEMO HERE -->

--

# Collectively

## API used

+ Internal: [EPrints](http://www.eprints.org/uk/) and [Invenio](http://https://invenio-software.org/)
+ External: [CrossRef](https://api.crossref.org) API, [ORCID](https://orcid.org) API

## Technology we're using

+ Go and Python
+ [dataset](https://caltechlibrary.github.io/dataset)
+ [datatools](https://caltechlibrary.github.io/datatools)
+ [mkpage](https://caltechlibrary.github.io/mkpage)

--

# Thank you

+ https://github.com/caltechlibrary/datatools
+ https://github.com/caltechlibrary/dataset
+ https://github.com/caltechlibrary/mkpage
+ https://feeds.library.caltech.edu

R. S. Doiel, rsdoiel@library.caltech.edu
Thomas Morrell, Caltech Library, tomorrell@caltech.edu

https://caltechlibrary.github.io/or2018-building-at-the-edges
