with ada.text_io, ada.integer_text_io, ada.float_text_io;
use ada.text_io, ada.integer_text_io, ada.float_text_io;

procedure diffusion is
  type Three_Dimensional_Float_Array is array (Integer range <>, Integer range <>, Integer range <>) of Float;
  dim : Integer := 5;
  room_dimension : float := 5.0;
  diffusion_coefficent : float := 5.0;
  speed_of_gas_molecules : float := 250.0;
  distance_between_blocks : float := room_dimension / float(dimension);
  timestep : float := room_dimension / speed_of_gas_molecules / float(dimension);
  DTerm : float := diffusion_coefficient * timestep / float (distance_between_blocks*distance_between_blocks);
  pass : Integer :=0;
  time : float := 0.0;
  ratio : float := 0.0;
  --https://programming-idioms.org/idiom/27/create-a-3-dimensional-array/1521/ada this is where i obtained info about making this cube and array
  cube : Three_Dimensional_Float_Array(1.. dim, 1.. dim, 1.. dim) := (others => (others => (others => 0.0)));
  sumval : float := 0.0;
  maxval : float := 0.0;
  minval : float := 0.0;
  change : float := 0.0;
  begin :
    -- initialize the first cell
    cube(1,1,1) := 1.0e21;
    --begin loop
    while ratio < 0.99 loop
      for i in 1.. dim loop
        for j in 1.. dim loop
          for k in 1.. dim loop
            for l in 1.. dim loop
              for m in 1.. dim loop
                for n in 1.. dim loop
                    if (i = l and j = m and k = (n+1)) or
                       (i = l and j = m and k = (n-1)) or
                       (i = l and j = (m+1) and k = n) or
                       (i = l and j = (m-1) and k = n) or
                       (i = (l+1) and j = m and k = n) or
                       (i = (l-1) and j = m and k = n) then
                         change := (cube(i,j,k) - cube(l,m,n)) * DTerm;
                          cube(i,j,k) := cube(i,j,k) - change;
                          cube(l,m,n) := cube(l,m,n) + change;
                    end if;
                end loop;
              end loop;
            end loop;
          end loop;
        end loop;
      end loop;
      --end of giant loop here
  time := time + timestep;
  maxval := cube(1,1,1);
  minval := cube(1,1,1);
  for i in 1.. dim loop
    for j in 1.. dim loop
      for k in 1.. dim loop
         maxval := float'Max(cube(i,j,k), maxval);
         minval := float'Min(cube(i,j,k), minval);
         sumval := sumval + cube(i,j,k);
      end loop;
    end loop;
  end loop;
  ratio := minval/maxval;
  put(ratio);
  end loop;
  end;
end diffusion;
       
    
                       

      