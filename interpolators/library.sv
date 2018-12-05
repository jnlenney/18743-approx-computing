`default_nettype none

module approxMult
  (input  logic [ 7:0] A, B,
   output logic [31:0] Out);

  assign Out[31:16] = 16'b0;
  assign Out[15: 6] = A[7:3] * B[7:3];
  assign Out[ 5: 0] = 6'b0;

endmodule: approxMult




module approxMirrorAdder
  (input  logic [31:0] A, B,
   output logic [31:0] Out  );

  logic [31:0] Carries;

  genvar i;
  generate 
    for (i = 0; i < 31; i = i + 1) begin: adding
     mirrorAdd mA(.A(A[i]), 
                  .B(B[i]), 
                  .Cin(Carries[i]), 
                  .Sum(Out[i]), 
                  .Cout(Carries[i + 1]));
    end: adding
  endgenerate

endmodule: approxMirrorAdder

module mirrorAdd
  (input  logic A, B, Cin,
   output logic Sum, Cout );

  assign Cout = (A & B) | (A & Cin) | (B & Cin);
  assign Sum  = ~Cout;

endmodule: mirrorAdd




module lowerBitAdder
 #(parameter lowerBits = 5)
  (input  logic [31:0] A, B,
   output logic [31:0] Out  );

  assign Out[lowerBits-1:0] = A[lowerBits-1:0] | B[lowerBits-1:0];

  assign Out[31:lowerBits] = A[31:lowerBits] + B[31:lowerBits];

endmodule: lowerBitAdder




module getAval
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] aValue      );

  assign aValue = - 1 * data_buffer[7]
                  + 4 * data_buffer[6]
                  -10 * data_buffer[5]
                  +58 * data_buffer[4]
                  +17 * data_buffer[3]
                  - 5 * data_buffer[2]
                  + 1 * data_buffer[1];

endmodule: getAval

module getBval
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] bValue      );

  assign bValue = - 1 * data_buffer[7]
                  + 4 * data_buffer[6]
                  -11 * data_buffer[5]
                  +40 * data_buffer[4]
                  +40 * data_buffer[3]
                  -11 * data_buffer[2]
                  + 4 * data_buffer[1]
                  - 1 * data_buffer[0];

endmodule: getBval

module getCval
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] cValue      );

  assign cValue =   1 * data_buffer[6]
                  - 5 * data_buffer[5]
                  +17 * data_buffer[4]
                  +58 * data_buffer[3]
                  -10 * data_buffer[2]
                  + 4 * data_buffer[1]
                  - 1 * data_buffer[0];

endmodule: getCval




module getAValShort
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [31:0] aValue);

  assign aValue =   4 * data_buffer[6]
                  -10 * data_buffer[5]
                  +58 * data_buffer[4]
                  +17 * data_buffer[3]
                  - 5 * data_buffer[2];

endmodule: getAValShort


module getBValShort
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [31:0] bValue);

  assign bValue =   4 * data_buffer[6]
                  -11 * data_buffer[5]
                  +40 * data_buffer[4]
                  +40 * data_buffer[3]
                  -11 * data_buffer[2]
                  + 4 * data_buffer[1];

endmodule: getBValShort


module getCValShort
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [31:0] cValue);

  assign cValue = - 5 * data_buffer[6]
                  +17 * data_buffer[5]
                  +58 * data_buffer[4]
                  -10 * data_buffer[3]
                  + 4 * data_buffer[2];

endmodule: getCValShort





module getAValSimple
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [39:0] aValue      );

  assign aValue = - 1 * data_buffer[7]
                  + 4 * data_buffer[6]
                  - 8 * data_buffer[5]
                  +64 * data_buffer[4]
                  +16 * data_buffer[3]
                  - 4 * data_buffer[2]
                  + 1 * data_buffer[1];

endmodule: getAValSimple


module getBValSimple
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [39:0] bValue      );

  assign bValue = - 1 * data_buffer[7]
                  + 4 * data_buffer[6]
                  - 8 * data_buffer[5]
                  +32 * data_buffer[4]
                  +32 * data_buffer[3]
                  - 8 * data_buffer[2]
                  + 4 * data_buffer[1]
                  - 1 * data_buffer[0];

endmodule: getBValSimple


module getCValSimple
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [39:0] cValue      );

  assign cValue =   1 * data_buffer[7]
                  - 4 * data_buffer[6]
                  +16 * data_buffer[5]
                  +64 * data_buffer[4]
                  - 8 * data_buffer[3]
                  + 4 * data_buffer[2]
                  - 1 * data_buffer[1];

endmodule: getCValSimple




module getAValShortAndSimple
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [31:0] aValue      );

  assign aValue =   4 * data_buffer[6]
                  - 8 * data_buffer[5]
                  +64 * data_buffer[4]
                  +16 * data_buffer[3]
                  - 4 * data_buffer[2];

endmodule: getAValShortAndSimple

module getBValShortAndSimple
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [31:0] bValue      );

  assign bValue =   4 * data_buffer[6]
                  - 8 * data_buffer[5]
                  +32 * data_buffer[4]
                  +32 * data_buffer[3]
                  - 8 * data_buffer[2]
                  + 4 * data_buffer[1];

endmodule: getBValShortAndSimple

module getCValShortAndSimple
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [31:0] cValue      );

  assign cValue = - 4 * data_buffer[6]
                  +16 * data_buffer[5]
                  +64 * data_buffer[4]
                  - 8 * data_buffer[3]
                  + 4 * data_buffer[2];

endmodule: getCValShortAndSimple




module getAvalApproxMult
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] aValue      );

  logic [6:0][31:0] sums;

  approxMult add0(.A( -1), .B(data_buffer[7]), .Out(sums[6][31:0]));
  approxMult add0(.A(  4), .B(data_buffer[6]), .Out(sums[5][31:0]));
  approxMult add0(.A(-10), .B(data_buffer[5]), .Out(sums[4][31:0]));
  approxMult add0(.A( 58), .B(data_buffer[4]), .Out(sums[3][31:0]));
  approxMult add0(.A( 17), .B(data_buffer[3]), .Out(sums[2][31:0]));
  approxMult add0(.A( -5), .B(data_buffer[2]), .Out(sums[1][31:0]));
  approxMult add0(.A(  1), .B(data_buffer[1]), .Out(sums[0][31:0]));

  assign aValue = {8'b0, 
                   sums[0]+
                   sums[1]+
                   sums[2]+
                   sums[3]+
                   sums[4]+
                   sums[5]+
                   sums[6]};

endmodule: getAvalApproxMult

module getBvalApproxMult
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] bValue      );

  logic [7:0][31:0] sums;

  
  approxMult add0(.A( -1), .B(data_buffer[7]), .Out(sums[7][31:0]));
  approxMult add0(.A(  4), .B(data_buffer[6]), .Out(sums[6][31:0]));
  approxMult add0(.A(-11), .B(data_buffer[5]), .Out(sums[5][31:0]));
  approxMult add0(.A( 40), .B(data_buffer[4]), .Out(sums[4][31:0]));
  approxMult add0(.A( 40), .B(data_buffer[3]), .Out(sums[3][31:0]));
  approxMult add0(.A(-11), .B(data_buffer[2]), .Out(sums[2][31:0]));
  approxMult add0(.A(  4), .B(data_buffer[1]), .Out(sums[1][31:0]));
  approxMult add0(.A( -1), .B(data_buffer[0]), .Out(sums[0][31:0]));

  assign bValue = {8'b0, 
                   sums[0]+
                   sums[1]+
                   sums[2]+
                   sums[3]+
                   sums[4]+
                   sums[5]+
                   sums[6]+
                   sums[7]};

endmodule: getBvalApproxMult

module getCval
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] cValue      );

  logic [6:0][31:0] sums;

  approxMult add0(.A(  1), .B(data_buffer[6]), .Out(sums[6][31:0]));
  approxMult add0(.A( -5), .B(data_buffer[5]), .Out(sums[5][31:0]));
  approxMult add0(.A( 17), .B(data_buffer[4]), .Out(sums[4][31:0]));
  approxMult add0(.A( 58), .B(data_buffer[3]), .Out(sums[3][31:0]));
  approxMult add0(.A(-10), .B(data_buffer[2]), .Out(sums[2][31:0]));
  approxMult add0(.A(  4), .B(data_buffer[1]), .Out(sums[1][31:0]));
  approxMult add0(.A( -1), .B(data_buffer[0]), .Out(sums[0][31:0]));

  assign cValue = {8'b0, 
                   sums[0]+
                   sums[1]+
                   sums[2]+
                   sums[3]+
                   sums[4]+
                   sums[5]+
                   sums[6]};

endmodule: getCval