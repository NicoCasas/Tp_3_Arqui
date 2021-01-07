`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////


module top_todo
#(
    parameter   PERIODO = 200                       ,
    parameter   F_CLOCK = 1000000000/PERIODO        ,   
    parameter   NB_OPCODE           = 5             ,
    parameter   NB_INSTRUCTION      = 16            ,
    parameter   NB_ADDRESS          = 11            ,
    parameter   NB_OPERAND          = 11            ,
    parameter   NB_DATA             = 16            ,
    parameter   NB_OP               = 6             
)
(//OUTPUTS    
    output wire [NB_DATA-1:0]      o_data       ,
    output wire                    o_valid      ,
    output wire                    o_locked     ,
 //INPUTS
    input wire                     i_clk        ,
    input wire                     i_reset      ,
    input wire                     i_reset_clk
);
    
    wire     data;
    wire     clk;

//CLOCK INSTANTIATION
clk_wiz_0 my_clock
 (
  // Clock out ports
  .clk_out1(clk),
  // Status and control signals
  .reset(i_reset_clk),
  .locked(o_locked),
 // Clock in ports
  .clk_in1(i_clk)
 );    
 
//MODULE INSTANTIATION
  top_con_tx
#(
 )
 u_top_con_tx
 (
    //OUTPUTS
    .o_data  (data)     ,
    //INPUTS
    .i_clk   (clk)    ,
    .i_reset (i_reset)      
    );
        
 rx_baudrate
#()
 u_rx_baudrate
 (
    //OUTPUTS
   .o_data(o_data)      ,
   .o_valid(o_valid)    ,
    //INPUTS
   .i_clk (clk)       ,
   .i_reset(i_reset)    ,
   .i_data(data)        
 );    
 
endmodule
