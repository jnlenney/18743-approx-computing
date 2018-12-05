`default_nettype none

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
