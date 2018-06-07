#!/bin/bash
#
# Demo showing some basic functionality of dataset and
# some of the programs from datatools.
#

# Unpack some CSV from our Excel Workbook
xlsx2csv -nl -N demo-data.xlsx | while read -r SHEET; do
    xlsx2csv -o "${SHEET}.csv" demo-data.xlsx "${SHEET}"
done

# Create an initial empty dataset, tree shows the structure on disc
dataset init friends.ds
tree friends.ds

# Add an object of my friend Eamonn
dataset friends.ds create eamonn '{"name":"Eamonn"}'

# This OK meant things worked, set's see what we saved
dataset -p friends.ds read eamonn

# the tree command will show the change on disc, notice eamonn.json 
# is in a bucket called "aa", json objects are stored in buckets
# in a round robin fashion, aa to zz
tree friends.ds

# Let's update the record outside dataset
dataset -p friends.ds read eamonn >eamonn.json

# I am using sed to change my JSON object
sed -i.bak -s "s/Eamonn/Eamonn O'Gorman/g" eamonn.json

# Now I am to send my changes back into our collection
dataset friends.ds update eamonn eamonn.json

# Now check our change
dataset -p friends.ds read eamonn

#
# Let's add more friends
#
dataset friends.ds import-csv friends-with-orcids.csv 1
# How many records do we have now?
dataset friends.ds count
# What are the keys?
dataset friends.ds keys
# What do those records look like
dataset friends.ds keys | while read -r KEY; do
    dataset friends.ds read "${KEY}"
done

# Can I get just the records with ORCIDS?
dataset friends.ds keys '(ne .orcid "")' >orcid-friends.keys

# How do I list only the orcids? I'm going to use a data frame for that
dataset friends.ds frame 'orcid-friends' orcid-friends.keys .name .orcid
dataset friends.ds frame 'orcid-friends' | jq .

# Let's git the values out of the grid attribute of the frame
dataset friends.ds frame orcid-friends | jsoncols '.grid[:][2]' |
	jsonrange -i - -values

# We're going save those orcids as a set of keys.
dataset friends.ds frame orcid-friends | jsoncols '.grid[:][2]' |
	jsonrange -i - -values >orcids.keys

# Now, for each ORCID we're going to fetch from
# feeds.library.caltech.edu/person/ORCID/(articles|data).keys
cat orcids.keys | sed -E 's/"//g' | while read -r ORCID; do
	curl -o tmp.keys "https://feeds.library.caltech.edu/person/${ORCID}/articles.keys"
	cat tmp.keys >>"articles.keys"
done

# We need to do some data clean up.
#   + Get rid of any "404 page not found" messages
#   + Get rid of empty lines
#   + Sort the keys (just so it is easy to track)
mv articles.keys tmp.keys
cat tmp.keys | sed -E 's/404 page not found//g' | sort -u -n | sed -E '/^$/d' >articles.keys

# Let's create a new collection called articles.ds where we can
# save a subset of the articles found in 
#     s3://dataset.library.caltech.edu/CaltechAUTHORS
dataset init articles.ds

# Now with each articles.keys we read a JSON object out of our
# S3 based collection to our local collection.
# If it works we should see our friendly "OK" for each copy
cat articles.keys | while read -r KEY; do
    echo -n "Copying ${KEY} "
    dataset s3://dataset.library.caltech.edu/CaltechAUTHORS read "${KEY}" | dataset -i - articles.ds create "${KEY}"
done
# Now we should see a bunch of articles copied...


# Build the indexes
dataset articles.ds indexer articles.bleve index-defs/articles.json

# Basic search of an index
dataset find articles.bleve 'National Science Foundation'
# This is a JSON version of the results
dataset -p -json find articles.bleve 'National Science Foundation'
# This is a version only returning the ids
dataset -ids find articles.bleve 'National Science Foundation'

# That's the demo, all done
exit 0
