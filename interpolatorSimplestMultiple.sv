`default_nettype none

module getAValShortAndSimple
  (input  logic [7:0][ 7:0] data_buffer,
   output logic      [31:0] aValue      );

  assign aValue =   4 * data_buffer[6]
                  - 8 * data_buffer[5]
                  +64 * data_buffer[4]
                  +16 * data_buffer[3]
                  - 4 * data_buffer[2]

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

