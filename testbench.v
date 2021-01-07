`timescale 1ns / 1ps

module testbench();
    //Params
    localparam   PERIODO = 200;
    localparam   F_CLOCK = 1000000000/PERIODO;
    localparam   NB_OPCODE           = 5             ;
    localparam   NB_INSTRUCTION      = 16            ;
    localparam   NB_ADDRESS          = 11            ;
    localparam   NB_OPERAND          = 11            ;
    localparam   NB_DATA             = 16            ;
    localparam   NB_OP               = 6             ;
        
    //Wires & Regs
    reg                     clk     ;
    reg                     reset   ;
    wire                    data    ;
    wire [NB_DATA-1:0]      o_data  ;
    wire                    o_valid ;
    
    initial begin
        reset=1'b1;
        clk=1'b0;
        #200
        reset=1'b0;
    end

    always begin
        #(PERIODO/2)
        clk = ~clk;
    end
    
    //MODULE INSTANTIATION
  top_con_tx
#(
 )
 u_top_con_tx
 (
    //OUTPUTS
    .o_data  (data)   ,
    //INPUTS
    .i_clk   (clk)    ,
    .i_reset (reset)      
    );
        
 rx_baudrate
#()
 u_rx_baudrate
 (
    //OUTPUTS
   .o_data(o_data)    ,
   .o_valid(o_valid)   ,
    //INPUTS
   .i_clk (clk)    ,
   .i_reset(reset)   ,
   .i_data(data)        
 );    
    
    
endmodule
