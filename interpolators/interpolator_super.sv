`default_nettype none

//Some macros
`define WIDTH  16
`define HEIGHT 16


module interpolator
  (input  logic [7:0] data_in,
   input  logic        clock, reset_n,
   input  logic        ready,
   output logic [7:0] data_out);

  //Store the pixels that we've seen
  logic [7:0][ 7:0] data_buffer;
  logic      [31:0] aValue, bValue, cValue;

  always_ff @(posedge clock) begin
    if (~reset_n) begin
      //Set everything in the buffer to 0 on reset, so we know what's in it
      data_buffer <= 64'b0;
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

  /*
  // standard
  getAval gav(.data_buffer(data_buffer),.aValue(aValue));
  getBval gbv(.data_buffer(data_buffer),.bValue(bValue));
  getCval gcv(.data_buffer(data_buffer),.cValue(cValue));
  */
  // with fewer coeffs
  getAvalShort gav(.data_buffer(data_buffer),.aValue(aValue));
  getBvalShort gbv(.data_buffer(data_buffer),.bValue(bValue));
  getCvalShort gcv(.data_buffer(data_buffer),.cValue(cValue));
  /*
  // with simple coeffs and bit shifts
  getAvalSimple gav(.data_buffer(data_buffer),.aValue(aValue));
  getBvalSimple gbv(.data_buffer(data_buffer),.bValue(bValue));
  getCvalSimple gcv(.data_buffer(data_buffer),.cValue(cValue));
  // with fewer, simpler coeffs (bit shifts)
  getAvalShortAndSimple gav(.data_buffer(data_buffer),.aValue(aValue));
  getBvalShortAndSimple gbv(.data_buffer(data_buffer),.bValue(bValue));
  getCvalShortAndSimple gcv(.data_buffer(data_buffer),.cValue(cValue));
  // with approximate multiplication
  getAvalApproxMult gav(.data_buffer(data_buffer),.aValue(aValue));
  getBvalApproxMult gbv(.data_buffer(data_buffer),.bValue(bValue));
  getCvalApproxMult gcv(.data_buffer(data_buffer),.cValue(cValue));
  // with Mirror Adder
  getAvalMirrorAdd gav(.data_buffer(data_buffer),.aValue(aValue));
  getBvalMirrorAdd gbv(.data_buffer(data_buffer),.bValue(bValue));
  getCvalMirrorAdd gcv(.data_buffer(data_buffer),.cValue(cValue));
  // with lower bit adder
  getAvalLowerBit gav(.data_buffer(data_buffer),.aValue(aValue));
  getBvalLowerBit gbv(.data_buffer(data_buffer),.bValue(bValue));
  getCvalLowerBit gcv(.data_buffer(data_buffer),.cValue(cValue));
  */

endmodule: interpolator

module interpol_test;
  //(input logic clock, reset_n);

  logic [ 7:0] data_in ;
  logic [ 7:0] data_out;
  logic [31:0] i, j, k ;
  logic        clock   ;
  logic        reset_n ;


  interpolator I(.data_in(data_in), 
                 .clock(clock), 
                 .reset_n(reset_n), 
                 .ready(1'b1), 
                 .data_out(data_out)); 

  //set-up
  initial begin
    clock = 0;
    reset_n = 0;
    forever begin
      #5 clock = ~clock;
    end
  end

  //Places to store our pixels
  logic [0:255][ 7:0] pixels ;
  logic [0:255][13:0] aSubPix;
  logic [0:255][13:0] bSubPix;
  logic [0:255][13:0] cSubPix;
  logic [0:255][13:0] dSubPix;
  logic [0:255][13:0] hSubPix;
  logic [0:255][13:0] nSubPix;
  logic [0:255][13:0] eSubPix;
  logic [0:255][13:0] fSubPix;
  logic [0:255][13:0] gSubPix;
  logic [0:255][13:0] iSubPix;
  logic [0:255][13:0] jSubPix;
  logic [0:255][13:0] kSubPix;
  logic [0:255][13:0] pSubPix;
  logic [0:255][13:0] qSubPix;
  logic [0:255][13:0] rSubPix;


  assign pixels = {8'd0  , 8'd8  , 8'd17 , 8'd25 , 8'd34 , 8'd42 , 
                   8'd51 , 8'd59 , 8'd68 , 8'd76 , 8'd85 , 8'd93 , 
                   8'd102, 8'd110, 8'd119, 8'd127, 8'd8  , 8'd17 , 
                   8'd25 , 8'd34 , 8'd42 , 8'd51 , 8'd59 , 8'd68 , 
                   8'd76 , 8'd85 , 8'd93 , 8'd102, 8'd110, 8'd119, 
                   8'd127, 8'd136, 8'd17 , 8'd25 , 8'd34 , 8'd42 , 
                   8'd51 , 8'd59 , 8'd68 , 8'd76 , 8'd85 , 8'd93 , 
                   8'd102, 8'd110, 8'd119, 8'd127, 8'd136, 8'd144,
                   8'd25 , 8'd34 , 8'd42 , 8'd51 , 8'd59 , 8'd68 , 
                   8'd76 , 8'd85 , 8'd93 , 8'd102, 8'd110, 8'd119, 
                   8'd127, 8'd136, 8'd144, 8'd153, 8'd34 , 8'd42 , 
                   8'd51 , 8'd59 , 8'd68 , 8'd76 , 8'd85 , 8'd93 , 
                   8'd102, 8'd110, 8'd119, 8'd127, 8'd136, 8'd144, 
                   8'd153, 8'd161, 8'd42 , 8'd51 , 8'd59 , 8'd68 , 
                   8'd76 , 8'd85 , 8'd93 , 8'd102, 8'd110, 8'd119, 
                   8'd127, 8'd136, 8'd144, 8'd153, 8'd161, 8'd170,
                   8'd51 , 8'd59 , 8'd68 , 8'd76 , 8'd85 , 8'd93 , 
                   8'd102, 8'd110, 8'd119, 8'd127, 8'd136, 8'd144, 
                   8'd153, 8'd161, 8'd170, 8'd178, 8'd59 , 8'd68 , 
                   8'd76 , 8'd85 , 8'd93 , 8'd102, 8'd110, 8'd119, 
                   8'd127, 8'd136, 8'd144, 8'd153, 8'd161, 8'd170, 
                   8'd178, 8'd187, 8'd68 , 8'd76 , 8'd85 , 8'd93 , 
                   8'd102, 8'd110, 8'd119, 8'd127, 8'd136, 8'd144, 
                   8'd153, 8'd161, 8'd170, 8'd178, 8'd187, 8'd195,
                   8'd76 , 8'd85 , 8'd93 , 8'd102, 8'd110, 8'd119, 
                   8'd127, 8'd136, 8'd144, 8'd153, 8'd161, 8'd170, 
                   8'd178, 8'd187, 8'd195, 8'd204, 8'd85 , 8'd93 , 
                   8'd102, 8'd110, 8'd119, 8'd127, 8'd136, 8'd144, 
                   8'd153, 8'd161, 8'd170, 8'd178, 8'd187, 8'd195, 
                   8'd204, 8'd212, 8'd93 , 8'd102, 8'd110, 8'd119, 
                   8'd127, 8'd136, 8'd144, 8'd153, 8'd161, 8'd170, 
                   8'd178, 8'd187, 8'd195, 8'd204, 8'd212, 8'd221,
                   8'd102, 8'd110, 8'd119, 8'd127, 8'd136, 8'd144, 
                   8'd153, 8'd161, 8'd170, 8'd178, 8'd187, 8'd195, 
                   8'd204, 8'd212, 8'd221, 8'd229, 8'd110, 8'd119, 
                   8'd127, 8'd136, 8'd144, 8'd153, 8'd161, 8'd170, 
                   8'd178, 8'd187, 8'd195, 8'd204, 8'd212, 8'd221, 
                   8'd229, 8'd238, 8'd119, 8'd127, 8'd136, 8'd144, 
                   8'd153, 8'd161, 8'd170, 8'd178, 8'd187, 8'd195, 
                   8'd204, 8'd212, 8'd221, 8'd229, 8'd238, 8'd246,
                   8'd127, 8'd136, 8'd144, 8'd153, 8'd161, 8'd170, 
                   8'd178, 8'd187, 8'd195, 8'd204, 8'd212, 8'd221, 
                   8'd229, 8'd238, 8'd246, 8'd255                   };


  initial begin
    @(posedge clock);
    reset_n = 1;
    data_in <= pixels[0];


    /*************************ABC Interpolation*********************/
    //Loop over all of the pixels we have an save the values of subpixels
    for (i = 0; i < `HEIGHT; i++) begin
      //Fill buffer with new pixels or end of row pixel
      for (k = 0; k < `WIDTH+13; k++) begin
        if (k < 7) begin
          data_in <= pixels[i*`WIDTH];
        end
        if (k > 6 & k < `WIDTH+7) begin
          data_in <= pixels[i*`WIDTH+k-7];
        end
        if (k > `WIDTH+6) begin
          data_in <= pixels[i*`WIDTH+15];
        end
        if (k > 12) begin
          aSubPix[i*`WIDTH+k-13] <= I.aValue[19:6];
          bSubPix[i*`WIDTH+k-13] <= I.bValue[19:6];
          cSubPix[i*`WIDTH+k-13] <= I.cValue[19:6];         
        end
        @(posedge clock);
      end
    end

    /*****************************DHN Interpolation**********************/
    for (i = 0; i < `HEIGHT; i++) begin
      //Fill buffer with new pixels or end of col pixel
      for (k = 0; k < `WIDTH+13; k++) begin
        if (k < 7) begin
          data_in <= pixels[i];
        end
        if (k > 6 & k < `WIDTH+7) begin
          data_in <= pixels[(k-7)*`WIDTH+i]; 
        end
        if (k > `WIDTH+6) begin
          data_in <= pixels[`WIDTH*(`HEIGHT-1)+i];
        end
        if (k > 12) begin
          dSubPix[i+`WIDTH*(k-13)] <= I.aValue[19:6];
          hSubPix[i+`WIDTH*(k-13)] <= I.bValue[19:6];
          nSubPix[i+`WIDTH*(k-13)] <= I.cValue[19:6];
        end
        @(posedge clock);
      end
    end

    /************************EIP Interpolation************************/
    for (i = 0; i < `HEIGHT; i++) begin
      //Fill buffer with new pixels or end of col pixel
      for (k = 0; k < `WIDTH+13; k++) begin
        if (k < 7) begin
          data_in <= aSubPix[i];
        end
        if (k > 6 & k < `WIDTH+7) begin
          data_in <= aSubPix[(k-7)*`WIDTH+i];
        end
        if (k > `WIDTH+6) begin
          data_in <= aSubPix[`WIDTH*(`HEIGHT-1)+i];
        end
        if (k > 12) begin
          eSubPix[i+`WIDTH*(k-13)] <= I.aValue[19:6];
          iSubPix[i+`WIDTH*(k-13)] <= I.bValue[19:6];
          pSubPix[i+`WIDTH*(k-13)] <= I.cValue[19:6];
        end
        @(posedge clock);
      end
    end

    /*********************FJQ Interpolation******************/
    for (i = 0; i < `HEIGHT; i++) begin
      //Fill buffer with new pixels or end of col pixel
      for (k = 0; k < `WIDTH+13; k++) begin
        if (k < 7) begin
          data_in <= bSubPix[i];
        end
        if (k > 6 & k < `WIDTH+7) begin
          data_in <= bSubPix[(k-7)*`WIDTH+i];
        end
        if (k > `WIDTH+6) begin
          data_in <= bSubPix[`WIDTH*(`HEIGHT-1)+i];
        end
        if (k > 12) begin
          fSubPix[i+`WIDTH*(k-13)] <= I.aValue[19:6];
          jSubPix[i+`WIDTH*(k-13)] <= I.bValue[19:6];
          qSubPix[i+`WIDTH*(k-13)] <= I.cValue[19:6];
        end
        @(posedge clock);
      end
    end

    /*****************************GKR Interpolation**************************/
    for (i = 0; i < `HEIGHT; i++) begin
      //Fill buffer with new pixels or end of col pixel
      for (k = 0; k < `WIDTH+13; k++) begin
        if (k < 7) begin
          data_in <= cSubPix[i];
        end
        if (k > 6 & k < `WIDTH+7) begin
          data_in <= cSubPix[(k-7)*`WIDTH+i];
        end
        if (k > `WIDTH+6) begin
          data_in <= cSubPix[`WIDTH*(`HEIGHT-1)+i];
        end
        if (k > 12) begin
          gSubPix[i+`WIDTH*(k-13)] <= I.aValue[19:6];
          kSubPix[i+`WIDTH*(k-13)] <= I.bValue[19:6];
          rSubPix[i+`WIDTH*(k-13)] <= I.cValue[19:6];
        end
        @(posedge clock);
      end
    end




    for (i = 0; i < `WIDTH*`HEIGHT; i++) begin
      $display("%d", pixels [i]);
      $display("%d", aSubPix[i]);
      $display("%d", bSubPix[i]);
      $display("%d", cSubPix[i]);
      $display("%d", dSubPix[i]);
      $display("%d", eSubPix[i]);
      $display("%d", fSubPix[i]);
      $display("%d", gSubPix[i]);
      $display("%d", hSubPix[i]);
      $display("%d", iSubPix[i]);
      $display("%d", jSubPix[i]);
      $display("%d", kSubPix[i]);
      $display("%d", nSubPix[i]);
      $display("%d", pSubPix[i]);
      $display("%d", qSubPix[i]);
      $display("%d", rSubPix[i]);
    end

  $finish;
  end


endmodule: interpol_test





