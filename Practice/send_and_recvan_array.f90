program para
  implicit none
  include 'mpif.h'
  integer::err,mynode,totalnodes,num,i
  real(kind=8)::array(10)

  call mpi_init(err)
  call mpi_comm_size(mpi_comm_world,totalnodes,err)
  call mpi_comm_rank(mpi_comm_world,mynode,err)

  if(mynode==0)then
    num=10
    do i=1,num
        array(i)=i
    end do
    !write(*,*)array, 'in process',mynode
  end if

  if ( mynode==0 ) then
    do i=1,totalnodes-1
      call mpi_send(array,10,mpi_double,i,1,mpi_comm_world,err)
    end do
  else
    call mpi_recv(array,10,mpi_double,0,1,mpi_comm_world,mpi_status_ignore,err)

  end if
  write(*,*)array,'in process',mynode
  call mpi_finalize(err)
end program para