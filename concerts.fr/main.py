import feedparser

rss_pc = 'http://www.concerts.fr/RssProchainsConcerts'
rss_par = 'http://www.concerts.fr/Rss-Concerts-Ville/PAR'

feed = feedparser.parse(rss_pc)

print feed

for doc in [feed['entries'][1]]:
    for k in doc:
        print doc[k] #['title'], doc['date']

print len(feed['entries'])
