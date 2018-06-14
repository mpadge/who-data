#!/bin/bash

# Currently (14 June 2018) reduces sizes thus:
#
# when      |   Repo total  |   .git
# Before    |   737MB       |   523MB
# After     |   613MB       |   400MB
#
# Actually not that big an effect. Is it maybe better just to start a new .git
# and remove all history?

# ---------------- kathmandu ---------------- 
cp -r kathmandu/osm ../kathmandu-osm
git filter-branch --prune-empty -f \
	--index-filter "git rm --cached -f --ignore-unmatch kathmandu/osm/*.Rds" --

cp -r kathmandu/popdens ../kathmandu-popdens
git filter-branch --prune-empty -f \
	--index-filter "git rm --cached -f --ignore-unmatch kathmandu/popdens/*.tif" --
# worldpop only needs to be removed once:
git filter-branch --prune-empty -f \
	--index-filter "git rm --cached -f --ignore-unmatch kathmandu/worldpop/*" --

# ---------------- accra ---------------- 
cp -r accra/osm ../accra-osm
git filter-branch --prune-empty -f \
	--index-filter "git rm --cached -f --ignore-unmatch accra/osm/*.Rds" --

cp -r accra/popdens ../accra-popdens
git filter-branch --prune-empty -f \
	--index-filter "git rm --cached -f --ignore-unmatch accra/popdens/*.tif" --

# worldpop only needs to be removed once:
git filter-branch --prune-empty -f \
	--index-filter "git rm --cached -f --ignore-unmatch accra/worldpop/*" --

# ---------------- bristol ---------------- 
cp -r bristol/osm ../bristol-osm
git filter-branch --prune-empty -f \
	--index-filter "git rm --cached -f --ignore-unmatch bristol/osm/*.Rds" --

cp -r bristol/popdens ../bristol-popdens
git filter-branch --prune-empty -f \
	--index-filter "git rm --cached -f --ignore-unmatch bristol/popdens/*.tif" --

# ---------------- clean git history ---------------- 
#rm -rf .git/refs/original
git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now

# ---------------- reinsert the files ---------------- 

# ----- kathmandu
if [ ! -d "kathmandu/osm" ]; then
    mkdir kathmandu/osm
fi
cp ../kathmandu-osm/* kathmandu/osm/.
rm -r ../kathmandu-osm
if [ ! -d "kathmandu/popdens" ]; then
    mkdir kathmandu/popdens
fi
cp ../kathmandu-popdens/* kathmandu/popdens/.
rm -r ../kathmandu-popdens

# ----- accra
if [ ! -d "accra/osm" ]; then
    mkdir accra/osm
fi
cp ../accra-osm/* accra/osm/.
rm -r ../accra-osm
if [ ! -d "accra/popdens" ]; then
    mkdir accra/popdens
fi
cp ../accra-popdens/* accra/popdens/.
rm -r ../accra-popdens

# ----- bristol
if [ ! -d "bristol/osm" ]; then
    mkdir bristol/osm
fi
cp ../bristol-osm/* bristol/osm/.
rm -r ../bristol-osm
if [ ! -d "bristol/popdens" ]; then
    mkdir bristol/popdens
fi
cp ../bristol-popdens/* bristol/popdens/.
rm -r ../bristol-popdens

git add kathmandu/osm/*
git add kathmandu/popdens/*
git add accra/osm/*
git add accra/popdens/*
git add bristol/osm/*
git add bristol/popdens/*

# git push --prune --force origin master
