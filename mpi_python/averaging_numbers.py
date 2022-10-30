
from mpi4py import MPI
import numpy as np
import pandas as pd


comm = MPI.COMM_WORLD

rank = comm.Get_rank()
num_p = comm.Get_size()

#A= np.fromfile('random_numbers.dat',dtype=float,sep=' ')
A = pd.read_csv('random_numbers.dat',sep=' ',header=None,dtype=float).to_numpy()
sum1=0
B=A[:,1:]
for i in range(300):
    if (i+1)%num_p==(rank+1):
        sum=np.sum(B[i])
        sum1 = sum1+sum
    elif (i+1)%num_p==0:
        if rank==3:
            sum=np.sum(B[i])
            sum1 = sum1+sum
print('sum in process',rank,'is',sum1)


if rank!=0:
    comm.send(sum1,dest=0,tag =rank)
else:
    newsum=sum1
    for j in range(1,num_p):
        sumk=comm.recv(source=j,tag=j)
        newsum=newsum+sumk
if rank==0:
    print('final sum in process 0',newsum)
    print('Average of random numbers:',newsum/(300*300))