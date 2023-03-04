#!/usr/bin/env bash

shopt -s extglob
mkdir dist

cp -r artifacts/master/* dist/
cp -r artifacts/!(master) dist/

find dist
