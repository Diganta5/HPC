program hjk
  implicit none
  include 'mpif.h'
  integer::err,numproc,myid,i
  real(kind=8)::sum1,n(300),newsum,starttime,endtime
  
  open(unit=1,file='random_numbers.dat')
  !starttime=mpi_wtime()
  call mpi_init(err)
  
  call mpi_comm_size(mpi_comm_world,numproc,err)
  call mpi_comm_rank(mpi_comm_world,myid,err)
  sum1 = 0.0d0
  do i=myid+1,300,numproc
    read(1,*)n
     sum1=sum1 + sum(n)
  end do

  write(*,*)'sum in process',myid,'is',sum1
  call mpi_reduce(sum1,newsum,1,mpi_double,mpi_sum,0,mpi_comm_world,err)
  if ( myid==0 ) then
    write(*,*)'Total sum is:',newsum
    write(*,*)'Average is:',newsum/(300*300)
  end if
  
  call mpi_finalize(err)
  !endtime=mpi_wtime()
  !write(*,*)'time taken:',endtime-starttime
end program hjk