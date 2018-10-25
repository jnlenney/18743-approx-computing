# written by nikolai lenney (jlenney) for 18743

import copy, time

Coeffs = {"A":[-1, 4, -10, 58, 17, -5, 1, 0],
          "B":[-1, 4, -11, 40, 40, -11, 4, -1],
          "C":[0, 1, -5, 17, 58, -10, 4, -1]}

class Memory(object):
    def __init__(self, rows, cols):
        self.data = [[0 for j in range(cols)] for i in range(rows)]
        self.w_ct = 0
        self.r_ct = 0

    def write(self, r, c, d):
        self.w_ct += 1
        self.data[r][c] = d

    def read(self, r, c):
        self.r_ct += 1
        return self.data[r][c]

    def get_mem_ct(self):
        return self.w_ct + self.r_ct

class Buffer(object):
    def __init__(self, size):
        # size shouldn't be 0
        self.buf = [0 for i in range(size)]

    def shift(self):
        self.buf.pop(0)
        self.buf.append(0)

    def shift_elem_in(self, data):
        # assumes not empty
        self.buf.pop(0)
        self.buf.append(data)

    def clear(self):
        for i in range(len(self.buf)):
            self.buf[i] = 0

    def mul_coeffs(self, coeff_type):
        coeffs = Coeffs[coeff_type]
        res = 0
        for (i, val) in enumerate(self.buf):
            res += val * coeffs[i]
        return res


def interp_row(mem, row, cols, buf, shift):
    # assumes buf is size 8, all zeros
    num_true_cols = cols//4
 
    # first load upto top 5 values
    for c in range(5):
        col = c * 4
        if col < cols:
            data = mem.read(row, col)
            buf.shift_elem_in(data)
        else:
            buf.shift()

    # then actually calculate values, and continue reading
    for tc in range(num_true_cols):
        val_a = buf.mul_coeffs("A")//shift
        val_b = buf.mul_coeffs("B")//shift
        val_c = buf.mul_coeffs("C")//shift
        c_a = tc*4 + 1
        c_b = tc*4 + 2
        c_c = tc*4 + 3
        mem.write(row, c_a, val_a)
        mem.write(row, c_b, val_b)
        mem.write(row, c_c, val_c)
        next_c = 4*(tc+5)
        if next_c < cols:
            data = mem.read(row, next_c)
            buf.shift_elem_in(data)
        else:
            buf.shift()

def interp_col(mem, col, rows, buf, shift):
    # everything uses coeffs ABC, and all entries are fresh
    num_true_rows = rows//4

    # first load upto top 5 values
    for r in range(5):
        row = r * 4
        if row < rows:
            data = mem.read(row, col)
            buf.shift_elem_in(data)
        else:
            buf.shift()

    # then actually calculate, values, and continue reading
    for tr in range(num_true_rows):
        val_a = buf.mul_coeffs("A")//shift
        val_b = buf.mul_coeffs("B")//shift
        val_c = buf.mul_coeffs("C")//shift
        r_a = tr*4 + 1
        r_b = tr*4 + 2
        r_c = tr*4 + 3
        mem.write(r_a, col, val_a)
        mem.write(r_b, col, val_b)
        mem.write(r_c, col, val_c)
        next_r = 4*(tr+5)
        if next_r < rows:
            data = mem.read(next_r, col)
            buf.shift_elem_in(data)
        else:
            buf.shift()

def interp_abc(mem, rows, cols, buf):
    for row in range(0, rows, 4):
        interp_row(mem, row, cols, buf, 2**4)
        buf.clear()

def interp_cols(mem, rows, cols, buf):
    for col in range(0, cols):
        shift = 2**6 if col % 4 else 2**4
        interp_col(mem, col, rows, buf, shift)
        buf.clear()

def interpolate(mem, rows, cols):
    buf = Buffer(8)

    # interpolate main rows and cols
    interp_abc(mem, rows, cols, buf)
    interp_cols(mem, rows, cols, buf)

