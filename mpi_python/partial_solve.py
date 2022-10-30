#from mpi4py import MPI
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


#comm = MPI.COMM_WORLD

#rank = comm.Get_rank()
#num_p = comm.Get_size()

#A= np.fromfile('random_numbers.dat',dtype=float,sep=' ')
A = pd.read_csv('random_numbers.dat',sep=' ',header=None,dtype=float).to_numpy()
#sum1=0
B=np.copy(A[:,1:])

C=np.copy(A[:,1:])
maxdif=1
while maxdif>1e-3:
    poten = np.copy(B)
    for i in range(1,299):
        for j in range(1,299):
        
           B[i,j] = (B[i-1,j]+B[i,j-1]+B[i+1,j]+B[i,j+1])/4
    print('running the process')
    maxdif=np.max(np.abs(B-poten))
fig=plt.figure(figsize=(7,7))
ax1=fig.add_subplot(2,1,1)
ax1.imshow(C)
ax2=fig.add_subplot(2,1,2)
ax2.imshow(B)
plt.show()

