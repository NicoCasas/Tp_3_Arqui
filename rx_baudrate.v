`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module rx_baudrate
#(//PARAMETERS
    parameter   NB_DATA         =   16              ,
    parameter   NB_STOP         =   2               ,
    parameter   NB_STOP_TICKS   =   16 * NB_STOP    ,
    parameter   F_CLOCK         =   25000000
 )
 (
    //OUTPUTS
    output wire [NB_DATA-1:0]       o_data    ,
    output wire                     o_valid   ,
    //INPUTS
    input wire                      i_clk     ,
    input wire                      i_reset   ,
    input wire                      i_data        
 );
    
 //REGS & WIRES
    wire                    tick    ;  

//MODULE INSTANTIATION
  //BAUDRATE  
  baudrate
  #(                    
        .F_CLOCK(F_CLOCK) 
  )
  u_baudrate_2      
  (
        .o_tick     (tick)                        ,
        .i_clk      (i_clk)                       ,
        .i_reset    (i_reset)                       
  );
  
//TRANSMISOR  
receptor
#(
    //PARAMETERS
        .NB_DATA(NB_DATA)                           ,
        .NB_STOP(NB_STOP)                           ,
        .NB_STOP_TICKS(NB_STOP_TICKS)
 )
 u_receptor
 (
    //OUTPUTS
        .o_data (o_data)                           ,
        .o_valid(o_valid)                          ,
    //INPUTS
        .i_clk  (i_clk)                            ,
        .i_reset(i_reset)                          ,
        .i_tick (tick)                             ,       
        .i_rx (i_data)     
        
  );
    

endmodule
