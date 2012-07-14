#
# BaseMap example by geophysique.be
# tutorial 07

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

### PARAMETERS FOR MATPLOTLIB :
import matplotlib as mpl
mpl.rcParams['font.size'] = 10.
mpl.rcParams['font.family'] = 'Comic Sans MS'
mpl.rcParams['axes.labelsize'] = 8.
mpl.rcParams['xtick.labelsize'] = 6.
mpl.rcParams['ytick.labelsize'] = 6.

fig = plt.figure(figsize=(11.7,8.3))
#Custom adjust of the subplots
plt.subplots_adjust(left=0.05,right=0.95,top=0.90,bottom=0.05,wspace=0.15,hspace=0.05)
ax = plt.subplot(111)
#Let's create a basemap of Europe
x1 = -20.
x2 = 40.
y1 = 32.
y2 = 64.

m = Basemap(resolution='i',projection='merc', llcrnrlat=y1,urcrnrlat=y2,llcrnrlon=x1,urcrnrlon=x2,lat_ts=(x1+x2)/2)
m.drawcountries(linewidth=0.5)
m.drawcoastlines(linewidth=0.5)
m.drawparallels(np.arange(y1,y2,2.),labels=[1,0,0,0],color='black',dashes=[1,0],labelstyle='+/-',linewidth=0.2) # draw parallels
m.drawmeridians(np.arange(x1,x2,2.),labels=[0,0,0,1],color='black',dashes=[1,0],labelstyle='+/-',linewidth=0.2) # draw meridians

from shapelib import ShapeFile
import dbflib
from matplotlib.collections import LineCollection
from matplotlib import cm

fn = 'TM_BORDERS/world'
shp = ShapeFile(fn + '.shp')
dbf = dbflib.open(fn + '.dbf')

for npoly in xrange(shp.info()[0]):
    shpsegs = []
    shpinfo = []

    shp_object = shp.read_object(npoly)
    verts = shp_object.vertices()
    rings = len(verts)
    for ring in xrange(rings):
        lons, lats = zip(*verts[ring])
        if max(lons) > 721. or min(lons) < -721. or max(lats) > 91. or min(lats) < -91:
            raise ValueError,msg
        x, y = m(lons, lats)
        shpsegs.append(zip(x,y))
        if ring == 0:
            shapedict = dbf.read_record(npoly)

        name = shapedict["NAME"]
        # add information about ring number to dictionary.
        shapedict['RINGNUM'] = ring+1
        shapedict['SHAPENUM'] = npoly+1
        shpinfo.append(shapedict)
    print shpsegs
    print name
    lines = LineCollection(shpsegs,antialiaseds=(1,))
    lines.set_facecolors(cm.jet(np.random.rand(1)))
    lines.set_edgecolors('k')
    lines.set_linewidth(0.3)
    ax.add_collection(lines)

plt.savefig('tutorial07.png',dpi=300)
plt.show()
