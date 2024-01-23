#making a csv file 

import json 
import csv

with open('filtered_data.json') as file: 
    filtered_data = json.load(file)

characteristic = {}
for person in filtered_data:
    for category in person:
        if category not in characteristic:
             characteristic[category] = 1
        else:
             characteristic[category] = characteristic[category] + 1

with open('categories.json', 'w') as file:
        json.dump(characteristic, file, indent = 4)