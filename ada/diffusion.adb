with ada.text_io, ada.integer_text_io, ada.long_float_text_io;
use ada.text_io, ada.integer_text_io, ada.long_float_text_io;
with Ada.Text_IO,Ada.Float_Text_Io,Ada.Command_Line,Ada.Characters.Latin_1;
use Ada.Text_IO,Ada.Float_Text_Io,Ada.Command_Line,Ada.Characters.Latin_1;

procedure diffusion is
    type Three_Dimensional_Float_Array is array (Integer range <>, Integer range <>, Integer range <>) of Long_Float;
    dim : Integer;
    flag : Character;

    
    
    time : Long_Float := 0.0;
    ratio : Long_Float := 0.0;
    --https://programming-idioms.org/idiom/27/create-a-3-dimensional-array/1521/ada this is where i obtained info about making this cube and array
    
    begin
         -- ask user for input for size of the room
         put("What is the dimension of the room: ");
            get(dim);
            new_line;
            
            --ask user for partition
            put("Do you want to add a partition (y/n): ");
            get(flag);
    --begin the giant loop and declaring variables here
        declare
        room_dimension : Long_Float := 5.0;
        diffusion_coefficent : Long_Float := 0.175;
        speed_of_gas_molecules : Long_Float := 250.0;
        distance_between_blocks : Long_Float := room_dimension / Long_Float(dim);
        timestep : Long_Float := (room_dimension / speed_of_gas_molecules) / Long_Float(dim);
        DTerm : Long_Float := diffusion_coefficent * timestep / Long_Float (distance_between_blocks*distance_between_blocks);
            cube : Three_Dimensional_Float_Array(1.. dim, 1.. dim, 1.. dim) := (others => (others => (others => 0.0)));
            sumval : Long_Float := 0.0;
            maxval : Long_Float := 0.0;
            minval : Long_Float := 0.0;
            change : Long_Float := 0.0;
            i : Integer := 0;
            height : Integer := 0;
            begin
            if flag = 'y' then
              i := Integer(Long_Float'Ceiling(Long_Float(dim) * 0.5));
              height := Integer(Long_Float'Ceiling(Long_Float(dim) * 0.25));
                for j in height..dim loop
                  for k in 1..dim loop
                    cube(i,j,k) := -1.0;
                  end loop;
                end loop;
              end if;
                -- initialize the first cell
                cube(1,1,1) := 1.0e21;
                --begin loop
                while ratio < 0.99 loop
                    for i in 1..dim loop
                        for j in 1..dim loop
                            for k in 1..dim loop
                                for l in 1..dim loop
                                for m in 1..dim loop
                                    for n in 1..dim loop
                                        if ((i = l and j = m and k = (n+1)) or
                                        (i = l and j = m and k = (n-1)) or
                                        (i = l and j = (m+1) and k = n) or
                                        (i = l and j = (m-1) and k = n) or
                                        (i = (l+1) and j = m and k = n) or
                                        (i = (l-1) and j = m and k = n)) and
                                        (cube(i, j, k) /= -1.0 and cube(l, m, n) /= -1.0) then
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
                --time functions begin here
                time := time + timestep;
                maxval := cube(1,1,1);
                minval := cube(1,1,1);
                for i in 1.. dim loop
                    for j in 1.. dim loop
                        for k in 1.. dim loop
                            if(cube(i, j, k) /= -1.0) then
                                maxval := Long_Float'max(cube(i,j,k), maxval);
                                minval := Long_Float'min(cube(i,j,k), minval);
                                sumval := sumval + cube(i,j,k);
                            end if;
                        end loop;
                    end loop;
                end loop;
                ratio := minval/maxval;
                put(ratio,0,10);
                put("    ");
                put(time,0,5,0);
                New_Line;
                end loop;
            end;
            put("Box equilibrated in ");
            put(Long_Float'image(time));
            put("seconds of simulation time.");

end diffusion;

