!Jarrett Nobles, CSC330
program diffusion


   maxsize = 10.0
  !USE cube_mem
  !partition integer here
  !integers for the for loops for cubes
  integer  :: i,j,k,l,m,n
  integer :: memStats 
  
  diffusion_coefficient = 0.175
  room_dimension = 5.0
  speed_of_gas_molecules = 250.0
  timestep = (room_dimension / speed_of_gas_molecules) / maxsize 
  DTerm = diffusion_coefficient * timestep / (distance_between_blocks*distance_between_blocks)
  cube(0,0,0) = 1.0e21

  do while(ratio <= 0.99)
    do i = 1, maxsize-1
      do j = 1, maxsize-1
        do k = 1, maxsize-1
         do l = 1, maxsize-1
          do m = 1, maxsize-1
            do n = 1, maxsize-1
              if (    ( ( i == l )   && ( j == m )   && ( k == n+1) ) ||  
                                    ( ( i == l )   && ( j == m )   && ( k == n-1) ) ||  
                                    ( ( i == l )   && ( j == m+1 ) && ( k == n)   ) ||  
                                    ( ( i == l )   && ( j == m-1 ) && ( k == n)   ) ||  
                                    ( ( i == l+1 ) && ( j == m )   && ( k == n)   ) ||  
                                    ( ( i == l-1 ) && ( j == m )   && ( k == n)   ) )
                THEN change = (cube(i)(j)(k) - cube(l)(m)(n)) * DTerm
                                cube(i)(j)(k) = cube(i)(j)(k) - change                                
                                cube(l)(m)(n) = cube(l)(m)(n) + change
              end if
            end do
          end do
        end do
      end do
    end do

  time = time+timestep
  sumval = 0
  maxval = cube(0,0,0)
  minval = cube(0,0,0)
  do i = 1, maxsize
    do j = 1, maxsize
      do k = 1, maxsize
        maxval = DMAX1(cube(0,0,0), maxval)
        minval = DMIN1(cube(0,0,0)minval)
        sumval += cube(i,j,k)
      end do
    end do
  end do

  ratio = minval/maxval
  print*,  'time + " " + cube(0,0,0)'
  print*, '        " " + cube(maxsize-1,0,0)'
  print*, '        " " + cube(maxsize-1,maxsize-1,0)' 
  print*, '       " " + cube(maxsize-1,maxsize-1,maxsize-1)'
  end do
print*, '"Box equilibrated in " + time + " seconds of simulated time." '






  
  