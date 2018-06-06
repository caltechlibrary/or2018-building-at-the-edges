
In this demo we're going to work with **xlsx2csv**, **jsonrange**,
**jsoncols**, **sed**, **tree**, **cURL** and **dataset**.

In **dataset** I will be demonstrating CRUD operations, listing keys,
a "frame" of dataset data and well as indexing and query.


+ Demo on the command line extracting a sheet from an Excel Workbook
+ Initialize a dataset, show record functionality
+ Storing the resulting rows as individual JSON objects in a friends dataset collection. 
+ Select only the keys which have an orcid
+ Use the ORCID to fetch article keys from feeds.library.caltech.edu
+ Use the article keys to create a local subset collections for authors and data.
+ Index both subseted collections
+ Performance individual an aggregated searches on each.
+ Show search results in alternate formats (E.g. JSON).


```
export AWS_SDK_LOAD_CONFIG=1
# Unpack some CSV from our Excel Workbook
xlsx2csv -nl -N demo-data.xlsx | while read -r SHEET; do
xlsx2csv -o "${SHEET}.csv" demo-data.xlsx "${SHEET}"
done
# Create an initial empty dataset, tree shows the structure on disc
dataset init friends.ds
tree friends.ds
# Add an object of my friend Eamonn
dataset friends.ds create eamonn '{"name":"Eamonn"}'
dataset -p friends.ds read eamonn
# the tree command will show the change on disc 
tree friends.ds
# Let's update the record outside dataset
dataset -p friends.ds read eamonn > eamonnon.json
# I am using sed to change my JSON
sed -i.bak -s "s/Eamonn/Eamonn O'Gorman/g" eamonn.json
dataset friends.ds update eamonn eamonn.json
# Now check our change
dataset -p friends.ds read eamonn
# Let's add more friends
dataset friends.ds import-csv friends-with-orcids.csv 1
# How many records do we have now?
dataset friends.ds count
# What are the keys?
dataset friends.ds keys
# What so those records look like
dataset friends.ds keys | while read -r KEY; do
dataset friends.ds read "${KEY}"
done
# Can I get just the records with ORCIDS?
dataset friends.ds keys '(ne .orcid "")' > orcid-friends.keys
# How do I list only the orcids? I'm going to use a data frame for that
dataset friends.ds frame 'orcid-friends' orcid-friends.keys .name .orcid
dataset friends.ds frame 'orcid-friends' | jq . | more
# Let's git the values out of the grid attribute of the frame
dataset friends.ds frame orcid-friends | jsoncols .grid[:][2] | \
jsonrange -i - -values 
# We're going save those orcids as a set of keys.
dataset friends.ds frame orcid-friends | jsoncols .grid[:][2] | \
jsonrange -i - -values > orcids.keys
# Now, for each ORCID we're going to fetch from 
# feeds.library.caltech.edu/person/ORCID/(articles|data).keys
cat orcids.keys | sed -E 's/"//g' | while read -r ORCID; do
curl -o tmp1.keys "https://feeds.library.caltech.edu/person/${ORCID}/articles.keys"
cat tmp1.keys >> "articles.keys"
done
# Now get rid of any "404 page not found" messages
cat articles.keys | sed -E 's/404 page not found//g' | sort -u -n > tmp1.keys
mv tmp1 articles.keys
# now with each articles.keys and data.keys
dataset init articles.ds
cat articles.keys | while read -r KEY; do
dataset s3://dataset.library.caltech.edu/CaltechAUTHORS read "${KEY}" | dataset -i - articles.ds create "${KEY}"
done
dataset articles.ds indexer articles.bleve articles-idx.json

dataset articles.ds indexer articles.bleve articles-idx.json
dataset find articles.bleve 'Python'
dataset -ids find articles.bleve 'Python'
dataset -json find articles.bleve 'Python' | jq .
```

