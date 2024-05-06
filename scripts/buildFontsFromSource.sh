#!/bin/bash
python3.11 -m venv venv
source venv/bin/activate
pip3 install -r  ./requirements.txt

rm -rf build/*

# Build fonts - the filter ensures we get rid of transformed components - they look bad when hinted
python3.11 -m fontmake -u sources/1-drawing/Source-UFO/* -o otf --output-dir build/otf --filter DecomposeTransformedComponentsFilter
python3.11 -m fontmake -u sources/1-drawing/Source-UFO/* -o ttf --output-dir build/ttf --filter DecomposeTransformedComponentsFilter

# Fix unwanted tables
gftools fix-unwanted-tables build/otf/*
gftools fix-unwanted-tables build/ttf/*
