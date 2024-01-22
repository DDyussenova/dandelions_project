#run this first: sl 'Documents\labcourse\final_project\dandelions_project'

import json 
import string 


#create a file with the location of all the files
alfabet = list(string.ascii_uppercase)

files = []
for l in alfabet:
    files.append('../People/'+l+'_people.json')

#filters out all entries without careerPrizeMoney entry
output = []
for file in files:
    print(file)
    f = open(file)
    data = json.load(f)
    for entry in data:
        if "ontology/careerPrizeMoney" in entry:
            output.append(entry)

print(len(output))

with open('rough_filter.json', 'w') as file:
        json.dump(output, file, indent = 4)

print("done")




# #combine all data into one list
# output = []
# for file in files:
#     print(file)
#     f = open(file)
#     data = json.load(f)
#     output.extend(data)


# with open('combined.json', 'w') as file:
#         json.dump(output, file, indent = 4)

# print('done')

# #step 1: does every tennis player have career prizes? and is everyone with career prizes a tennis player?
# #weird names - no names? 
# #weird birth places?


