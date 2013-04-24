NDOV Extract
============
NDOV extract takes the Koppelvlakken of the NDOV loketten and transforms it in what is currently the most conventional format used in the open 
transit 
world : GTFS.

Requirements
------------
Postgres 9.1+
Postgis 2.0+ (Added as extension). It is possible and quite easy to backport the code back to postgis 1.5


Setup
-----
Run ./bin/init.sh, which creates the required Postgis databases, and downloads required tools
