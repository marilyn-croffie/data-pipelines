#! /usr/bin/bash

# Extract the forecasted and observed temperatures for today
fc_tmp=$(tail -2 weather.log | head -1 | cut -d " " -f5)
obs_tmp=$(tail -1 weather.log | cut -d " " -f4)

# Calculate the forecast accuracy
accuracy=$(($fc_tmp-$obs_tmp))
echo -e "The forecast accuracy is $accuracy"

# Assign a label to each forecast based on its accuracy
if [ -1 -le $accuracy ] && [ $accuracy -le 1 ]
then
   accuracy_range=excellent
elif [ -2 -le $accuracy ] && [ $accuracy -le 2 ]
then
    accuracy_range=good
elif [ -3 -le $accuracy ] && [ $accuracy -le 3 ]
then
    accuracy_range=fair
else
    accuracy_range=poor
fi

echo "Forecast accuracy is $accuracy_range"

# Extract date variables
row=$(tail -1 weather.log)
year=$(echo $row | cut -d " " -f1)
month=$(echo $row | cut -d " " -f2)
day=$(echo $row | cut -d " " -f3)

# Append data to historical forecast accuracy file
record=$(echo -e "$year\t$month\t$day\t$obs_tmp\t$fc_tmp\t$accuracy\t$accuracy_range")
echo $record >> historical_fc_accuracy.tsv 