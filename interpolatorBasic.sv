`default_nettype none


module interpolator
  (input  logic [31:0] data_in,
   input  logic        clock, reset_n,
   input  logic        ready,
   output logic [31:0] data_out,
   output logic [31:0] address);

  //Store the pixels that we've seen
  logic [7:0][31:0] data_buffer;
  logic      [39:0] aValue, bValue, cValue;

  always_ff @(posedge clock) begin
    if (~reset_n) begin
      //Set everything in the buffer to 0 on reset, so we know what's in it
      data_buffer = 256'b0;
    end
    else begin
      //Otherwise we'd like to move the data buffer along
      data_buffer[7] <= data_buffer[6];
      data_buffer[6] <= data_buffer[5];
      data_buffer[5] <= data_buffer[4];
      data_buffer[4] <= data_buffer[3];
      data_buffer[3] <= data_buffer[2];
      data_buffer[2] <= data_buffer[1];
      data_buffer[1] <= data_buffer[0];
      data_buffer[0] <= data_in       ;
    end
  end

  getAval gav(.data_buffer(data_buffer),.aValue(aValue));
  getBval gbv(.data_buffer(data_buffer),.bValue(bValue));
  getCval gcv(.data_buffer(data_buffer),.cValue(cValue));


endmodule: interpolator


//made some modules for...modularity
//Added extra bits to the output since it can have extra bits
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



module interpol_test
  (input  logic clock, reset_n);

  logic [31:0] addr    ;
  logic [31:0] data_in ;
  logic [31:0] data_out;
  logic [31:0] i, j, k ;

  interpolator I(.data_in(data_in), 
                 .clock(clock), 
                 .reset_n(reset_n), 
                 .ready(1'b1), 
                 .data_out(data_out), 
                 .address(addr)); 

  //set-up
  initial begin
    clock = 0;
    reset_n = 0;
    forever begin
      #5 clock = ~clock;
    end
  end

  //Places to store our pixels
  logic [255:0][31:0] pixels ;
  logic [255:0][31:0] aSubPix;
  logic [255:0][31:0] bSubPix;
  logic [255:0][31:0] cSubPix;
  logic [255:0][31:0] dSubPix;
  logic [255:0][31:0] hSubPix;
  logic [255:0][31:0] nSubPix;
  logic [255:0][31:0] eSubPix;
  logic [255:0][31:0] fSubPix;
  logic [255:0][31:0] gSubPix;
  logic [255:0][31:0] iSubPix;
  logic [255:0][31:0] jSubPix;
  logic [255:0][31:0] kSubPix;
  logic [255:0][31:0] pSubPix;
  logic [255:0][31:0] qSubPix;
  logic [255:0][31:0] rSubPix;


  assign pixels = {32'd0  , 32'd8  , 32'd17 , 32'd25 , 32'd34 , 32'd42 , 
                   32'd51 , 32'd59 , 32'd68 , 32'd76 , 32'd85 , 32'd93 , 
                   32'd102, 32'd110, 32'd119, 32'd127, 32'd8  , 32'd17 , 
                   32'd25 , 32'd34 , 32'd42 , 32'd51 , 32'd59 , 32'd68 , 
                   32'd76 , 32'd85 , 32'd93 , 32'd102, 32'd110, 32'd119, 
                   32'd127, 32'd136, 32'd17 , 32'd25 , 32'd34 , 32'd42 , 
                   32'd51 , 32'd59 , 32'd68 , 32'd76 , 32'd85 , 32'd93 , 
                   32'd102, 32'd110, 32'd119, 32'd127, 32'd136, 32'd144,
                   32'd25 , 32'd34 , 32'd42 , 32'd51 , 32'd59 , 32'd68 , 
                   32'd76 , 32'd85 , 32'd93 , 32'd102, 32'd110, 32'd119, 
                   32'd127, 32'd136, 32'd144, 32'd153, 32'd34 , 32'd42 , 
                   32'd51 , 32'd59 , 32'd68 , 32'd76 , 32'd85 , 32'd93 , 
                   32'd102, 32'd110, 32'd119, 32'd127, 32'd136, 32'd144, 
                   32'd153, 32'd161, 32'd42 , 32'd51 , 32'd59 , 32'd68 , 
                   32'd76 , 32'd85 , 32'd93 , 32'd102, 32'd110, 32'd119, 
                   32'd127, 32'd136, 32'd144, 32'd153, 32'd161, 32'd170,
                   32'd51 , 32'd59 , 32'd68 , 32'd76 , 32'd85 , 32'd93 , 
                   32'd102, 32'd110, 32'd119, 32'd127, 32'd136, 32'd144, 
                   32'd153, 32'd161, 32'd170, 32'd178, 32'd59 , 32'd68 , 
                   32'd76 , 32'd85 , 32'd93 , 32'd102, 32'd110, 32'd119, 
                   32'd127, 32'd136, 32'd144, 32'd153, 32'd161, 32'd170, 
                   32'd178, 32'd187, 32'd68 , 32'd76 , 32'd85 , 32'd93 , 
                   32'd102, 32'd110, 32'd119, 32'd127, 32'd136, 32'd144, 
                   32'd153, 32'd161, 32'd170, 32'd178, 32'd187, 32'd195,
                   32'd76 , 32'd85 , 32'd93 , 32'd102, 32'd110, 32'd119, 
                   32'd127, 32'd136, 32'd144, 32'd153, 32'd161, 32'd170, 
                   32'd178, 32'd187, 32'd195, 32'd204, 32'd85 , 32'd93 , 
                   32'd102, 32'd110, 32'd119, 32'd127, 32'd136, 32'd144, 
                   32'd153, 32'd161, 32'd170, 32'd178, 32'd187, 32'd195, 
                   32'd204, 32'd212, 32'd93 , 32'd102, 32'd110, 32'd119, 
                   32'd127, 32'd136, 32'd144, 32'd153, 32'd161, 32'd170, 
                   32'd178, 32'd187, 32'd195, 32'd204, 32'd212, 32'd221,
                   32'd102, 32'd110, 32'd119, 32'd127, 32'd136, 32'd144, 
                   32'd153, 32'd161, 32'd170, 32'd178, 32'd187, 32'd195, 
                   32'd204, 32'd212, 32'd221, 32'd229, 32'd110, 32'd119, 
                   32'd127, 32'd136, 32'd144, 32'd153, 32'd161, 32'd170, 
                   32'd178, 32'd187, 32'd195, 32'd204, 32'd212, 32'd221, 
                   32'd229, 32'd238, 32'd119, 32'd127, 32'd136, 32'd144, 
                   32'd153, 32'd161, 32'd170, 32'd178, 32'd187, 32'd195, 
                   32'd204, 32'd212, 32'd221, 32'd229, 32'd238, 32'd246,
                   32'd127, 32'd136, 32'd144, 32'd153, 32'd161, 32'd170, 
                   32'd178, 32'd187, 32'd195, 32'd204, 32'd212, 32'd221, 
                   32'd229, 32'd238, 32'd246, 32'd255                   };


  initial begin
    @(posedge clock);
    reset_n = 1;
    data_in = pixels[255];


    /*************************ABC Interpolation*********************/
    //Loop over all of the pixels we have an save the values of subpixels
    for (i = 0; i < 16; i++) begin
      //fill buffer with first pixel
      for (j = 0; j < 8; j++) begin
        data_in <= pixels[255-i*16];
        @(posedge clock);
      end
      //Fill buffer with new pixels or end of row pixel
      for (k = 0; k < 21; k++) begin
        if (k > 4) begin
          aSubPix[i*16+k-5] <= I.aValue[37:6];
          bSubPix[i*16+k-5] <= I.bValue[37:6];
          cSubPix[i*16+k-5] <= I.cValue[37:6];         
        end
        if (k < 16) begin
          data_in <= pixels[255-i*16-k];
        end
        @(posedge clock);
      end
    end

    /*****************************DHN Interpolation**********************/
    for (i = 0; i < 16; i++) begin
      //fill buffer with the first pixel
      for (j = 0; j < 8; j++) begin
        data_in <= pixels[255-i];
        @(posedge clock);
      end

      //Fill buffer with new pixels or end of col pixel
      for (k = 0; k < 21; k++) begin
        if (k > 4) begin
          dSubPix[i+16*(k-5)] <= I.aValue[37:6];
          hSubPix[i+16*(k-5)] <= I.bValue[37:6];
          nSubPix[i+16*(k-5)] <= I.cValue[37:6];
        end
        if (k < 16) begin
          data_in <= pixels[255-i-16*k];
        end
        @(posedge clock);
      end
    end

    /************************EIP Interpolation************************/
    for (i = 0; i < 16; i++) begin
      //fill buffer with the first pixel
      for (j = 0; j < 8; j++) begin
        data_in <= aSubPix[255-i];
        @(posedge clock);
      end

      //Fill buffer with new pixels or end of col pixel
      for (k = 0; k < 21; k++) begin
        if (k > 4) begin
          eSubPix[i+16*(k-5)] <= I.aValue[37:6];
          iSubPix[i+16*(k-5)] <= I.bValue[37:6];
          pSubPix[i+16*(k-5)] <= I.cValue[37:6];
        end
        if (k < 16) begin
          data_in <= aSubPix[255-i-16*k];
        end
        @(posedge clock);
      end
    end

    /*********************FJQ Interpolation******************/
    for (i = 0; i < 16; i++) begin
      //fill buffer with the first pixel
      for (j = 0; j < 8; j++) begin
        data_in <= bSubPix[255-i];
        @(posedge clock);
      end

      //Fill buffer with new pixels or end of col pixel
      for (k = 0; k < 21; k++) begin
        if (k > 4) begin
          fSubPix[i+16*(k-5)] <= I.aValue[37:6];
          jSubPix[i+16*(k-5)] <= I.bValue[37:6];
          qSubPix[i+16*(k-5)] <= I.cValue[37:6];
        end
        if (k < 16) begin
          data_in <= bSubPix[255-i-16*k];
        end
        @(posedge clock);
      end
    end

    /*****************************GKR Interpolation**************************/
    for (i = 0; i < 16; i++) begin
      //fill buffer with the first pixel
      for (j = 0; j < 8; j++) begin
        data_in <= cSubPix[255-i];
        @(posedge clock);
      end

      //Fill buffer with new pixels or end of col pixel
      for (k = 0; k < 21; k++) begin
        if (k > 4) begin
          gSubPix[i+16*(k-5)] <= I.aValue[37:6];
          kSubPix[i+16*(k-5)] <= I.bValue[37:6];
          rSubPix[i+16*(k-5)] <= I.cValue[37:6];
        end
        if (k < 16) begin
          data_in <= cSubPix[255-i-16*k];
        end
        @(posedge clock);
      end
    end




    for (i = 0; i < 256; i++) begin
      $display("%d", pixels [    i]);
      $display("%d", aSubPix[255-i]);
      $display("%d", bSubPix[255-i]);
      $display("%d", cSubPix[255-i]);
      $display("%d", dSubPix[    i]);
      $display("%d", eSubPix[    i]);
      $display("%d", fSubPix[    i]);
      $display("%d", gSubPix[    i]);
      $display("%d", hSubPix[    i]);
      $display("%d", iSubPix[    i]);
      $display("%d", jSubPix[    i]);
      $display("%d", kSubPix[    i]);
      $display("%d", nSubPix[    i]);
      $display("%d", pSubPix[    i]);
      $display("%d", qSubPix[    i]);
      $display("%d", rSubPix[    i]);
    end

  $finish;
  end


endmodule: interpol_test





