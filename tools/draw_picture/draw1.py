'''
import matplotlib.pyplot as plt 
import numpy as np 
import seaborn as sns 
import warnings 
warnings.filterwarnings("ignore") 
x = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15] 
y = [102,134,154,122,143,243,355,342,276,299,241,287,260,231,100] 

plt.figure(figsize=(10,5)) 
plt.plot(x,y) 
plt.title('Weight change in 15 months') 
plt.xlabel('Month') 
plt.ylabel('kg') 
plt.show() 
'''
import matplotlib.pyplot as plt
import numpy as np

ypoints = np.array([6, 2, 13, 10])

plt.plot(ypoints, linestyle = 'dotted')
plt.show()
