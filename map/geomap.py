import numpy as np
import pickle
from collections import defaultdict
from shapelib import ShapeFile
import dbflib
from mpl_toolkits.basemap import Basemap
from matplotlib.collections import LineCollection
import matplotlib as mpl
from matplotlib import cm
import matplotlib.pyplot as plt
import time
import gzip

class world:
    def __init__(self):
        self.countries = defaultdict(list)
        self.regions = defaultdict(list)
        self.subregions = defaultdict(list)

#  http://thematicmapping.org/downloads/world_borders.php
def serialize_tm_world(shapefile_fn, output_fn):
    print 'serialize ' + shapefile_fn + '.shp'
    tm_world = world()
    shp = ShapeFile(shapefile_fn + '.shp')
    dbf = dbflib.open(shapefile_fn + '.dbf')
    nb_records = shp.info()[0]
    for i in xrange(nb_records):
        shp_record = dbf.read_record(i)
        shp_object = shp.read_object(i)
        # countries
        name = shp_record['NAME']
        shp_record['SHAPE'] = shp_object.vertices()
        tm_world.countries[name] = shp_record
        # regions
        region = shp_record['REGION']
        tm_world.regions[region].append(name)
        # subregions
        subregion = shp_record['SUBREGION']
        tm_world.subregions[subregion].append(name)
    pickle.dump(tm_world, gzip.open(output_fn,'w'))

def load_tm_world(fn):
    data = pickle.load(gzip.open(fn,'rb'));
    return data

def bounding_box(countries, world):
    region_ids = [c['REGION'] for c in countries]
    lat, lon = [], []
    for i in region_ids:
        region = world.regions[i]
        for c in region:
            lat.extend(p[0] for p in world.countries[c]['SHAPE'])
            lon.extend(p[1] for p in world.countries[c]['SHAPE'])
    print min(lat), min(lon), max(lat), max(lon)
    return min(lat), min(lon), max(lat), max(lon)

# todo take min/max lat/lon from countries
def get_region_map(countries, world,
                   color='white',
                   watercolor='lightblue'):
    y1, x1, y2, x2 = bounding_box(countries, world)
    m = Basemap(resolution='i',projection='merc',
                llcrnrlat=y1,urcrnrlat=y2,
                llcrnrlon=x1,urcrnrlon=x2,
                lat_ts=(x1+x2)/2) # takes ~4s
    m.drawmapboundary(fill_color=watercolor)
    m.drawcountries(linewidth=0.5)
    m.drawcoastlines(linewidth=0.5)
    m.fillcontinents(color=color,lake_color=watercolor)
    # m.drawparallels(np.arange(y1,y2,2.), labels=[1,0,0,0],
    #                color='black', dashes=[1,0],
    #                labelstyle='+/-', linewidth=0.2) # draw parallels
    #m.drawmeridians(np.arange(x1,x2,2.), labels=[0,0,0,1],
    #                color='black', dashes=[1,0],
    #                labelstyle='+/-', linewidth=0.2) # draw meridians
    return m

def geo2map_coord(coords, geomap):
    lons, lats = zip(*coords)
    x, y = geomap(lons, lats)
    return x, y

def plot_countries(countries, world):
    if type(countries) != list:
        countries = [countries]
    ax = plt.subplot(111)
    m = get_region_map(countries, world)
    for country in countries:
        shpsegs = []
        for ring in country['SHAPE']:
            x, y = geo2map_coord(ring, m)
            shpsegs.append(zip(x,y))
        lines = LineCollection(shpsegs,antialiaseds=(1,))
        lines.set_facecolors(cm.jet(np.random.rand(1)))
        lines.set_edgecolors('k')
        #lines.set_linewidth(0.3)
        ax.add_collection(lines)
    plt.show()
