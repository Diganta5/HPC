!  check out the algorithm at 
!  https://projects.raspberrypi.org/en/projects/octapi-calculating-pi/6

program pi_dartmethod 
 implicit none   ! declare all variables explicitly in the program
 include 'mpif.h'  ! define MPI functions and constants 

 integer, parameter ::  darts=50000, rounds=10000
 real(kind=8), parameter ::  PI25DT=3.141592653589793238462643d0   ! PI25DT value is fixed throughout the program and it cannot be changed. 
 integer :: i 
 real(kind=8) :: seednum, homepi, pi, avepi, pisum 

 integer ::  taskid, numtasks, ierr    ! taskid = process rank ; numtasks = total no of processes


 call MPI_INIT( ierr )       ! MPI initialization
 call MPI_COMM_RANK( MPI_COMM_WORLD, taskid, ierr ) ! MPI call assigns rank to all processes and stores it in taskid
 call MPI_COMM_SIZE( MPI_COMM_WORLD, numtasks, ierr ) ! MPI call gets the total number of processes and stores it in numtasks

 avepi = 0

 do i = 1, ROUNDS

   call dboard(darts, homepi)           ! call subroutine dboard 

   call MPI_REDUCE(homepi, pisum, 1, MPI_DOUBLE_PRECISION, &
     &                   MPI_SUM, 0, MPI_COMM_WORLD, ierr ) ! the process with rank 0 holds the final value in 'pisum' 

   if (taskid .eq. 0) then ! since process with rank 0 has the value, do this only for this process
! the following two lines get the average value of pi 

     pi = pisum/dble(numtasks)   ! dble is a function that returns the double precision real number 
     avepi = ((avepi*(i-1)) + pi) / dble(i) 
!     write(*,*) '  After ',DARTS*i, 'throws, average value of pi = ', avepi,'error = ',abs(PI25DT-avepi)
   endif
 enddo 

! it computes the error which is diff between known value and the computed value 
 if (taskid .eq. 0) then
   write(*,*) '  After ',DARTS*i, 'throws, average value of pi = ', avepi,'error = ',abs(PI25DT-avepi)
 endif

 call MPI_FINALIZE(ierr)   ! exit MPI env 

end program 


subroutine dboard(darts, pi) 
  implicit none      ! compulsory also in subroutine 
  integer ::  darts, score, n
  real(kind=8) :: r, x_coord, x_sqr, y_coord, y_sqr, pi

  score = 0    ! initialize the score 

! here, the basic idea is generate point on a XY plane and check whether
! it falls within a circule of radius 1, i. e. x^2+y^2 <=1 
! read the details in the above web-link. 

  do n = 1, darts
!     generate random numbers for x and y coordinates
     call random_number(r)       ! it generates a random number for x-ordinate in the range [0,1) 
! random_number is a subroutine provided by the gfortran compiler 
     x_coord = (2.d0 * r) - 1.d0 ! shift the range to [-1,1) 
     x_sqr = x_coord * x_coord   ! calculate x^2

     call random_number(r)   ! similarly do for y-ordinate 
     y_coord = (2.d0 * r) - 1.d0  ! shift the range to [-1,1) 
     y_sqr = y_coord * y_coord  ! calculate y^2 

     if ((x_sqr + y_sqr) .le. 1.d0) then  !checking the whether the (x,y) is inside the circle
! if yes, increase count by 1 
       score = score + 1
     endif

  enddo 

  pi = 4.d0 * score / dble(darts)  ! this formula gives the value of pi 

end subroutine dboard 
