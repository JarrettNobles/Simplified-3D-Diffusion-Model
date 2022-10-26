import time
maxsize = 10
cube = [[[0.0] * maxsize] * maxsize] * maxsize
cube[0][0][0] = 1.0e21
diffusion_coefficient = 0.175
room_dimension = 5
speed_of_gas_molecules = 250.0
timestep = (room_dimension / speed_of_gas_molecules) / maxsize
distance_between_blocks = room_dimension / maxsize
DTerm = diffusion_coefficient * timestep / (distance_between_blocks * distance_between_blocks)
time1 = 0.0
ratio = 0.0
start = time.time()


# main function
while ratio < 0.99:
    print(str(ratio))
    for i in range(0, maxsize):
        for j in range(0, maxsize):
            for k in range(0, maxsize):
                for l in range(0, maxsize):
                    for m in range(0, maxsize):
                        for n in range(0, maxsize):
                            if (((i == l) and (j == m) and (k == n + 1)) or
                                    ((i == l) and (j == m) and (k == n - 1)) or
                                    ((i == l) and (j == m + 1) and (k == n)) or
                                    ((i == l) and (j == m - 1) and (k == n)) or
                                    ((i == l + 1) and (j == m) and (k == n)) or
                                    ((i == l - 1) and (j == m) and (k == n))):
                                change = ((cube[i][j][k] - cube[l][m][n]) * DTerm)
                                cube[i][j][k] = cube[i][j][k] - change
                                cube[l][m][n] = cube[l][m][n] + change
    #time1 = time1 + timestep
    # print("TIME IS:" + str(time))
    sumval = 0.0
    maxval = cube[0][0][0]
    minval = cube[0][0][0]
    for a in range(0, maxsize):
        for b in range(0, maxsize):
            for c in range(0, maxsize):
                maxval = max(cube[a][b][c], maxval)
                minval = min(cube[a][b][c], minval)
                sumval += cube[a][b][c]
    # print("maxval is: " + str(maxval))
    # print("minval is: " + str(minval))
    ratio = minval / maxval
    print(str(ratio))
    temp = time.time()
    time1 = temp - start
    print(str(time1) + "\t" + str(cube[0][0][0]) + "\t" + str(cube[maxsize - 1][0][0]) + "\t" +
          str(cube[maxsize - 1][maxsize - 1][0]) + "\t" + str(cube[maxsize - 1][maxsize - 1][maxsize - 1]) + "\t" + str(
        sumval))
print("Box equilibrated in " + str(time1) + " seconds of simulated of time. ")