##################### N A I V E #####################

def get_col(L, c):
    return [row[c] for row in L]

def get_pix(L, i, size):
    mod4 = i % 4
    left_pixel = i - mod4
    res = []
    for j in range(-3, 5):
        k = left_pixel + (j * 4)
        if 0 <= k < size:
            res.append(L[k])
        else:
            res.append(0)
    return res

def mult_coeffs(tpix, coeffs):
    res = 0
    for i in range(len(tpix)):
        res += tpix[i] * coeffs[i]
    return res

def naive_abc(data, rows, cols):
    for r in range(0, rows, 4):
        row = data[r]
        for c in range(cols):
            cmod4 = c % 4
            if cmod4 != 0:
                tpix = get_pix(row, c, cols)
                if cmod4 == 1: coeffs = Coeffs["A"]
                elif cmod4 == 2: coeffs = Coeffs["B"]
                else: coeffs = Coeffs["C"]
                val = mult_coeffs(tpix, coeffs)
                data[r][c] = val 

def naive_cols(data, rows, cols):
    for c in range(cols):
        col = get_col(data, c)
        for r in range(rows):
            rmod4 = r % 4
            if rmod4 != 0:
                tpix = get_pix(col, r, rows)
                if rmod4 == 1: coeffs = Coeffs["A"]
                elif rmod4 == 2: coeffs = Coeffs["B"]
                else: coeffs = Coeffs["C"]
                val = mult_coeffs(tpix, coeffs)
                data[r][c] = val
 
def naive_interpolation(data, rows, cols):
    # data is 2D list, not mem object
    naive_abc(data, rows, cols)
    naive_cols(data, rows, cols)




def main():
    # 3 rows, 4 columns
    num_true_rows = 75
    num_true_cols = 100
    num_sp = 4
    num_rows = num_true_rows * num_sp
    num_cols = num_true_cols * num_sp

    t0 = time.time()
    print("initing mem")

    mem = Memory(num_rows, num_cols)
    # fill memory with arbitrary values for true pixels
    for i in range(num_true_rows):
        for j in range(num_true_cols):
            r = i * num_sp
            c = j * num_sp
            val = i*num_true_cols + j
            mem.write(r, c, val)
    
    t1 = time.time()
    print("deepcopying mem")
    data_copy = copy.deepcopy(mem.data)

    t2 = time.time()
    print("doing smart interpolation")

    interpolate(mem, num_rows, num_cols)

    t3 = time.time()
    print("doing naive interpolation")

    naive_interpolation(data_copy, num_rows, num_cols)
    print("\n\n****************************************************\n\n")
    for line in mem.data:
        print(line)
    print("\n\n****************************************************\n\n")
    for line in data_copy:
        print(line)
    
    t4 = time.time()
    print("checking results")

    if mem.data == data_copy:
        print("they match!")
    else:
        print("they don't match:(")

    t5 = time.time()
    t_init = t1 - t0
    t_copy = t2 - t1
    t_ginterp = t3 - t2

    t_ninterp = t4 - t3
    t_check = t5 - t4

    print("time for init", t_init)
    print("time for copy", t_copy)
    print("time for gint", t_ginterp)
    print("time for nint", t_ninterp)
    print("time for chck", t_check)


    print("num reads", mem.r_ct)
    # num reads = tr*tc*5
    print("num writes", mem.w_ct)
    # num writes = tr*tc*15
    print("num total", mem.get_mem_ct())


def interp_extern(grid):
    num_true_rows = len(grid)
    num_true_cols = len(grid[0])
    num_sp = 4
    num_rows = num_true_rows * num_sp
    num_cols = num_true_cols * num_sp

    mem = Memory(num_rows, num_cols)

    for r in range(num_true_rows):
        for c in range(num_true_cols):
            val = grid[r][c]
            mem.write(r*4,c*4,val)

    interpolate(mem, num_rows, num_cols)
    return mem.data


