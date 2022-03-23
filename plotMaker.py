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

df = pd.read_csv('C:\\Users\\RPI\\Documents\\Qureshi Backup\\MATLAB\\MHahn\\FA_input.csv')
fig, ax = plt.subplots(1, figsize=(7,7))
#plt.scatter(df.Factor1, df.Factor2, c= df.cold, alpha = 0.6, s=65)



#plt.legend(loc="upper left")


for i in df.Group.unique():
    # get the convex hull
    points = df[df.Group == i][['Factor1', 'Factor2']].values

    
    
    
    point_details = df[df.Group == i][['Factor1', 'Factor2']]
    
    hmmm=df[df.Group == i][['Color']];
    ax.scatter(point_details["Factor1"], point_details["Factor2"], c=hmmm.Color.iloc[1], label=i,
               alpha=0.7, edgecolors='none')
    centroid_true=point_details["Factor1"]-point_details["Factor1"].mean()
    centroid_true_y=point_details["Factor2"]-point_details["Factor2"].mean()
    point_details['c'] = (point_details['Factor1']**2)+(point_details['Factor2']**2)**(1/2)


    plt.scatter(point_details["Factor1"].mean(), point_details["Factor2"].mean(), c=hmmm.Color.iloc[1],edgecolors='black',marker="s",alpha=1,s=105)

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
    interp_d = np.linspace(dist_along[0], dist_along[-1], 50)
    interp_x, interp_y = interpolate.splev(interp_d, spline)
    
    xlist=x_hull
    xlist = sorted(set(xlist))
    x_max_limit=xlist[-1]+abs((xlist[-1]-xlist[-3])/2)/2
    x_min_limit=xlist[0]-abs((xlist[0]-xlist[2])/2)/2
    
    test=0
    ylist=y_hull
    ylist = sorted(set(ylist))
    y_max_limit=xlist[-1]+abs((ylist[-1]-ylist[-2]))*2
    y_min_limit=xlist[0]-abs((ylist[0]-ylist[1]))*2
    iter_removed=0;
    new_pseudo_x=[]
    new_pseudo_y=[]
    new_x=np.empty((0,3), int)
    new_y=np.empty((0,3), int)
    for j in range(0, len(interp_x)-1):
        if interp_x[j]>=x_min_limit and interp_x[j]<=x_max_limit:
            test=test+1
            new_pseudo_x.append(interp_x[j])
            new_pseudo_y.append(interp_y[j])
        
            
            
            
    
            
    
    # plot shape
    
  #  t = np.arange(x_hull.shape[0], dtype=float)
   # t /= t[-1]
   # nt = np.linspace(0, 1, 100)
   # x1 = scipy.interpolate.BSpline(t, x_hull, nt)
   # y1 = scipy.interpolate.BSpline(t, y_hull, nt)
    
    
    plt.fill(new_pseudo_x, new_pseudo_y, '--', c=hmmm.Color.iloc[1], alpha=0.2)
    
    
ax.legend()    
ax.relim()
ax.autoscale_view()
plt.xlabel("Factor Score 1",fontsize=18)
plt.ylabel("Factor Score 2",fontsize=18)
plt.title("Varimax Factor Analysis",fontsize=24)
#plt.xlim(0,2)
#plt.ylim(-2,2)

plt.savefig('clusterPlot.png')
plt.show()