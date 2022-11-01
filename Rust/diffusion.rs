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

    char diffusion_coefficient = 0.175;
    char room_dimension = 5;
    char speed_of_gas_molecules = 250.0;
    char timestep = (room_dimension/speed_of_gas_molecules)/maxsize;
    char distance_between_blocks = room_dimension/maxsize;

    char DTerm = diffusion_coefficient * timestep / (distance_between_blocks*distance_between_blocks);



}