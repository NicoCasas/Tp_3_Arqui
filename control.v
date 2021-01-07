`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module control
#(
    //PARAMETERS
    parameter                                   NB_OPCODE           = 5     ,
    parameter                                   NB_INSTRUCTION      = 16    ,
    parameter                                   NB_ADDRESS          = 11    ,
    parameter                                   NB_OPERAND          = 11    
  )
  (
    //OUTPUTS
    output  wire [NB_ADDRESS-1:0]               o_pm_address        ,
    output  wire [NB_OPERAND-1:0]               o_operand           ,
    output  wire [1 :0]                         o_selA              ,
    output  wire                                o_selB              ,
    output  wire                                o_wr_Acc            ,
    output  wire                                o_op                ,
    output  wire                                o_wr_Ram            ,
    output  wire                                o_rd_Ram            , 
    output  wire                                o_wr_PC             ,
    
    //INPUTS
    input   wire [NB_INSTRUCTION  - 1 :0]       i_pm_instruction    ,
    input   wire                                i_clk               ,
    input   wire                                i_reset              
  );
  
  
  //INTERNAL REGS & WIRES
  reg  [NB_ADDRESS-1:0]         pc                ;
  wire [NB_ADDRESS-1:0]         nxt_pc            ; 
  wire                          wr_PC             ;
  wire [1:0]                    selA              ;
  wire                          selB              ;
  wire                          wr_Acc            ;
  wire                          op                ;
  wire                          wr_Ram            ;
  wire                          rd_Ram            ;
  wire [NB_OPCODE-1:0]          opcode            ;
  
  //COMBINATIONAL LOGIC
  assign nxt_pc = pc + {{NB_ADDRESS-1{1'b0}},1'b1}                ;
  assign opcode = i_pm_instruction[NB_INSTRUCTION-1-:NB_OPCODE]   ;
  
  //SECUENTIAL LOGIC
  always @(posedge i_clk) begin
    if      (i_reset)           pc = {NB_ADDRESS{1'b0}} ;
    else if (wr_PC  )           pc = nxt_pc             ;
  end

  //OUTPUT ASSIGN
  assign o_pm_address = pc                                  ;
  assign o_operand    = i_pm_instruction [0+:NB_OPERAND]    ;
  assign o_selA       = selA                                ;
  assign o_selB       = selB                                ;
  assign o_wr_Acc     = wr_Acc                              ;
  assign o_op         = op                                  ;
  assign o_wr_Ram     = wr_Ram                              ;
  assign o_rd_Ram     = rd_Ram                              ;
  assign o_wr_PC      = wr_PC                               ;
  
  //MODULE INSTANTIATION
  
  //Instruction Decoder
  instruction_decoder
#(
    //Parameters
    .NB_OPCODE(NB_OPCODE)
  )
  instruction_decoder
  (
    //Outputs
    .o_wr_PC    (wr_PC)     ,
    .o_selA     (selA)      ,
    .o_selB     (selB)      ,
    .o_wr_Acc   (wr_Acc)    ,
    .o_op       (op)        ,
    .o_wr_Ram   (wr_Ram)    ,
    .o_rd_Ram   (rd_Ram)    ,

    //Inputs
    .i_opcode   (opcode)    
          
  );
  

endmodule
