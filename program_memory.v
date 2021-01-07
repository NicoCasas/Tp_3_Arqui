`timescale 1ns / 1ps
module program_memory
#(
    //Parameters
    parameter                                  NB_INSTRUCTION = 16  ,  
    parameter                                  NB_ADDRESS     = 11  ,
    parameter                                  N_INSTRUCTIONS = 16 
  )
  (
    //Outputs
    output  wire [NB_INSTRUCTION-1:0]          o_instruction        ,    
    //Inputs
    input   wire [NB_ADDRESS-1:0]              i_address            ,
    input   wire                               i_clk                , 
    input   wire                               i_reset              
  );
  localparam load5 = 16'b00011_00000000101;
  localparam sto5  = 16'b00001_00000000000;
  localparam load6 = 16'b00011_00000000110; //Valor que queda
  localparam add   = 16'b00100_00000000000;
  localparam add15 = 16'b00101_00000001111;
  localparam sto27 = 16'b00001_00000000111;
  localparam load27= 16'b00010_00000000111;
  localparam sub   = 16'b00110_00000000000;
  localparam sub15 = 16'b00111_00000001111;
  localparam halt  = 16'b00000_00000000000; 
  
  //Internal regs and wires
  reg             [NB_INSTRUCTION-1    :0]      next_data                               ;
//  wire            [NB_INSTRUCTION*16-1 :0]      data                ;
  reg             [NB_INSTRUCTION-1 :0]         data    [N_INSTRUCTIONS-1:0]            ;
  reg             [NB_ADDRESS - 1      :0]      addr                                    ;

always @(negedge i_clk) begin
    if(i_reset) begin
        data[0] =   load5   ;
        data[1] =   sto5    ;
        data[2] =   load6   ;
        data[3] =   add     ;
        data[4] =   add15   ;
        data[5] =   sto27   ;
        data[6] =   sub     ;
        data[7] =   sub15   ;
        data[8] =   halt    ;
        data[9] =   halt    ;
    end
    
    addr        = i_address & 11'b1111                              ;
    next_data   = data[addr]                                        ;
end

//Output assign
assign o_instruction   =   next_data   ;

endmodule