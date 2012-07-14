import urllib
import json

u = "http://dbpedia.org/data/Country.json"
data = urllib.urlopen(u)
json_data = json.loads(data.read())



for abstract in json_data[u]["http://dbpedia.org/ontology/abstract"]:
    if abstract['lang'] == 'en':
        print abstract['value']
