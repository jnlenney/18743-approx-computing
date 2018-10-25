def readFile(path):
    with open(path, "rt") as f:
        return f.read()

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

def main():
    num_rows = 16
    num_cols = 16
    basic = get_basic_gradient(num_rows, num_cols)
    save_grid(basic, "grids/basic_grid.txt")
    save_sv_grid(basic, "grids/sv_gradient.txt")


main()

