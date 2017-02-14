#!/bin/bash

# Base URL
URL="api.openweathermap.org/data/2.5/weather"

# Location
ZIP="95616,us"

# API
KEY="a559584a14097432f0c8e706bf73f3b1"

# Fahrenheit
UNITS="imperial"
TMP=65

# curl - get data from site
# tr - change ',' and '{' to newlines
# grep - get the info we need
# awk - output message based on curl info
## tmp - lowest tolerable temperature without a coat in fahrenheit
curl -s $URL?appid=$KEY\&zip=$ZIP\&units=$UNITS | tr ',|{' '\n' | grep "temp\|description" | awk -F : -v tmp=$TMP 'BEGIN {print "Checking the weather ..."} {

if ($1 == "\"temp\"") {
	if ($2 <= tmp) {
		print "Bring a coat. It is " $2 " F"
	} else {
		print $2 " F today. No coat needed" 
	}
} else if ($1 == "\"description\""){
	if ($2 ~ /rain/) {
		print "Bring an umbrella. We have " $2
	} else {
		print "No umbrella needed. We have " $2
	}
}

} END {print "Have a good one!"}'

