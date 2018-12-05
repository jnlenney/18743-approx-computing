`default_nettype none

module lowerBitAdder
 #(parameter lowerBits = 5);
  (input  logic [39:0] A, B,
   output logic [39:0] Out  );

  assign Out[lowerBits-1:0] = A[lowerBits-1:0] | B[lowerBits-1:0];

  assign Out[39:lowerBits] = A[39:lowerBits] + B[39:lowerBits];


endmodule lowerBitAdder
