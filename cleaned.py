import json 
import csv
import string

with open('filtered_data.json') as file: 
    filtered_data = json.load(file)

to_be_deleted = []
for entry in filtered_data:
    if  float(entry["ontology/careerPrizeMoney"]) > 1e8:
        to_be_deleted.append(entry)
for i in to_be_deleted:
    filtered_data.remove(i)

list_all = []

for entry in filtered_data:
    row = []
    if "ontology/birthDate" in entry:
        if isinstance(entry["ontology/birthDate"],list):
            entry["ontology/birthDate"] = entry["ontology/birthDate"][0]
        split_date = entry["ontology/birthDate"].split("-")
        year = int(split_date[0])
        month = int(split_date[1])
        row.append(year)
        row.append(month)
    else: 
        row.append(None)
    if "ontology/height" in entry:
        if float(entry["ontology/height"]) == 0:
            row.append(None)
        elif float(entry["ontology/height"]) > 3:
            entry["ontology/height"] = float(entry["ontology/height"])/100
            row.append(entry["ontology/height"])
        else:
            row.append(entry["ontology/height"])
    else:
        row.append(None)
    if "ontology/weight" in entry:
        if float(entry["ontology/weight"]) > 1e7:
            row.append(None)
        else:
            row.append(entry["ontology/weight"])
    else:
        row.append(None)
    row.append(entry["ontology/careerPrizeMoney"])
    list_all.append(row)

csv_file_path = "huge_csv.csv" 

with open(csv_file_path, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerow(["birth_year", "birth_month", "height","weight","prize_money",'dominant_hand','backhand','forehand'])
    for row in list_all:
        writer.writerow(row)

print(f"CSV file '{csv_file_path}' created successfully.")
