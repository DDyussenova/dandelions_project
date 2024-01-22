#run this first: sl 'Documents\labcourse\final_project\dandelions_project'

import json 
import string 

f = open('rough_filter_1.json')
data = json.load(f)

#so first we want to check whether every person with price money is a tennis player.
#it seems like tennis players have an entry in "http://www.w3.org/1999/02/22-rdf-syntax-ns#type_label" called "tennis player"

#first then, we shall check whether this "http://www.w3.org/1999/02/22-rdf-syntax-ns#type_label" is in every data point

for entry in data:
    if "http://www.w3.org/1999/02/22-rdf-syntax-ns#type_label" not in entry:
        print('error')

#this indeed seems to be true. we shall now check whether "tennis player" is indeed then in every data point

for entry in data:
    if "tennis player"  in entry["http://www.w3.org/1999/02/22-rdf-syntax-ns#type_label"]:
        print('error')

print('done')

#so indeed, every person in our list is a tennis player

#we will now check whether there are tennis players without prize money listed

alfabet = list(string.ascii_uppercase)

files = []
for l in alfabet:
    files.append('People/'+l+'_people.json')

without_price = 0
for file in files:
    print(file)
    f = open(file)
    data = json.load(f)
    for entry in data:
        if "tennis player" in entry["http://www.w3.org/1999/02/22-rdf-syntax-ns#type_label"]:
            if "ontology/careerPrizeMoney" not in entry:
                without_price += 1
print(without_price)  

#indeed, we have 1505 tennis players without cash price
