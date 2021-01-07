`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module program_memory2
#(
    //PARAMETERS
    parameter                                   NB_INSTRUCTION      = 16    ,
    parameter                                   NB_ADDRESS          = 11    ,
    parameter                                   N_INSTRUCTIONS      = 16
  )
  (
    //OUTPUTS
    output  wire [NB_INSTRUCTION-1:0]           o_instruction               ,
    //INPUTS
    input   wire [NB_ADDRESS-1:0]               i_address           
  );
  
  
  //INTERNAL REGS & WIRES
  reg  [N_INSTRUCTIONS*NB_INSTRUCTION-1:0]  data       ;
    
  //COMBINATIONAL LOGIC
  assign o_instruction = data[(i_address&11'b1111)*NB_INSTRUCTION+:NB_INSTRUCTION]    ;
  

endmodule
