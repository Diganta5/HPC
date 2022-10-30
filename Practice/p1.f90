program ghj
  implicit none
  include 'mpif.h'
  integer:: err,p,id,root,msg,tag
  call mpi_init(err)
  call mpi_comm_size(mpi_comm_world,p,err)
  call mpi_comm_rank(mpi_comm_world,id,err)
  
  root=0;tag=0
  if ( id==root )then
    msg=10
    call mpi_send(msg,1,mpi_int,1,tag,mpi_comm_world,err)
  else
    call mpi_recv(msg,1,mpi_int,id-1,mpi_any_tag,mpi_comm_world,mpi_status_ignore,err)
    write(*,*) id,'received from process:',id-1
    call mpi_send(msg,1,mpi_int,mod(id+1,p),tag,mpi_comm_world,err)
  endif 
  if ( id==root ) then
    call mpi_recv(msg,1,mpi_int,p-1,mpi_any_tag,mpi_comm_world,mpi_status_ignore,err)
    write(*,*)id,'received from process:',p-1
  end if
  call mpi_finalize(err)
end program ghj