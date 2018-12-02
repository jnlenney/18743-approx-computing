import math

def readFile(path):
    with open(path, "rt") as f:
        return f.read()

def get_grid(contents):
    res = []
    for line in contents.splitlines():
        curr_line = []
        for num in line.split(" "):
            val = int(num)
            curr_line.append(val)
        res.append(curr_line)
    return res

def get_difference_grid(grid0, grid1):
    res = []
    for i in range(len(grid0)):
        line = []
        for j in range(len(grid0[0])):
            dif = grid0[i][j] - grid1[i][j]
            absdif = abs(dif)
            line.append(absdif)
        res.append(line)
    return res

def assess_difference_grid(dif_grid):
    total_sum = 0
    total_sum_of_squares = 0
    total_cells = 0
    for row in dif_grid:
        for elem in row:
            total_sum += elem
            total_sum_of_squares += elem**2
            total_cells += 1
    sqrt_of_sum = math.sqrt(total_sum_of_squares)
    score = sqrt_of_sum / total_cells
    print("total sum of differences: %d" % total_sum)
    print("total_sum of squares:     %d" % total_sum_of_squares)
    print("sqrt of sun of squares:   %0.6f" % sqrt_of_sum)
    print("total number of cells:    %d" % total_cells)
    print("score:                    %0.6f" % score) 

def main():
    reference_path = "grids/interpolated_example.txt"
    output_path = "grids/interpolated_random.txt"
    reference_contents = readFile(reference_path)
    output_contents = readFile(output_path)
    print(repr(output_contents))
    reference_grid = get_grid(reference_contents)
    output_grid = get_grid(output_contents)
    difference_grid = get_difference_grid(reference_grid, output_grid)
    assess_difference_grid(difference_grid)

main()