program para
  implicit none
  include 'mpif.h'
  integer::err,rank,np
  real::mat(300,300)

  open(unit=1,file='random_numbers.dat')
  call mpi_init(err)
  call mpi_comm_size(mpi_comm_world,np,err)
  call mpi_comm_rank(mpi_comm_world,rank,err)
  
  if rank==0 then
    read(1,*) mat
    call 

  end if




end program para