`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath
#(//PARAMETERS
   parameter    NB_DATA             =   16                          ,
   parameter    NB_DATA_IN          =   11                          ,
   parameter    NB_EXTENDED_DATA    =   16                          ,
   parameter    NB_DIFF             =   NB_EXTENDED_DATA - NB_DATA  ,
   parameter    NB_OP               =   6
  )
  (//OUTPUTS
   output   wire   [NB_EXTENDED_DATA-1:0]   o_dm_data       ,
   output   wire   [NB_DATA_IN-1:0]         o_dm_address    ,           
   //INPUTS
   input    wire                            i_clk           ,
   input    wire                            i_reset         ,    
   input    wire   [NB_DATA_IN-1:0]         i_data          ,
   input    wire   [1:0]                    i_selA          ,
   input    wire                            i_selB          ,
   input    wire                            i_wr_Acc        ,
   input    wire                            i_op            ,
   input    wire   [NB_DATA-1:0]            i_dm_data    
  );
  
  //LOCALPARAMS
  localparam        op_add = 6'b100_000    ;
  localparam        op_sub = 6'b100_010    ;
  
  //INTERNAL REGS & WIRES
  reg [NB_DATA-1:0] acumulador      ;
  reg [NB_DATA-1:0] nxt_acumulador  ;
  wire [NB_DATA-1:0] extended_data   ;
  wire[NB_DATA-1:0] alu_resultado   ;
  reg [NB_DATA-1:0] alu_dato_a      ;
  reg [NB_DATA-1:0] alu_dato_b      ;
  reg [NB_OP-1  :0] alu_op          ;
  
  //SECUENTIAL LOGIC
  always @(negedge i_clk) begin
    if      (i_reset)   acumulador <= {NB_DATA{1'b0}}    ;
    else if (i_wr_Acc)  acumulador <= nxt_acumulador     ;
  end
//  always @(posedge i_clk) begin
//    if(i_reset) acumulador <= {NB_DATA{1'b0}}    ;
//  end
  //COMBINATIONAL LOGIC
  //Multiplexor a la entrada del Acumulador
  always @(*) begin
    case(i_selA)
        2'b00:          nxt_acumulador = i_dm_data          ;
        2'b01:          nxt_acumulador = extended_data      ;
        2'b10:          nxt_acumulador = alu_resultado      ;
        default         nxt_acumulador = {NB_DATA{1'b0}}    ; 
    endcase
  end
  
  //Multiplexor lado derecho ALU
  always @(*) begin
    case(i_selB)
        1'b0:           alu_dato_b = i_dm_data          ;
        1'b1:           alu_dato_b = extended_data      ;
        default         alu_dato_b = {NB_DATA{1'b0}}    ; 
    endcase
  end  
  
  //Lado izquierdo ALU
  always @(*) begin
    alu_dato_a      =   acumulador;
  end

  //Op alu
  always @(*) begin
    case(i_op)
        1'b0:   alu_op = op_add         ;
        1'b1:   alu_op = op_sub         ;
        default:alu_op = {NB_OP{1'b0}}  ;
    endcase
   end
   
  //Data a data memory
  assign o_dm_data      =   acumulador  ; 
  assign o_dm_address   =   i_data      ;
      
  //MODULE INSTANTIATION
  //Alu
  alu #(
    .NB_DATA(NB_DATA),
    .NB_OP  (NB_OP)
  )
  alu
  (
    //OUTPUTS
    .o_data(alu_resultado),
    //INPUTS
    .i_a   (alu_dato_a),
    .i_b   (alu_dato_b),
    .i_op  (alu_op)  
    
   );
   
   
  //Signal Extension
  signal_extension#(
    .NB_DATA_IN         (NB_DATA_IN),
    .NB_EXTENDED_DATA   (NB_EXTENDED_DATA)
  )
  signal_extension
  (
    //OUTPUT
    .o_extended_data(extended_data),
    //INPUT
    .i_data         (i_data)
  );
      
endmodule