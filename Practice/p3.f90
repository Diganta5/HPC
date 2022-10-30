program hjk
  implicit none
  integer::i,j,n
  real::mat(300,300),fgit,mat1(300,300),val,dif
  open(unit=1,file='random_numbers.dat')
  open(unit=2,file='output.dat',action='write')
  read(1,*) mat
  dif=1
  n=0
  do while(dif>0.001)
    dif=0
    !mat1=mat
    do i=2,299
        do j=2,299
           val=(mat(i-1,j)+mat(i+1,j)+mat(i,j-1)+mat(i,j+1))/4
           dif = dif + abs(mat(i,j)-val)
           mat(i,j)=val
        end do
    end do
    n=n+1
    write(*,*)'iterating',dif
  end do
  write(*,*)'The numbe of iteration ',n
  write(2,*)mat
end program hjk