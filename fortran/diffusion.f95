!Jarrett Nobles, CSC330
PROGRAM diffusion
IMPLICIT NONE
!partition integer here
!integers for the for loops for cubes
INTEGER  :: i, j, k, l, m, n, a, b, c, maxsize, tempa, tempb, zerob, zeroc
REAL :: diffusion_coefficient, room_dimension, speed_of_gas_molecules, timestep, distance_between_blocks, DTerm
CHARACTER :: flag
REAL :: time, ratio, change, sumval, minval, maxval
!  Declaration of cube
REAL (kind = 8), dimension(:,:,:), allocatable :: cube
!real, dimension(3,3,3), allocatable
!cube = 0

!maxsize = 10.0
write(*,*) 'What is the dimesion of the room :'
read(*,*) maxsize
maxsize = 10
allocate(cube(0:maxsize-1,0:maxsize-1,0:maxsize-1))
cube = 0

!ask user for partition 
write(*,*) "Do you want to add a partition (y/n): "
read(*,*) flag
IF(flag == 'y') THEN
  tempa = ceiling(maxsize * .5) - 1.0
  tempb = ceiling(maxsize * .25) - 1.0
  DO zerob = int(tempb), maxsize - 1
    DO zeroc = 0, maxsize - 1
      cube(zeroc, zerob, tempa) = -1.0  !Setting the wall of the partition
    END DO
  END DO
END IF



!time functions
time = 0.0
ratio = 0.0
diffusion_coefficient = 0.175
room_dimension = 5.0
speed_of_gas_molecules = 250.0
timestep = (room_dimension / speed_of_gas_molecules) / maxsize 
distance_between_blocks = room_dimension / maxsize
DTerm = diffusion_coefficient * timestep / (distance_between_blocks*distance_between_blocks)
!initialize the first cell
cube(0,0,0) = 1.0e21




!REFERENCE: https://www.tutorialspoint.com/fortran/nested_if_construct.htm AND https://web.ics.purdue.edu/~cs154/lectures/lecture6.htm
DO while(ratio < 0.99)
  write(*,*) ratio
  DO i = 0, maxsize-1
    DO j = 0, maxsize-1
      DO k = 0, maxsize-1
        DO l = 0, maxsize-1
          DO m = 0, maxsize-1
            DO n = 0, maxsize-1
              IF (( i == l .and. j == m .and. k == (n+1)) .or. &
                   ( i == l .and. j == m .and. k == (n-1)) .or. &
                   ( i == l .and. j == (m+1) .and. k == n) .or. & 
                   ( i == l .and. j == (m-1 ) .and. k == n) .or. &  
                   ( i == (l+1) .and. j == m .and. k == n) .or. &  
                   ( i == (l-1) .and. j == m  .and.  k == n))THEN
                      change =  (cube(i,j,k) - cube(l,m,n)) * DTerm
                      cube(i,j,k) = cube(i,j,k) - change                                
                      cube(l,m,n) = cube(l,m,n) + change
              END IF
            END DO
          END DO
        END DO
      END DO
    END DO
  END DO
  time = time+timestep
  sumval = 0
  maxval = cube(0,0,0)
  minval = cube(0,0,0)
  DO a = 0, maxsize-1
    DO b = 0, maxsize-1
      DO c = 0, maxsize-1
        maxval = max(cube(a,b,c), maxval)
        minval = min(cube(a,b,c), minval)
        

        sumval = sumval + cube(a,b,c)
      END DO
    END DO
  END DO

  ratio = minval/maxval
  PRINT*, ratio, "time = ", time
  PRINT*, time , " " , cube(0,0,0)
  PRINT*, " " , cube(maxsize-1,0,0)
  PRINT*, " " , cube(maxsize-1,maxsize-1,0) 
  PRINT*, " " , cube(maxsize-1,maxsize-1,maxsize-1)
END DO
print*, "Box equilibrated in " , time , " seconds of simulated time." 

END PROGRAM diffusion
