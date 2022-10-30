from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

size=comm.Get_size()
rank = comm.Get_rank()

name = MPI.Get_processor_name()

if rank==0:
    array = np.linspace(1,100,100)
    comm.send(array,dest=1,tag=4)
    print('Massage created and sent to process 1')
for i in range(1,100):
    if rank==1:
        
        if i==1:
            array1=comm.recv(source=0,tag=4)
            print('Process 1 recieved Array from process 0 ')
        else:
            array1=comm.recv(source=0,tag=i+5)
            print('Process 1 recieved Array from process 0 ')
        #print(array1)
        comm.send(array1,dest=0,tag=i+6)
        print('Process 1 sent Array to process 0 ')

    elif rank==0:
        array1=comm.recv(source=1,tag=i+6)
        print('Process 0 recieved Array from process 1 ')
        comm.send(array1,dest=1,tag=i+6)
        print('Process 0 sent Array to process 1 ')
