program ghk
  implicit none
  include 'mpif.h'
  integer :: ierr,np,rank
  integer ::N,sum,newsum,i
  call mpi_init(ierr)
  call mpi_comm_size(mpi_comm_world,np,ierr)
  call mpi_comm_rank(mpi_comm_world,rank,ierr)

  N=100
  sum = 0
  do i=1+rank,N,np
    sum = sum + i
  end do
  call mpi_reduce(sum,newsum,1,MPI_INTEGER,MPI_SUM,0,MPI_COMM_WORLD,ierr)
  write(*,*) "Total sum is :",newsum
  call mpi_finalize(ierr)
end program ghk
