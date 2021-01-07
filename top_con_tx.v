`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module top_con_tx
#(//PARAMETERS
    parameter   F_CLOCK             = 25000000      ,
    parameter   NB_OPCODE           = 5             ,
    parameter   NB_INSTRUCTION      = 16            ,
    parameter   NB_ADDRESS          = 11            ,
    parameter   NB_OPERAND          = 11            ,
    parameter   NB_DATA             = 16            ,
    parameter   NB_OP               = 6 
 )
 (
    //OUTPUTS
    output wire                     o_data    ,
    //INPUTS
    input wire                      i_clk     ,
    input wire                      i_reset       
    );
    
    
 //REGS & WIRES
    wire [NB_DATA-1   :0]    data     ;
    wire                     valid    ;

//MODULE INSTANTIATION

  //TOP  
  top
  #(
    //PARAMETERS
    .NB_OPCODE      (NB_OPCODE)             ,
    .NB_INSTRUCTION (NB_INSTRUCTION)        ,
    .NB_ADDRESS     (NB_ADDRESS)            ,
    .NB_OPERAND     (NB_OPERAND)            ,
    .NB_DATA        (NB_DATA)               ,
    .NB_OP          (NB_OP)                
  )
  u_top      
  (     
        //OUTPUTS
        .o_resultado_final  (data)                          ,
        .o_valid            (valid)                         ,
        //INPUTS
        .i_clk              (i_clk)                         ,
        .i_reset            (i_reset)                       
  );
  
//TX_BAUDRATE  
tx_baudrate
#(
    //PARAMETERS
    .NB_DATA(NB_DATA)                               ,
    .F_CLOCK(F_CLOCK)
 )
 u_tx_baudrate
 (
    //OUTPUTS
        .o_data (o_data)                            ,
    //INPUTS
        .i_clk  (i_clk)                             ,
        .i_reset(i_reset)                           ,
        .i_valid(valid)                             ,       
        .i_data (data)     
        
  );
    

endmodule
