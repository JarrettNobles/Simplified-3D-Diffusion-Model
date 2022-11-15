const MAXSIZE : usize = 10;
fn main(){
    // obtained from https://docs.rs/multiarray/latest/multiarray/ and https://programming-idioms.org/idiom/27/create-a-3-dimensional-array/452/rust
    // mut variables from https://doc.rust-lang.org/std/keyword.mut.html
    let mut cube:[[[f64;MAXSIZE];MAXSIZE];MAXSIZE] = [[[0.0;MAXSIZE];MAXSIZE];MAXSIZE];
    let diffusion_coefficient: f64 = 0.175;
    let room_dimension: f64 = 5.0;
    let speed_of_gas_molecules: f64 = 250.0;
    let timestep: f64 = (room_dimension/speed_of_gas_molecules)as f64 /MAXSIZE as f64;
    let distance_between_blocks: f64 = room_dimension/MAXSIZE as f64;
    let dterm: f64 = diffusion_coefficient * timestep / (distance_between_blocks * distance_between_blocks);
    cube[0][0][0] = 1.0e21;
    //let mut pass = 0;
    let mut time = 0.0;
    let mut ratio = 0.0;

    //begin loop here
    while ratio < 0.99 {
        for i in 0..MAXSIZE as i64{
            for j in 0..MAXSIZE as i64{
                for k in 0..MAXSIZE as i64{
                    for l in 0..MAXSIZE as i64{
                        for m in 0..MAXSIZE as i64{
                            for n in 0..MAXSIZE as i64{
                                //begin if statement
                                if i == l && j == m && k == (n+1) ||
                                   i == l && j == m && k == (n-1) ||
                                   i == l && j == (m+1) && k == n ||
                                   i == l && j == (m-1) && k == n ||
                                   i == (l+1) && j == m && k == n ||
                                   i == (l-1) && j == m && k == n {
                                    let change = (cube[i as usize][j as usize][k as usize] - cube[l as usize][m as usize][n as usize]) as f64 * dterm;
                                    cube[i as usize][j as usize][k as usize] = cube[i as usize][j as usize][k as usize] - change;
                                    cube[i as usize][j as usize][k as usize] = cube[i as usize][j as usize][k as usize] + change;
                                }
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
        let mut minval = cube[0][0][0];

        //.max information obtained from https://doc.rust-lang.org/std/cmp/fn.max.html
        for i in 0..MAXSIZE as i64{
            for j in 0..MAXSIZE as i64{
                for k in 0..MAXSIZE as i64{
                    maxval = cube[i as usize][j as usize][k as usize].max(maxval);
                    minval = cube[i as usize][j as usize][k as usize].max(minval);
                    sumval = sumval + cube[i as usize][j as usize][k as usize];
                }
            }
        }//end for

        //print statements
        ratio = minval / maxval;
        //println!("{} time = {}" ,ratio,time);
        //println!("{} {}", time,cube[0][0][0]);
        //println!(" {}", cube[MAXSIZE-1][0][0]);
        //println!(" {}", cube[MAXSIZE-1][MAXSIZE-1][0]);
        //println!(" {}", cube[MAXSIZE-1][MAXSIZE-1][MAXSIZE-1]);
        //println!(" {}",sumval);
        println!("{:.3} \x09 {:.5e} \x09 {:.5e} \x09 {:.5e} \x09 {:.5e} \x09 {:.5e}",
            time,
            cube[0][0][0],
            cube[MAXSIZE-1][0][0],
            cube[MAXSIZE-1][MAXSIZE-1][0],
            cube[MAXSIZE-1][MAXSIZE-1][MAXSIZE-1], sumval);
    
    }//end while loop
    println!("Box equilibrated in {} seconds of simulation time. ", time);


}//end main