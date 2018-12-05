`default_nettype none

module lowerBitAdder
 #(parameter lowerBits = 5);
  (input  logic [31:0] A, B,
   output logic [31:0] Out  );

  assign Out[lowerBits-1:0] = A[lowerBits-1:0] | B[lowerBits-1:0];

  assign Out[31:lowerBits] = A[31:lowerBits] + B[31:lowerBits];


endmodule lowerBitAdder
