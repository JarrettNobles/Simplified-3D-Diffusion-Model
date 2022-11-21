#!/usr2/local/julia-1.8.2/bin/julia

#partition function is seperate
function userIn()
  print("Would you like to add a partition for the size of the room? (y/n): ")
  input = readline()
  if (input == "y")
    return 1
  else
    return 0
  end
end

function main()
  #user input for dimension size
  print("What are the dimensions you would like the room to be: ")
  dim = readline()
  dim = parse(Int64, dim)
  


  #declare the cube
  cube = zeros(dim,dim,dim)

  #add the partition to the cube, https://www.geeksforgeeks.org/getting-floor-value-of-x-in-julia-floor-method/ floor function obtained from this link
  #call the userIn function
  part = userIn()
  if (part == 1)
    i = ceil( Int64, dim * 0.5)  
    j = ceil(Int64, dim * 0.25) 
    #for loop
    for x = j:dim
      for k = 1:dim
        cube[i,x,k] = -1.0
      end
    end
  end

  #declare the variables
  ratio = 0.0
  speed_of_gas_molecules = 250.0
  diffusion_coefficient = 0.175
  room_dimension = 5
  timestep = (room_dimension /speed_of_gas_molecules) / dim
  distance_between_blocks = room_dimension / dim
  dterm = diffusion_coefficient * timestep / (distance_between_blocks * distance_between_blocks)
  time = 0
  #zero the cube
  cube[1,1,1] = 1.0e21

  #begin the giant loop
  while ratio < 0.99
    for i in 1:dim
      for j in 1:dim
        for k in 1:dim
          for l in 1:dim
            for m in 1:dim
              for n in 1:dim
                if i == l && j == m && k == n + 1 ||
                  i == l && j == m && k == n - 1 ||
                  i == l && j == m + 1 && k == n ||
                  i == l && j == m - 1 && k == n ||
                  i == l + 1 && j == m && k == n ||
                  i == l - 1 && j == m && k == n 
                    if(cube[i,j,k] != -1 && cube[l,m,n] != -1)
                      #https://discourse.julialang.org/t/how-to-correctly-define-and-use-global-variables-in-the-module-in-julia/65720 for global variables
                      change = (cube[i,j,k] - cube[l,m,n]) * dterm
                      cube[i,j,k] = cube[i,j,k] - change
                      cube[l,m,n] = cube[l,m,n] + change
                    end
                    #end if
                  end
                  #end if
                end
                #end for
              end
              #end for
            end
            #end for
          end
          #end for
        end
        #end for
      end
      #end for
    
    #time functions
    time = time + timestep
    maxval = cube[1,1,1]
    minval = cube[1,1,1]
    sumval = 0.0
    
    #for loop begin
    for i in 1:dim
      for j in 1:dim
        for k in 1:dim
          if (cube[i,j,k] != -1)
            maxval = max(cube[i,j,k], maxval)
            minval = min(cube[i,j,k], minval)
            sumval = sumval + cube[i,j,k]
          end
          #end if
        end
        #end for
      end
      #end for
    end
    #end for
    
    ratio = minval / maxval
    
    #print the values
    println(ratio)
    
  end #end giant loop

  println("The box equilibrated in $time seconds of simulation time.")
end # end main function

main() # call main