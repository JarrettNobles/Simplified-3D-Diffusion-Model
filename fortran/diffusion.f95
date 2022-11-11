!Jarrett Nobles, CSC330
PROGRAM diffusion



!USE cube_mem
!partition integer here
!integers for the for loops for cubes
!INTEGER  :: i, j, k, l, m, n
REAL :: diffusion_coefficient, room_dimension, speed_of_gas_molecules, timestep, distance_between_blocks, DTerm
REAL :: time, ratio, change, sumval, maxsize, minval
maxsize = 10.0
diffusion_coefficient = 0.175
room_dimension = 5.0
speed_of_gas_molecules = 250.0
timestep = (room_dimension / speed_of_gas_molecules) / maxsize 
DTerm = diffusion_coefficient * timestep / (distance_between_blocks*distance_between_blocks)
cube(0,0,0) = 1.0e21

DO while(ratio <= 0.99)
  DO i = 1, maxsize-1
    DO j = 1, maxsize-1
      DO k = 1, maxsize-1
        DO l = 1, maxsize-1
          DO m = 1, maxsize-1
            DO n = 1, maxsize-1
              IF (    ( ( i == l )   && ( j == m )   && ( k == n+1) ) ||  
                                    ( ( i == l )   && ( j == m )   && ( k == n-1) ) ||  
                                    ( ( i == l )   && ( j == m+1 ) && ( k == n)   ) ||  
                                    ( ( i == l )   && ( j == m-1 ) && ( k == n)   ) ||  
                                    ( ( i == l+1 ) && ( j == m )   && ( k == n)   ) ||  
                                    ( ( i == l-1 ) && ( j == m )   && ( k == n)   ) )
                THEN change = (cube(i)(j)(k) - cube(l)(m)(n)) * DTerm
                                cube(i)(j)(k) = cube(i)(j)(k) - change                                
                                cube(l)(m)(n) = cube(l)(m)(n) + change
              !END IF
            END DO
          END DO
        END DO
      END DO
    END DO

  time = time+timestep
  sumval = 0
  maxval = cube(0,0,0)
  minval = cube(0,0,0)
  DO i = 1, maxsize
    DO j = 1, maxsize
      DO k = 1, maxsize
        maxval = max(cube(0,0,0), maxval)
        minval = min(cube(0,0,0)minval)
        sumval += cube(i,j,k)
      END DO
    END DO
  END DO

  ratio = minval/maxval
  print*,  'time + " " + cube(0,0,0)'
  print*, '        " " + cube(maxsize-1,0,0)'
  print*, '        " " + cube(maxsize-1,maxsize-1,0)' 
  print*, '       " " + cube(maxsize-1,maxsize-1,maxsize-1)'
  END DO
print*, '"Box equilibrated in " + time + " seconds of simulated time." '






  
  