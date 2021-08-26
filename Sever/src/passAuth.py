import json


keys = key


j = open("Test_json.json")
data = json.load(j)
def loadFile(dic):
    with open('Test_json.json', 'w') as json_file:
        json.dump(dic, json_file)






