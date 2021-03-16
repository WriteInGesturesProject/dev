import pandas
import json
import numpy
import requests
import unidecode

LEXIQUE_PATH = ""
SAVE_PATH = ""
LIGHT = False

lexique_ortho_phon = pandas.read_csv(LEXIQUE_PATH)

result = "{"
if not LIGHT:
    result += "\n"

allWords = []

for index, row in lexique_ortho_phon.iterrows():
    if str(row["1_ortho"]) in allWords:
        continue
    allWords.append(str(row["1_ortho"]))
    if LIGHT:
        result += "\"" + str(row["1_ortho"]) + "\":\"" + str(row["2_phon"]) + "\","
    else:
        result += "\t\"" + str(row["1_ortho"]) + "\":\"" + str(row["2_phon"]) + "\",\n"

result += "}"

f = open(SAVE_PATH, "w", encoding= "UTF8")
f.write(result)
f.close()
    

    