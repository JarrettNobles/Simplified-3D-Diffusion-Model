const maxsize : usize = 10;
fn main(){
    println!("test print");
    //3d array????
    // obtained from https://docs.rs/multiarray/latest/multiarray/ and https://programming-idioms.org/idiom/27/create-a-3-dimensional-array/452/rust
    // mut variables from https://doc.rust-lang.org/std/keyword.mut.html
    let mut cube:[[[f64;maxsize];maxsize];maxsize = [[[0.0;maxsize];maxsize];maxsize]];
    let diffusion_coefficient: char = 0.175;
    let room_dimension: char = 5;
    let speed_of_gas_molecules: char = 250.0;
    let timestep: char = (room_dimension/speed_of_gas_molecules)/maxsize;
    let distance_between_blocks: char = room_dimension/maxsize;
    let DTerm: char = diffusion_coefficient * timestep / (distance_between_blocks*distance_between_blocks);
    cube[0][0][0] = 1.0e21;
    let pass = 0;
    let mut time = 0.0;
    let mut ratio = 0.0;
    
    //BEGIN GIANT LOOP HERE
    while ratio < 0.99 {
      for i in 0..maxsize {
        for j in 0..maxsize {
          for k in 0..maxsize {
            for l in 0..maxsize {
              for m in 0..maxsize {
                for n in 0..maxsize {
                  if i == l && j == m && k == (n+1) ||
                     i == l && j == m && k == (n-1) ||
                     i == l && j == (m+1) && k == n ||
                     i == l && j == (m-1) && k == n ||
                     i == (l+1) && j == m && k == n ||
                     i == (l-1) && j == m && k == n ||
                       let change = (cube[i][j][k] - cube[l][m][n]) as f64 * DTerm;
                       cube[i][j][k] = cube[i][j][k] - change;
                       cube[i][j][k] = cube[i][j][k] + change;
                }
              }
            }
          }
        }
      }
       //time functions
    time = time + timestep;
    //mut variables from https://doc.rust-lang.org/std/keyword.mut.html
    let mut sumval = 0.0;
    let mut maxval = cube[0][0][0];
    
    //begin loop
    //.max information obtained from https://doc.rust-lang.org/std/cmp/fn.max.html
    for i in 0..maxsize {
      for j in 0..maxsize {
        for k in 0..maxsize {
          maxval = (cube[i][j][k]).max(maxval);
          minval = (cube[i][j][k]).max(minval);
          sumval = sumval + cube[i][j][k];
        }
      }
    }
    //print the numbers here
    ratio = minval/maxval;
  }
  //end giant loop
  //print time info here
   
    
    
    
    
    


  
}
//end of main