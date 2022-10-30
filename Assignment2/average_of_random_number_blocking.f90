program hjk
  implicit none
  include 'mpif.h'
  integer::err,numproc,myid,i,row_num,parts,tag,request(MPI_status_size),status(mpi_status_size)
  real(kind=8)::sum1,n(300),newsum,starttime,endtime,final_sum
  
  open(unit=1,file='random_numbers.dat')
  !starttime=mpi_wtime()
  call mpi_init(err)
  
  call mpi_comm_size(mpi_comm_world,numproc,err)
  call mpi_comm_rank(mpi_comm_world,myid,err)
  row_num=300
  parts=row_num/numproc
  sum1 = 0.0d0
  do i=1,300
    read(1,*)n
    if ( i>=parts*myid .and. i<parts*(myid+1) ) then
        sum1=sum1+sum(n)
    end if
    if ( myid==numproc-1 ) then
        if (i>=parts*(myid+1)) then
           sum1=sum1+sum(n)
        end if
    end if
  end do
  tag=0
  write(*,*)'sum in process',myid,'is',sum1
  if ( myid/=0 ) then
    call mpi_isend(sum1,1,mpi_double,0,tag,mpi_comm_world,request,err)
  else
    final_sum=sum1
    do i=1,numproc-1
        call mpi_irecv(sum1,1,mpi_double,i,mpi_any_tag,mpi_comm_world,request,err)
        call mpi_wait(request,status)
        final_sum=final_sum+sum1
    end do
    write(*,*)'The sum is:',final_sum
    write(*,*)'the average is:',final_sum/(300*300)
  end if
  !call mpi_reduce(sum1,newsum,1,mpi_double,mpi_sum,0,mpi_comm_world,err)
  !if ( myid==0 ) then
    !write(*,*)'Total sum is:',newsum
    !write(*,*)'Average is:',newsum/(300*300)
  !end if
  
  call mpi_finalize(err)
  !endtime=mpi_wtime()
  !write(*,*)'time taken:',endtime-starttime
end program hjk