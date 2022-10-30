from mpi4py import MPI
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

comm = MPI.COMM_WORLD

rank = comm.Get_rank()
num_p = comm.Get_size()

A = pd.read_csv('random_numbers.dat',sep=' ',header=None,dtype=float).to_numpy()

B=np.copy(A[:,1:])

C=np.copy(A[:,1:])