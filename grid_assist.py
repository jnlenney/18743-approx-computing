import interpolation, random

def writeFile(path, contents):
    with open(path, "wt") as f:
        f.write(contents)

def get_str_grid(grid):
    return [[str(elem) for elem in row] for row in grid]

def save_grid(grid, path):
    s_grid = get_str_grid(grid)
    lines = [" ".join(row) for row in s_grid]
    s = "\n".join(lines)
    writeFile(path, s)

def save_sv_grid(grid, path):
    s_grid = [["32'd"+str(elem) for elem in row] for row in grid]
    lines = [", ".join(row) for row in s_grid]
    s = "{\n" + ",\n".join(lines) + "\n}"
    writeFile(path, s)

def get_basic_gradient(num_rows, num_cols):
    # assume square
    grid = [[0 for j in range(num_cols)] for i in range(num_rows)]
    min_val = 0
    max_val = 255
    step = (max_val-min_val)/(2*num_rows-2)
    for r in range(num_rows):
        for c in range(num_cols):
            val = int((r+c)*step)
            grid[r][c] = val
    return grid

def get_random_gradient(num_rows, num_cols):
    return [[random.randint(0,255) for c in range(num_cols)] for r in range(num_rows)]


def main():
    num_rows = 16
    num_cols = 16
    zero_grid =  [[0 for c in range(num_cols)] for r in range(num_rows)]
    basic_r = get_basic_gradient(num_rows, num_cols)
    basic_g = zero_grid
    basic_b = zero_grid
    save_grid(basic_r, "grids/basic_grid_r.txt")
    save_grid(basic_g, "grids/basic_grid_g.txt")
    save_grid(basic_b, "grids/basic_grid_b.txt")
    #save_sv_grid(basic, "grids/sv_gradient.txt")
    terped_r = interpolation.interp_extern(basic_r)
    terped_g = interpolation.interp_extern(basic_g)
    terped_b = interpolation.interp_extern(basic_b)
    save_grid(terped_r, "grids/interpolated_example_r.txt")
    save_grid(terped_g, "grids/interpolated_example_g.txt")
    save_grid(terped_b, "grids/interpolated_example_b.txt")

    rand_r = get_random_gradient(num_rows, num_cols)
    rand_g = zero_grid
    rand_b = zero_grid
    save_grid(rand_r, "grids/random_grid_r.txt")
    save_grid(rand_g, "grids/random_grid_g.txt")
    save_grid(rand_b, "grids/random_grid_b.txt")

    terped_r = interpolation.interp_extern(rand_r)
    terped_g = interpolation.interp_extern(rand_g)
    terped_b = interpolation.interp_extern(rand_b)
    save_grid(terped_r, "grids/interpolated_random_r.txt")
    save_grid(terped_g, "grids/interpolated_random_g.txt")
    save_grid(terped_b, "grids/interpolated_random_b.txt")


main()

