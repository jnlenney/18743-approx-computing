`default_nettype none

module getAValShort
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] aValue);

  assign aValue =   4 * data_buffer[6]
                  -10 * data_buffer[5]
                  +58 * data_buffer[4]
                  +17 * data_buffer[3]
                  - 5 * data_buffer[2];

endmodule: getAValShort


module getBValShort
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] bValue);

  assign bValue =   4 * data_buffer[6]
                  -11 * data_buffer[5]
                  +40 * data_buffer[4]
                  +40 * data_buffer[3]
                  -11 * data_buffer[2]
                  + 4 * data_buffer[1];

endmodule: getBValShort


module getCValShort
  (input  logic [7:0][31:0] data_buffer,
   output logic      [39:0] cValue);

  assign cValue = - 5 * data_buffer[6]
                  +17 * data_buffer[5]
                  +58 * data_buffer[4]
                  -10 * data_buffer[3]
                  + 4 * data_buffer[2];

endmodule: getCValShort




