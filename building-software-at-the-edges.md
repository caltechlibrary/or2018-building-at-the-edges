
# Building software at the edges of heterogeneous repositories

R. S. Doiel, Caltech Library, rsdoiel@library.caltech.edu

Thomas Morrell, Caltech Library, tomorrell@caltech.edu

--

# Overview

Caltech Library has shifted from a system centric to a data centric
approach in developing software. This lead to two concepts and two
tool projects.

## Concepts

+ Developing software at the edges
+ Continuous Migration

## Open Source Repos

+ [dataset](https://github.com/caltechlibrary/dataset)
+ [datatools](https://github.com/caltechlibrary/datatools)
+ [mkpage](https://github.com/caltechlibrary/mkpage) (JSON friendly template engine)

--

# Our Problem

Caltech Library has a heterogeneous mix of repository systems 

+ [EPrints](http://www.eprints.org/uk) - [CaltechAUTHORS](https://authors.library.caltech.edu), [CaltechTHESIS](https://thesis.library.caltech.edu)
+ [Invenio](http://invenio-software.org/) - [CaltechDATA](https://data.caltech.edu)
+ [Islandora](https://www.islandora.ca/) - various image repositories
+ [ArchivesSpace](http://archivesspace.org/) -  for Archive collection management
+ ...

Development was limited to configuration, customization, writing plugins or modules. 

And all systems eventually became legacy systems over time...

--

# Our Problem

Look at the variety of code we need to maintain...

+ [EPrints](http://www.eprints.org/uk) - Perl/SQL/EPrint markup
+ [Invenio](http://invenio-software.org/) - Python/SQL
+ [Islandora](https://www.islandora.ca/) - PHP/SQL/Java
+ [ArchivesSpace](http://archivesspace.org/) - Java/jRuby/SQL
+ ...

Not to mention build/deployment code, the usual HTML, CSS, JavaScript required in any web based software. It becomes a bit much.

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

Developing at the edges works for our new as well as legacy systems

--

# What do I mean by development at the edges?

+ API are the edge of a system
+ We choose to focus on data model and data flow via API

Common directions of data flow

```
    A data flow might be from one system to another

    A data flow might be round trip by way of augmentation/transformation

    A data flow might be for aggregation
```

--

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

+ Ensures you know how to capture everything needed
+ By capturing what you need in an ongoing basis you
  lower the cost of picking a better tool in the future
+ Can help and be informed by your preservation and 
  disaster recovery strategies
+ Makes it easier to setup test systems using real data

--

# Continuous Migration, lessons learned

Our experience has shown us

+ Data is more important then (legacy) system that holds it
+ Sustainability of data is enhanced by simple structures
+ Data sustainability may be easier to achieve than software sustainability

--

# Continuous Migration in practice

+ Prefer Web API over direct SQL access to DB
+ Take a "data science" approach to the problem solving
    + Leverage existing tools
    + Build purpose driven tools when required
+ Spot patterns and use that to generalize processes
  and the software you write

--

# Continuous Migration, lessons learned

## A really common pattern

+ Harvest
+ Transform
+ Redeploy

--

# Which brings us to two tool projects...

+ [datatools](https://caltechlibrary.github.io/datatools/) for processing data and prototyping data flows
+ [dataset](https://caltechlibrary.github.io/dataset/) for holding copies of data during processing and between steps in a data pipeline
+ [mkpage](https://caltechlibrary.github.io/mkpage/) a JSON friendly rendering engine

--

# [datatools](https://caltechlibrary.github.io/datatools/)

Working at the edges has lead us to develop two open source collections of tools.  The first is _datatools_.

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

