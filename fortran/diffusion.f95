!Jarrett Nobles, CSC330
program diffusion

SUBROUTINE fill_Cube
  !USE cube_mem
  !partition integer here
  !integers for the for loops for cubes
  integer  :: i,j,k,l,m,n
  integer :: memStats 
  
  diffusion_coefficient = 0.175
  room_dimension = 5.0
  speed_of_gas_molecules = 250.0
  timestep = (room_dimension / speed_of_gas_molecules) / 
  
  