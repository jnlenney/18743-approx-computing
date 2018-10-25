# events-example0.py
# Barebones timer, mouse, and keyboard events
# from 15112 class website
# written by david kosbie, nikolai lenney

from tkinter import *

####################################
# customize these functions
####################################

def readFile(path):
    with open(path, "rt") as f:
        return f.read()

def read_grid(path):
    contents = readFile(path)
    return [[int(val) for val in line.strip().split(" ")] for line in contents.splitlines()]

def init(data):
    path1 = "grids/basic_grid.txt"
    path2 = "grids/interpolated_example.txt"
    data.grid1 = read_grid(path1)
    data.grid2 = read_grid(path2)

def mousePressed(event, data):
    # use event.x and event.y
    pass

def keyPressed(event, data):
    # use event.char and event.keysym
    pass

def timerFired(data):
    pass

def rgbString(red, green, blue):
    return "#%02x%02x%02x" % (red, green, blue)

def draw_grid(canvas, x, y, grid_height, grid, factor):
    # this is pretty cheesy
    '''
    you give it a factor to adjust input values (the interped gradient is about 4x more magnitude)
    but you always use 1 for values on the true pixel position
    see in else case below we divide magnitude by factor
    '''
    box_size = grid_height//len(grid[0])
    for i in range(len(grid)):
        for j in range(len(grid[0])):
            top = y + i * box_size
            right = x + j * box_size
            bot = top + box_size
            left = right + box_size
            if i % 4 == 0 and j % 4 == 0:
                val = min(grid[i][j], 255)
            else:
                val = min(grid[i][j]//factor, 255)
            color = rgbString(val, 0, 0)
            canvas.create_rectangle(right, top, left, bot, fill = color, width = 0)

def redrawAll(canvas, data):
    # assume image width is double the height
    side_length = data.height
    margin = .05 * side_length
    grid_height = side_length - 2*margin
    draw_grid(canvas, margin, margin, grid_height, data.grid1, 1)
    draw_grid(canvas, 3*margin+grid_height, margin, grid_height, data.grid2, 4)

####################################
# use the run function as-is
####################################

def run(width=300, height=300):
    def redrawAllWrapper(canvas, data):
        canvas.delete(ALL)
        canvas.create_rectangle(0, 0, data.width, data.height,
                                fill='white', width=0)
        redrawAll(canvas, data)
        canvas.update()    

    def mousePressedWrapper(event, canvas, data):
        mousePressed(event, data)
        redrawAllWrapper(canvas, data)

    def keyPressedWrapper(event, canvas, data):
        keyPressed(event, data)
        redrawAllWrapper(canvas, data)

    def timerFiredWrapper(canvas, data):
        timerFired(data)
        redrawAllWrapper(canvas, data)
        # pause, then call timerFired again
        canvas.after(data.timerDelay, timerFiredWrapper, canvas, data)
    # Set up data and call init
    class Struct(object): pass
    data = Struct()
    data.width = width
    data.height = height
    data.timerDelay = 100 # milliseconds
    init(data)
    # create the root and the canvas
    root = Tk()
    canvas = Canvas(root, width=data.width, height=data.height)
    canvas.pack()
    # set up events
    root.bind("<Button-1>", lambda event:
                            mousePressedWrapper(event, canvas, data))
    root.bind("<Key>", lambda event:
                            keyPressedWrapper(event, canvas, data))
    timerFiredWrapper(canvas, data)
    # and launch the app
    root.mainloop()  # blocks until window is closed
    print("bye!")

run(1000, 500)