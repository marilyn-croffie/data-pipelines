#! /usr/bin/bash

# Specify city of choice
city=Casablanca

# Download weather data for city of your choice to a file
curl -s wttr.in/$city?T --output weather_report

# Extract the data of interest from the raw data file and assign them to variables
temp=(`grep -oE "\-*[0-9]*\(*[0-9]*\)*\s°C" weather_report | cut -d " " -f1`)
obs_tmp=$(echo ${temp[0]})
fc_tmp=$(echo ${temp[2]})

# Define date variables for city of choice
year=`TZ="Morocco/Casablanca" date -u +%Y`
month=`TZ="Morocco/Casablanca" date -u +%m`
day=`TZ="Morocco/Casablanca" date -u +%d`

# Log weather data into live report
record=$(echo -e "$year\t$month\t$day\t$obs_tmp\t$fc_tmp")
echo $record >> weather.log