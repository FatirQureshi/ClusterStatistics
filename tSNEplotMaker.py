# -*- coding: utf-8 -*-
"""
Created on Tue Mar 15 14:35:47 2022

@author: RPI
"""

"""
Created on Fri Mar  4 18:00:04 2022

@author: RPI
"""
import scipy
from scipy.spatial import ConvexHull
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import interpolate
import matplotlib.patches as mpatches

df = pd.read_csv('C:\\Users\\RPI\\Documents\\Qureshi Backup\\MATLAB\\MHahn\\tsne_input.csv')
fig, ax = plt.subplots(1, figsize=(7,7))
#plt.scatter(df.Factor1, df.Factor2, c= df.cold, alpha = 0.6, s=65)



#plt.legend(loc="upper left")


for i in df.Group.unique():
    # get the convex hull
    points = df[df.Group == i][['Score_1', 'Score_2']].values

    
    
    
    point_details = df[df.Group == i][['Score_1', 'Score_2']]
    
    hmmm=df[df.Group == i][['Color']];
    ax.scatter(point_details["Score_1"], point_details["Score_2"], c=hmmm.Color.iloc[1], label=i,
               alpha=0.7, edgecolors='none')
    centroid_true=point_details["Score_1"]-point_details["Score_1"].mean()
    centroid_true_y=point_details["Score_2"]-point_details["Score_2"].mean()
    point_details['c'] = (point_details['Score_1']**2)+(point_details['Score_2']**2)**(1/2)


    plt.scatter(point_details["Score_1"].mean(), point_details["Score_2"].mean(), c=hmmm.Color.iloc[1],edgecolors='black',marker="s",alpha=1,s=105)

    hull = ConvexHull(points)
    x_hull = np.append(points[hull.vertices,0],
                       points[hull.vertices,0][0])
    y_hull = np.append(points[hull.vertices,1],
                       points[hull.vertices,1][0])
    
    # interpolate
    dist = np.sqrt((x_hull[:-1] - x_hull[1:])**2 + (y_hull[:-1] - y_hull[1:])**2)
    dist_along = np.concatenate(([0], dist.cumsum()))
    spline, u = interpolate.splprep([x_hull, y_hull], 
                                    u=dist_along, s=0)
    interp_d = np.linspace(dist_along[1], dist_along[-1], 50)
    interp_x, interp_y = interpolate.splev(interp_d, spline)
    # plot shape
    plt.fill(interp_x, interp_y, '--', c=hmmm.Color.iloc[1], alpha=0.2)
    
    
ax.legend()    
ax.relim()
ax.autoscale_view()
plt.xlabel("Dimension 1",fontsize=18)
plt.ylabel("Dimension 2",fontsize=18)
plt.title("tSNE Analysis",fontsize=24)
#plt.xlim(-100,100)
#plt.ylim(-100,200)

plt.savefig('tSNEclusterPlot.png')
plt.show()