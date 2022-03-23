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
from matplotlib.patches import Ellipse
import matplotlib.transforms as transforms

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
    
    cov = np.cov(point_details["Factor1"], point_details["Factor2"])
    lambda_, v = np.linalg.eig(cov)
    lambda_ = np.sqrt(lambda_)
    
    ell = Ellipse(xy=(np.mean(point_details["Factor1"]), np.mean(point_details["Factor2"])),alpha = .4, width=lambda_[np.argmax(abs(lambda_))]*1.5*2, height=lambda_[1-np.argmax(abs(lambda_))]*1.5*2, angle=np.rad2deg(np.arctan2(*v[:,np.argmax(abs(lambda_))][::-1])))
    ell.set_facecolor(hmmm.Color.iloc[1])
    ax.add_patch(ell)


    plt.scatter(point_details["Factor1"].mean(), point_details["Factor2"].mean(), c=hmmm.Color.iloc[1],edgecolors='black',marker="s",alpha=1,s=105)

        
            
            
            
    
            
    
    # plot shape
    
  #  t = np.arange(x_hull.shape[0], dtype=float)
   # t /= t[-1]
   # nt = np.linspace(0, 1, 100)
   # x1 = scipy.interpolate.BSpline(t, x_hull, nt)
   # y1 = scipy.interpolate.BSpline(t, y_hull, nt)
    
    
    #plt.fill(new_pseudo_x, new_pseudo_y, '--', c=hmmm.Color.iloc[1], alpha=0.2)
    
    
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
