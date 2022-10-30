from mpi4py import MPI
import sys
import numpy as np
comm =MPI.COMM_WORLD
size=comm.Get_size()
rank = comm.Get_rank()
name = MPI.Get_processor_name()

if rank==0:
    a = np.linspace(0,2,10)
    comm.send(a,dest=1,tag=11)

elif rank == 1:
    b=comm.recv(source=0,tag=11)
    print('data in processnumber',rank,'is',b)