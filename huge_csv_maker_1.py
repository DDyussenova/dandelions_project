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

#aimed output: csv file with three columns: preferred hand, backhandstyle, forehand style


#to begin with, we can notice we have lists, not just strings as entries. let us inspect them 

# for entry in filtered_data:
#     if "ontology/plays" in entry and isinstance(entry["ontology/plays"], list):
#         print(entry["ontology/plays"])

#in most cases, these can be combined fine. there are a few entries however that give too much information
#such as "occassionaly uses two-handed backhand" and "single-handed until 1979". for our purposes, this is too
#much detail and we filter that out

for entry in filtered_data:
    if "ontology/plays" in entry and isinstance(entry["ontology/plays"], list):
        phrase = ''
        for words in entry["ontology/plays"]:
            if "occasionally" not in words and "1979" not in words:
                phrase += words
        entry["ontology/plays"] = phrase

#then, there are some weird datapoints to remove: [1993, 1995, 1997, 1998, unknown]
erroneous = ['1993', '1995', '1997', '1998', 'unknown']
for entry in filtered_data:
    if "ontology/plays" in entry and entry["ontology/plays"] in erroneous:
        del entry["ontology/plays"]


#let us now, to remove some duplicants:
# 1.  make everything lowercase
# 2.  since 1=one=single, turn all those instances into single - do same for 2=two=double
# 3.  remove ();-

for entry in filtered_data:
    if "ontology/plays" in entry:
        phrase = entry["ontology/plays"]
        phrase = phrase.lower()
        for i in ['1','one']:
            if i in phrase:
                phrase = phrase.replace(i,'single')
        for i in ['2','two']:
            if i in phrase:
                phrase = phrase.replace(i,'double')
        for i in ['(',')',';']:
            if i in phrase:
                phrase = phrase.replace(i,'')
        for i in ['-','–']:
            if i in phrase:
                phrase = phrase.replace(i, ' ')
        entry["ontology/plays"] = phrase

#with this general cleaning done, it is time to work towards building the first layer of our csv - the dominant hand
        
#if we go through the unique entries by hand now (60 entries), we see that every unique entry neatly classifies whether the 
#player was left-handed,right-handed or ambidextrous. there are no spelling mistakes (except on leftt but that is fine), and no
#other language indicating hand preference (like double-handed instead of ambidextrous). thus, we only need to make sure that every
#entry only has one of 'left, right, ambidextrous' and we are good to go to build our first layer.

# for entry in filtered_data:
#     if "ontology/plays" in entry:
#         phrase = entry["ontology/plays"]
#         if ("right" in phrase and "left" in phrase) or ("right" in phrase and "ambidextrous" in phrase) or ("left" in phrase and "ambidextrous" in phrase):
#             print(phrase)

#this code gives us 'left handed ambidextrous' and 'right handed double handed both sides born left handed'. the first is ambiguous and shall thus be removed.
#the second gives too much information and shall be changed to 'right handed double handed both sides'

for entry in filtered_data:
    if "ontology/plays" in entry:
        phrase = entry["ontology/plays"]
        if phrase == "left handed ambidextrous":
            del entry["ontology/plays"]
        elif phrase =='right handed double handed both sides born left handed':
            entry["ontology/plays"] = 'right handed double handed both sides'

#now, we can build the first column for our csv file - containing the preferred dominant hand. 
dominant_hand = []
for entry in filtered_data:
    if "ontology/plays" in entry:
        phrase = entry["ontology/plays"]
        if 'right' in phrase:
            dominant_hand.append('right')
        elif 'left' in phrase:
            dominant_hand.append('left')
        elif 'ambidextrous' in phrase:
            dominant_hand.append('ambidextrous')
        else:
            dominant_hand.append(None)
    else:
        dominant_hand.append(None)

#perfect, our first layer should be done!

#we shall now start preparing our two other layers - backhand and forehand style
        
#because we no longer care about left or right hand, we can remove any mention of those. 
#for consiceness, we can also remove any mention of handed or hand, such that double-handed backhand becomes doubleback
        
#now lets get real minimalist, and remove spaces as well

#we are now left with 11 entries, and some still need to go. see the replacements to see which

removable_syntax = ['right','handed','hands','hand','leftt','left','tennis','ambidextrous']

replacements = {
'doublebothsides':'doubleforedoubleback',
'occasionallysinglefore':'',
'doubleforeandback': 'doubleforedoubleback',
'singleanddoubleback': ''
}
replacement_key = replacements.keys()

#here a function that changes our entries into the form we want
def prep(phrase): 
    for word in removable_syntax:
            if word in phrase:
                phrase = phrase.replace(word,'')
    phrase = phrase.replace(' ','')
    for key in replacement_key:
        if key in phrase:
            phrase = phrase.replace(key,replacements[key]) 
    return(phrase)

unique = []
for entry in filtered_data:
    if "ontology/plays" in entry:
        phrase = prep(entry["ontology/plays"])
        if "ontology/plays" in entry and phrase not in unique:
            unique.append(phrase)

for x in unique:
    print(x)


#now lets build the last two layers

backhand = []
forehand = []

for entry in filtered_data:
    if "ontology/plays" in entry:
        phrase = entry['ontology/plays']
        phrase = prep(phrase)
        if phrase == None or phrase == '':
            backhand.append(None)
            forehand.append(None)
        else:
            if "doubleback" in phrase:
                backhand.append('double')
            elif "singleback" in phrase:
                backhand.append('single')
            else: 
                backhand.append(None)
            if "doublefore" in phrase:
                forehand.append('double')
            else:
                forehand.append(None)
    else:
        backhand.append(None)
        forehand.append(None)

#we will now add the other four layers
        
list_all = []

for entry in filtered_data:
    row = []
    if "ontology/birthDate" in entry:
        if isinstance(entry["ontology/birthDate"],list):
            entry["ontology/birthDate"] = entry["ontology/birthDate"][0]
        row.append(entry["ontology/birthDate"])
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

#combining the two lists
for i in range(len(dominant_hand)):
    list_all[i].extend([dominant_hand[i],backhand[i],forehand[i]])

#finally writing into csv
csv_file_path = "huge_csv.csv" 

with open(csv_file_path, mode='w', newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerow(["birth_date","height","weight","prize_money",'dominant_hand','backhand','forehand'])
    for row in list_all:
        writer.writerow(row)

print(f"CSV file '{csv_file_path}' created successfully.")
