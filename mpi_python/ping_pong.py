from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

size=comm.Get_size()
rank = comm.Get_rank()
num=100
if rank==0:
    neighbour=1
    
elif rank==1:
    neighbour=0
if rank==0:
    msg=np.linspace(0,100,101)
    comm.send(msg,dest=1,tag=0)
    print('proc 0--> proc 1')

counter=0
while True:
    msg=comm.recv(source=neighbour,tag=0)
    print('proc ',rank,'recieved')

    counter=counter+1
    comm.send(msg,dest=neighbour,tag=0)
    print('proce',rank,'sent')


    if counter>num:
        print('Completed')
        break

