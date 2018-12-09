import math

def readFile(path):
    with open(path, "rt") as f:
        return f.read()

def get_true_pix_grid(grid):
    res = []
    for i in range(0, len(grid), 4):
        row = grid[i]
        line = []
        for j in range(0, len(row), 4):
            elem = row[j]
            line.append(elem)
        res.append(line)
    return res

def print_grid(grid):
    for line in grid:
        print(line)

def get_grid(contents):
    res = []
    for line in contents.splitlines():
        curr_line = []
        for num in line.split(" "):
            val = int(num)
            curr_line.append(val)
        res.append(curr_line)
    return res

def get_sv_grid(contents, rows, cols):
    res = [[0 for c in range(4*cols)] for r in range(4*rows)]
    res_og = [[0 for c in range(cols)] for r in range(rows)]
    ct = 0
    addrs = set()
    for line in contents.splitlines():
        line = line.strip()
        if not line.isdigit():
            pass #print(line)
        else:
            val = int(line)
            if val > 2000: val = 0
            i = (ct // 16)
            subpix = ct % 16
            row = i // cols
            col = i % cols
            dr = subpix // 4
            dc = subpix % 4
            res[4*row+dr][4*col+dc] = val
            if dr == dc == 0:
                res_og[row][col] = val
            addrs.add((4*row+dr, 4*col+dc))
            ct += 1
    #print(ct)
    #print(len(addrs))
    return res, res_og

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
    avg_of_sqrs = total_sum_of_squares / total_cells
    score = math.sqrt(avg_of_sqrs)
    print("total sum of differences: %d" % total_sum)
    print("total_sum of squares:     %d" % total_sum_of_squares)
    print("total number of cells:    %d" % total_cells)
    print("average of squares:       %f" % avg_of_sqrs)
    print("score:                    %f" % score) 
    print("real score:               %f" % (1-(score/255)))

def main():
    reference_path = "grids/interpolated_example.txt"
    output_path = "outputs/lower_bit.txt"
    is_sv = True
    rows = 16
    cols = 16
    reference_contents = readFile(reference_path)
    output_contents = readFile(output_path)
    reference_grid = get_grid(reference_contents)
    if is_sv:
        output_grid, output_og = get_sv_grid(output_contents, rows, cols)
    else:
        output_grid = get_grid(output_contents)
    #print(output_contents)
    #print_grid(output_grid)
    '''if get_true_pix_grid(reference_grid) == get_true_pix_grid(output_grid):
        print("fuck me up")
    else:
        print("oh no i fucked up")
        print_grid(get_true_pix_grid(reference_grid))
        print("\n\n\n")
        print_grid(get_true_pix_grid(output_grid))
    '''#print(len(output_contents.splitlines()))
    difference_grid = get_difference_grid(reference_grid, output_grid)
    #print("\n"*69)
    #print_grid(difference_grid)
    assess_difference_grid(difference_grid)

main()
