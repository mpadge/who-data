<!-- README.md is generated from README.Rmd. Please edit that file -->
who-data
========

[![Build Status](https://travis-ci.org/ATFutures/who.svg)](https://travis-ci.org/ATFutures/who) [![Project Status: Concept - Minimal or no implementation has been done yet.](http://www.repostatus.org/badges/0.1.0/concept.svg)](http://www.repostatus.org/#concept)

Data for [`who` repo](https://github.com/ATFutures/who). These are pre-processed with routines from the [`popdens`](https://github.com/ATFutures/popdens) package, which must be installed for this to work. It's all `makefile` based. Files for [`worldpop`](http://www.worldpop.org.uk) must be manually downloaded - see specific `[city]/worldpop` directories for details. These are national level `zip`-archived files which need to be cropped to the city level only, and are converted to `geotif` format. This can be done, and all OSM data also downloaded into corresponding directories with a single `make` call. Alternatively, the components can be executed with

    make osm
    make worldpop

Note that `make osm` will always overwrite any existing OSM data, whereas `make worlpop` will only convert files if they've not already been converted.
