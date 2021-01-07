`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module top
#(
    //PARAMETERS
    parameter                                   NB_OPCODE           = 5     ,
    parameter                                   NB_INSTRUCTION      = 16    ,
    parameter                                   NB_ADDRESS          = 11    ,
    parameter                                   NB_OPERAND          = 11    ,
    parameter                                   NB_DATA             = 16    ,
    parameter                                   NB_OP               = 6     ,
    parameter                                   N_DATA              = 8
  )
  (
    //OUTPUTS
    output  wire [NB_DATA-1   :0]               o_resultado_final   ,
    output  wire                                o_valid             ,
    
    //INPUTS
    input   wire                                i_clk               ,
    input   wire                                i_reset              
  );
  
  
  //INTERNAL REGS & WIRES
  wire [NB_ADDRESS-1:0]         pm_address        ;
  wire [NB_INSTRUCTION-1:0]     pm_instruction    ;
  wire [NB_ADDRESS-1:0]         dm_address        ;
  wire [NB_DATA-1   :0]         dm_data_wr        ;
  wire [NB_DATA-1   :0]         dm_data_rd        ;    
  wire                          wr_PC             ;
  wire [1:0]                    selA              ;
  wire                          selB              ;
  wire                          wr_Acc            ;
  wire                          op                ;
  wire                          wr_Ram            ;
  wire                          rd_Ram            ;
  wire [NB_OPCODE-1:0]          opcode            ;
  reg                           valid             ;
  reg                           done              ;
  
  //SECUENTIAL LOGIC
  always @(posedge i_clk) begin
    if(i_reset) begin
        done  <= 1'b0;
        valid <= 1'b0;
    end
    else if(~wr_PC) begin
            if(~done) begin
                 done  <= 1'b1;
                 valid <= 1'b1;
            end
            else valid <= 1'b0;
    end            
  end
  
  //OUTPUT ASSIGN
  assign o_resultado_final  = dm_data_wr           ;
  assign o_valid            = valid                ;
  
  
  //MODULE INSTANTIATION
  
  //Cpu
  cpu
#(
    //PARAMETERS
    .NB_OPCODE      (NB_OPCODE)             ,
    .NB_INSTRUCTION (NB_INSTRUCTION)        ,
    .NB_ADDRESS     (NB_ADDRESS)            ,
    .NB_OPERAND     (NB_OPERAND)            ,
    .NB_DATA        (NB_DATA)               ,
    .NB_OP          (NB_OP)                
  )
  cpu
  (
    //OUTPUTS
    .o_pm_address   (pm_address)            ,
    .o_dm_address   (dm_address)            ,
    .o_dm_data      (dm_data_wr)            ,
    .o_wr_Ram       (wr_Ram)                ,
    .o_rd_Ram       (rd_Ram)                ,
    .o_wr_PC        (wr_PC)                 , 
    
    //INPUTS
    .i_pm_instruction   (pm_instruction)    ,
    .i_dm_data          (dm_data_rd)        ,
    .i_clk              (i_clk)             ,
    .i_reset            (i_reset)            
  );

  //Program memory
  program_memory
#(
    //Parameters
    .NB_INSTRUCTION     (NB_INSTRUCTION)    ,  
    .NB_ADDRESS         (NB_ADDRESS)        
  )
  program_memory
  (
    //Outputs
    .o_instruction      (pm_instruction)    ,    
    //Inputs
    .i_address          (pm_address)        ,
    .i_clk              (i_clk)             ,
    .i_reset            (i_reset)
    
  );
  
  //Data Memoria
  data_mamory
#(
    //Parameters
    .NB_DATA            (NB_DATA)           ,
    .NB_ADDR            (NB_ADDRESS)        ,
    .N_DATOS            (N_DATA)            
  )
  data_memory
  (
    //Inputs
    .i_clk              (i_clk)             ,
    .i_reset            (i_reset)           ,
    .i_address          (dm_address)        ,
    .i_data             (dm_data_wr)        ,
    .i_wr               (wr_Ram)            ,
    .i_rd               (rd_Ram)            ,
    //Outputs
    .o_data             (dm_data_rd)             
  );

endmodule
