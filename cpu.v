`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu
#(
    //PARAMETERS
    parameter                                   NB_OPCODE           = 5     ,
    parameter                                   NB_INSTRUCTION      = 16    ,
    parameter                                   NB_ADDRESS          = 11    ,
    parameter                                   NB_OPERAND          = 11    ,
    parameter                                   NB_DATA             = 16    ,
    parameter                                   NB_OP               = 6 
  )
  (
    //OUTPUTS
    output  wire [NB_ADDRESS-1:0]               o_pm_address        ,
    output  wire [NB_OPERAND-1:0]               o_dm_address        ,
    output  wire [NB_DATA-1   :0]               o_dm_data           ,
    output  wire                                o_wr_Ram            ,
    output  wire                                o_rd_Ram            , 
    output  wire                                o_wr_PC             ,
    
    //INPUTS
    input   wire  [NB_INSTRUCTION  - 1 :0]      i_pm_instruction    ,
    input   wire  [NB_DATA-1:0]                 i_dm_data           ,
    input   wire                                i_clk               ,
    input   wire                                i_reset              
  );
  
  
  //INTERNAL REGS & WIRES
  wire [NB_ADDRESS-1:0]         pm_address        ;
  wire [NB_ADDRESS-1:0]         dm_address        ;
  wire [NB_DATA-1   :0]         dm_data           ;    
  wire                          wr_PC             ;
  wire [1:0]                    selA              ;
  wire                          selB              ;
  wire                          wr_Acc            ;
  wire                          op                ;
  wire                          wr_Ram            ;
  wire                          rd_Ram            ;
  wire [NB_OPCODE-1:0]          opcode            ;
  wire [NB_OPERAND-1:0]         operand           ;
  
  //OUTPUT ASSIGN
  assign o_dm_address = dm_address                          ;
  assign o_dm_data    = dm_data                             ;
  assign o_pm_address = pm_address                          ;
  assign o_wr_Ram     = wr_Ram                              ;
  assign o_rd_Ram     = rd_Ram                              ;
  assign o_wr_PC      = wr_PC                               ;
  
  //MODULE INSTANTIATION
  
  //Control
  control
#(
    //Parameters
    .NB_OPCODE      (NB_OPCODE)         ,
    .NB_INSTRUCTION (NB_INSTRUCTION)    ,
    .NB_ADDRESS     (NB_ADDRESS)        ,
    .NB_OPERAND     (NB_OPERAND)   
  )
  control
    (
    //Outputs
    .o_pm_address(pm_address)               ,
    .o_operand(operand)                     ,
    .o_selA(selA)                           ,
    .o_selB(selB)                           ,
    .o_wr_Acc(wr_Acc)                       ,
    .o_op(op)                               ,
    .o_wr_Ram(wr_Ram)                       ,
    .o_rd_Ram(rd_Ram)                       ,
    .o_wr_PC    (wr_PC)                     ,   
    
    //Inputs
    .i_pm_instruction(i_pm_instruction)     ,
    .i_clk(i_clk)                           ,
    .i_reset(i_reset)                                     
  );
  
  datapath
#(//PARAMETERS
   .NB_DATA             (NB_DATA)               ,
   .NB_DATA_IN          (NB_OPERAND)            ,
   .NB_EXTENDED_DATA    (NB_DATA)               ,
   .NB_OP               (NB_OP)
  )
  u_datapath
  (//OUTPUTS
   .o_dm_data           (dm_data)               ,
   .o_dm_address        (dm_address)            ,           
   //INPUTS
   .i_clk               (i_clk)                 ,
   .i_reset             (i_reset)               ,    
   .i_data              (operand)               ,
   .i_selA              (selA)                  ,
   .i_selB              (selB)                  ,
   .i_wr_Acc            (wr_Acc)                ,
   .i_op                (op)                    ,
   .i_dm_data           (i_dm_data)    
  );
  

endmodule
