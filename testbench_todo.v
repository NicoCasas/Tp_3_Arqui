`timescale 1ns / 1ps

module testbench_todo();
    //Params
    localparam   PERIODO = 100;
    localparam   F_CLOCK = 1000000000/PERIODO;
    localparam   NB_OPCODE           = 5             ;
    localparam   NB_INSTRUCTION      = 16            ;
    localparam   NB_ADDRESS          = 11            ;
    localparam   NB_OPERAND          = 11            ;
    localparam   NB_DATA             = 16            ;
    localparam   NB_OP               = 6             ;
        
    //Wires & Regs
    reg                     clk         ;
    reg                     reset       ;
    reg                     reset_clk   ;  
    wire [NB_DATA-1:0]      o_data      ;
    wire                    o_valid     ;
    wire                    locked      ;
    
    initial begin
        reset=1'b1;
        reset_clk=1'b1;
        clk=1'b0;
        #(2*PERIODO)
        
        
        while(locked!=1'b1) begin
           #10 
           reset     = 1'b0;
           reset_clk = 1'b0; 
        end
        
        #PERIODO
        reset = 1'b1;
        #(4*PERIODO)
        reset = 1'b0;
        
    end

    always begin
        #(PERIODO/2)
        clk = ~clk;
    end
    
    //MODULE INSTANTIATION
  top_todo
#(
 )
 uut_top_todo
 (
    //OUTPUTS
    .o_data  (o_data)           ,
    .o_valid (o_valid)          ,
    .o_locked(locked)           ,
    //INPUTS
    .i_clk   (clk)              ,
    .i_reset (reset)            ,
    .i_reset_clk (reset_clk)      
    );
       
    
    
endmodule
