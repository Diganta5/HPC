! program to read a given xyz file and store the atom labels and coordinates in array. 
! ./executable input_xyz_file_name  



program readxyz
 implicit none

 integer :: natoms,atom,i,j,numbond
 character(len=200) :: file1 
 character(len=2),allocatable :: atm(:)
 real(kind=8),allocatable :: coor(:,:) 
 real(kind=8)::rad1,rad2,dist,cord1(3),cord2(3)
  

 call getarg(1,file1)
 open(unit=1,file=file1,action='read')

! count number of lines in the given xyz file 
 natoms=0
 read(1,*)
 read(1,*)
 do 
   read(1,*,end=100) 
   natoms=natoms+1
 enddo
 100 continue 
 rewind(1) 

! allocate the coor and atm arrays 
 allocate(coor(natoms,3))
 allocate(atm(natoms))

! read the xyz file and storage atm labels and coordinates 
 read(1,*)
 read(1,*)
 do atom=1,natoms 
   read(1,*) atm(atom),coor(atom,:) 
 enddo

 !count the number of bonds and measure their length
 numbond =0
 do i=1,natoms
  call vander_wall(atm(i),rad1)
  do j=i+1,natoms
    call vander_wall(atm(j),rad2)
    cord1 = coor(i,:)
    cord2 = coor(j,:)
    call distance(cord1,cord2,dist)
    if ( dist<0.6*(rad1+rad2) ) then
      numbond=numbond+1
      write(*,*)"{",i,",",j,"}"
    end if

  end do
 enddo
 write(*,*)"Total number of bonds is:",numbond



contains

!Define the vanderwall radius
subroutine vander_wall(j,rad)
character,intent(in)::j

real(kind=8),intent(out)::rad
if ( j=='C') then
   rad = 1.7

elseif ( j=='H') then
  rad = 1.0

elseif (j=='O') then
  rad =1.3
end if

end subroutine vander_wall


! Define the distance between the atoms
subroutine distance(coord1,coord2,dist)
  real(kind=8),intent(in)::coord1(3),coord2(3)
  real(kind=8),intent(out)::dist
  dist = sqrt((coord1(1)-coord2(1))**2+(coord1(2)-coord2(2))**2+(coord1(3)-coord2(3))**2)
 

end subroutine distance
end program readxyz