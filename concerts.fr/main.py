import feedparser

url = 'http://www.concerts.fr/Rss-Concerts-Ville/PAR'
feed = feedparser.parse(url)

for e in [feed['entries'][1]]:
    for key in e:
        print key + ':'
        print e[key]
        print
