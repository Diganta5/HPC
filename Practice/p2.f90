program fgh
  implicit none
  include 'mpif.h'
  integer::err,p,id,msg,root,tag
  call mpi_init(err)
  call mpi_comm_size(mpi_comm_world,p,err)
  call mpi_comm_rank(mpi_comm_world,id,err)
  tag=id
  if ( id==0 ) then
    msg=11
    call mpi_send(msg,1,mpi_int,1,tag,mpi_comm_world,err)
  else
    call mpi_recv(msg,1,mpi_int,id-1,tag-1,mpi_comm_world,mpi_status_ignore,err)
    write(*,*) id,'received from process:',id-1
    call mpi_send(msg,1,mpi_int,id+1,tag+1,mpi_comm_world,err)
  end if
  call mpi_barrier(mpi_comm_world,err)
  
  if ( id==root ) then
    call mpi_recv(msg,1,mpi_int,p-1,p-1,mpi_comm_world,mpi_status_ignore,err)
    write(*,*)id,'received from process:',p-1
  end if
  call mpi_finalize(err)
end program fgh