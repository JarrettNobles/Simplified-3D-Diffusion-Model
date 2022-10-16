#include <stdio.h>
#include <iostream>
#include <cmath>
#include <algorithm>

//main method
int main(){
    //final variable for the cube
    const int maxsize = 10;
    //declare the cube
    double cube[maxsize][maxsize][maxsize];
    
    //zero the cube
    for(int i =0; i<maxsize;i++)
    {
        for(int j=0;j<maxsize;j++)
        {
            for(int k=0;k<maxsize;k++)
            {
                cube[i][j][k]=0.0;
            }
        }
    }

    double diffusion_coefficient = 0.175;
    double room_dimension = 5;
    double speed_of_gas_molecules = 250.0;
    double timestep = (room_dimension/speed_of_gas_molecules)/maxsize;
    double distance_between_blocks = room_dimension/maxsize;

    double DTerm = diffusion_coefficient * timestep / (distance_between_blocks*distance_between_blocks);

    //initializing the first cell
    cube[0][0][0]=1.0e21;
    int pass = 0;
    //time keeps up with accumulated system time
    double time = 0.0;
    double ratio = 0.0;

    //errors here
    do {
            for (int i=0; i<maxsize; i++) { 
                for (int j=0; j<maxsize; j++) { 
                    for (int k=0; k<maxsize; k++) { 
                        for (int l=0; l<maxsize; l++) { 
                            for (int m=0; m<maxsize; m++) { 
                                for (int n=0; n<maxsize; n++) { 

                                    if (    ( ( i == l )   && ( j == m )   && ( k == n+1) ) ||  
                                            ( ( i == l )   && ( j == m )   && ( k == n-1) ) ||  
                                            ( ( i == l )   && ( j == m+1 ) && ( k == n)   ) ||  
                                            ( ( i == l )   && ( j == m-1 ) && ( k == n)   ) ||  
                                            ( ( i == l+1 ) && ( j == m )   && ( k == n)   ) ||  
                                            ( ( i == l-1 ) && ( j == m )   && ( k == n)   ) ) {

                                        double change = (cube[i][j][k] - cube[l][m][n]) * DTerm;
                                        cube[i][j][k] = cube[i][j][k] - change;                                
                                        cube[l][m][n] = cube[l][m][n] + change;                                
                                    }          
                                }
                            }
                        }             
                    }
                }
            }

            time = time + timestep;
        double sumval = 0.0;
        double maxval = cube[0][0][0]; 
        double minval = cube[0][0][0];
        for (int i=0; i<maxsize; i++) { 
            for (int j=0; j<maxsize; j++) { 
                for (int k=0; k<maxsize; k++) { 
                    maxval = std::max(cube[i][j][k],maxval);
                    minval = std::min(cube[i][j][k],minval);
                    sumval += cube[i][j][k];
                }
            }
        }
        std::cout<<time + " " + cube[0][0][0];
        std::cout<< " " + cube[maxsize-1][0][0];
        std::cout<<" " + cube[maxsize-1][maxsize-1][0];
        std::cout<<" " + cube[maxsize-1][maxsize-1][maxsize-1];
        std::cout<< " " + sumval + "\n";

    }while(ratio < 0.99);

    std::cout<<"Box equilibrated in " + time + " seconds of simulated time.";
    







}