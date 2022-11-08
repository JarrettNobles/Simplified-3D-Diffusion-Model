!Jarrett Nobles, CSC330
program diffusion

SUBROUTINE fill_Cube
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
    do i = 1, maxsize
      do j = 1, maxsize
        do k = 1, maxsize
          

  
  