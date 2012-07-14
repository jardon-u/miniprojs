from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt

# setup Lambert Conformal basemap.
m = Basemap(width=12000000,height=9000000,projection='lcc',
            resolution='c',lat_1=52.,lat_2=53,lat_0=50,lon_0=0.)

# draw coastlines.
m.drawcoastlines()

# draw a boundary around the map, fill the background.
# this background will end up being the ocean color, since
# the continents will be drawn on top.
m.drawmapboundary(fill_color='blue')
m.drawcountries()

# fill continents, set lake color same as ocean color.
m.fillcontinents(color='white',lake_color='blue')
#plt.savefig('background1.png')

#m.bluemarble()

plt.show()
