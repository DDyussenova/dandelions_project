#making a csv file 

import json 
import csv

with open('filtered_data.json') as file: 
    filtered_data = json.load(file)

print(len(filtered_data))

output_height = []
for person in filtered_data:
    if "ontology/height" in person:
        output_height.append(person)

print(len(output_height))

list_height_money = []
for player in output_height: 
     inside_list = []
     for key in player: 
          if "title" in key:
               inside_list.append(player[key]) 
          elif "ontology/height" in key:
               inside_list.append(player[key])
          elif "ontology/careerPrizeMoney" in key:
               inside_list.append(player[key])
     list_height_money.append(inside_list)
     
print(list_height_money)               

csv_file_path = "height_money.csv" 

with open(csv_file_path, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    
    # Write header
    writer.writerow(["Title", "Height", "Career Prize Money"])
    
    # Write data
    for row in list_height_money:
        writer.writerow(row)

print(f"CSV file '{csv_file_path}' created successfully.")