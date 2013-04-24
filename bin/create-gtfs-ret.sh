#!/bin/bash
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATE=$(date +'%Y%m%d')
wget ../kv1feeds/ret -N --accept=zip -q -P ../kv1feeds/ret -nd -r http://kv1.openov.nl/ret/ -l 1
python manager.py -d kv1ret -f ../kv1feeds/ret
status=$?
rm -rf /tmp/*.txt
if [ $status != 0 ];
then exit 1
fi

<<<<<<< HEAD
cp ../sql/linepublicnumbers.csv /tmp
python pasparser.py /tmp
dropdb pas
createdb pas
psql -d pas -c "Create extension postgis;"
psql -d pas -f ../sql/pas.sql
psql -d pas -f ../sql/pas-gtfs.sql
mkdir -p ../gtfs/ret
zip -j ../gtfs/ret/gtfs-pasret-$DATE.zip /tmp/*.txt
rm ../gtfs/ret/gtfs-pasret-latest.zip
ln -s gtfs-pasret-$DATE.zip ../gtfs/ret/gtfs-pasret-latest.zip
=======
rm -rf /tmp/*.txt
psql -d kv1ret -f ../sql/gtfs-ret.sql
psql -d kv1ret -f ../sql/gtfs-passtimes.sql
zip -j ../gtfs/ret/gtfs-kv1ret-$DATE.zip /tmp/*.txt
rm ../gtfs/ret/gtfs-kv1ret-latest.zip
ln -s gtfs-kv1ret-$DATE.zip ../gtfs/ret/gtfs-kv1ret-latest.zip
>>>>>>> upstream/master

#Validate using Google TransitFeed
python transitfeed/feedvalidator.py ../gtfs/ret/gtfs-kv1ret-$DATE.zip -o ../gtfs/ret/gtfs-kv1ret-$DATE.html -l 50000 --error_types_ignore_list=ExpirationDate,FutureService
python transitfeed/kmlwriter.py ../gtfs/ret/gtfs-kv1ret-$DATE.zip
zip ../gtfs/ret/gtfs-kv1ret-$DATE.kmz ../gtfs/ret/gtfs-kv1ret-$DATE.kml
rm ../gtfs/ret/gtfs-kv1ret-$DATE.kml
