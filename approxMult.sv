`default_nettype none

module appoxMult
  (input  logic [ 7:0] A, B,
   output logic [31:0] Out);

  assign Out[31:16] = 16'b0;
  assign Out[15: 6] = A[7:3] * B[7:3];
  assign Out[ 5: 0] = 6'b0;

endmodule: approxMult

