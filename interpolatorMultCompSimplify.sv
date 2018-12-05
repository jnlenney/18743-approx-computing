`default_nettype None




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
                  - 1 * data_buffer[1]



endmodule: getCValSimple


