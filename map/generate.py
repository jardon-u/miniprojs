#mpl.rcParams['font.size'] = 10.
#mpl.rcParams['font.family'] = 'Comic Sans MS'
#mpl.rcParams['axes.labelsize'] = 8.
#mpl.rcParams['xtick.labelsize'] = 6.
#mpl.rcParams['ytick.labelsize'] = 6.
#
#fig = plt.figure(figsize=(11.7,8.3))
#
##Custom adjust of the subplots
#plt.subplots_adjust(left=0.05,right=0.95,top=0.90,bottom=0.05,wspace=0.15,hspace=0.05)
#ax = plt.subplot(111)

import geomap

#geomap.serialize_tm_world('TM_BORDERS_SIMPL/world', 'tm_borders.sav')
world = geomap.load_tm_world('tm_borders.sav')

#for v in world.countries:
#    print v

c = [world.countries['Spain'], world.countries['France']]
geomap.plot_countries(c, world)

