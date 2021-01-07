`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module tx_baudrate
#(//PARAMETERS
    parameter NB_DATA = 16,
    parameter F_CLOCK = 25000000
 )
 (
    //OUTPUTS
    output wire                     o_data    ,
    //INPUTS
    input wire                      i_clk     ,
    input wire                      i_reset   ,
    input wire  [NB_DATA-1:0]       i_data    ,
    input wire                      i_valid
    
 );
    
 //REGS & WIRES
    wire                    tick    ;  

//MODULE INSTANTIATION
  //BAUDRATE  
  baudrate
  #(                    
        .F_CLOCK(F_CLOCK) 
  )
  u1_baudrate      
  (
        .o_tick     (tick)                        ,
        .i_clk      (i_clk)                       ,
        .i_reset    (i_reset)                       
  );
  
//TRANSMISOR  
transmisor
#(
    //PARAMETERS
        .NB_DATA(NB_DATA)
 )
 u_transmisor
 (
    //OUTPUTS
        .o_data (o_data)                           ,
    //INPUTS
        .i_clk  (i_clk)                            ,
        .i_reset(i_reset)                          ,
        .i_tick (tick)                             ,
        .i_valid(i_valid)                          ,       
        .i_data (i_data)     
        
  );
    

endmodule
