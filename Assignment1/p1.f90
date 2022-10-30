program test
    implicit none
    integer :: i1,i2,m,n
    real:: r1,r2,r3,r4,r5,r6
    character(len=10)::s1,s2,s3,s4
    
    ! reading the input file
    open(unit=1,file='input4.pdb',action='read')
    open(unit=2, file='output4.pdb',action="write")
    ! For first line
    ! CRYST1    0.000    0.000    0.000  90.00  90.00  90.00 P 1           1
    read(1,*) s1,r1,r2,r3,r4,r5,r6,s2,i1,i2
    write(2, fmt="(a6,4x,f5.3,4x,f5.3,4x,f5.3,2x,f5.2,2x,f5.2,2x,f5.2,1x,a1,1x,i1,11x,i1)") s1,r1,r2,r3,r4,r5,r6,s2,i1,i2

    !for 878 sections
    do m=1,878
       ! for first 13 lines in each section
       do n=1,13
          ! ATOM      1  O       X   1      -0.138   1.391   0.001  0.00  0.00           O
          read(1,*) s1,i1,s2,s3,i2,r1,r2,r3,r4,r5,s4
          write(2,fmt="(a4,5x,i2,2x,a1,7x,a1,3x,i1,6x,f6.3,2x,f6.3,2x,f6.3,2x,f4.2,2x,f4.2,11x,a1)") s1,i1,s2,s3,i2,r1,r2,r3, &
          r4,r5,s4
       enddo
       ! for last line in each section
       read(1,*) s1
       write(2,fmt="(a3)") s1
    enddo
    

    

    

end program test
