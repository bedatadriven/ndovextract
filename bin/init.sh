#!/bin/sh


# grab the transit feed validator
if [ ! -f transitfeed ];
then
	svn checkout http://googletransitdatafeed.googlecode.com/svn/trunk/python transitfeed
fi


for DB in kv1htm kv1arr kv1cxx kv1ebs kv1gvb
do
	dropdb $DB
	createdb $DB
	psql -d $DB -c "CREATE EXTENSION postgis"
	psql -d $DB -f ../sql/kv1.sql
done


