fn main(){
    println!("test print");
    const maxsize: usize = 10;
    //3d array????
    let mut cube:[[[f64;maxsize];maxsize];maxsize = [[[0.0;maxsize];maxsize];maxsize]];
    //zero the cube
    for i in 0..maxsize{
        for j in 0..maxsize{
            for k in 0..maxsize{
                cube[i][j][k]=0.0;
            }
        }
    }

    let diffusion_coefficient: char = 0.175;
    let room_dimension: char = 5;
    let speed_of_gas_molecules: char = 250.0;
    let timestep: char = (room_dimension/speed_of_gas_molecules)/maxsize;
    let distance_between_blocks: char = room_dimension/maxsize;

    let DTerm: char = diffusion_coefficient * timestep / (distance_between_blocks*distance_between_blocks);



}