`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module instruction_decoder
#(
    //PARAMETERS
    parameter                                  NB_OPCODE           = 5
  )
  (
    //OUTPUTS
    output  wire                         o_wr_PC     ,
    output  wire [1 :0]                  o_selA      ,
    output  wire                         o_selB      ,
    output  wire                         o_wr_Acc    ,
    output  wire                         o_op        ,
    output  wire                         o_wr_Ram    ,
    output  wire                         o_rd_Ram    ,

    //INPUTS
    input   wire [NB_OPCODE  - 1 :0]     i_opcode    
          
  );
  
  
  //INTERNAL REGS & WIRES
  reg                         reg_wr_PC         ;
  reg [1 :0]                  reg_selA          ;
  reg                         reg_selB          ;
  reg                         reg_wr_Acc        ;
  reg                         reg_op            ;
  reg                         reg_wr_Ram        ;
  reg                         reg_rd_Ram        ;
  
  //COMBINATIONAL LOGIC
  always @(*) begin : instruction_decoder
    case (i_opcode)
        5'b00000:   begin                       //Halt
                        reg_wr_PC   = 1'b0  ;
                        reg_selA    = 2'b0  ;
                        reg_selB    = 1'b0  ;
                        reg_wr_Acc  = 1'b0  ;
                        reg_op      = 1'b0  ;
                        reg_wr_Ram  = 1'b0  ;
                        reg_rd_Ram  = 1'b0  ;   
                    end
        5'b00001:   begin                       //Store Variable
                        reg_wr_PC   = 1'b1  ;
                        reg_selA    = 2'b0  ;
                        reg_selB    = 1'b0  ;
                        reg_wr_Acc  = 1'b0  ;
                        reg_op      = 1'b0  ;
                        reg_wr_Ram  = 1'b1  ;
                        reg_rd_Ram  = 1'b0  ;   
                    end
                    
        5'b00010:   begin                       //Load Variable
                        reg_wr_PC   = 1'b1  ;
                        reg_selA    = 2'b0  ;
                        reg_selB    = 1'b0  ;
                        reg_wr_Acc  = 1'b1  ;
                        reg_op      = 1'b0  ;
                        reg_wr_Ram  = 1'b0  ;
                        reg_rd_Ram  = 1'b1  ;   
                    end
        5'b00011:   begin                       //Load Immediate
                        reg_wr_PC   = 1'b1  ;
                        reg_selA    = 2'b1  ;
                        reg_selB    = 1'b0  ;
                        reg_wr_Acc  = 1'b1  ;
                        reg_op      = 1'b0  ;
                        reg_wr_Ram  = 1'b0  ;
                        reg_rd_Ram  = 1'b0  ;   
                    end
        5'b00100:   begin                       //Add Variable
                        reg_wr_PC   = 1'b1  ;
                        reg_selA    = 2'b10 ;
                        reg_selB    = 1'b0  ;
                        reg_wr_Acc  = 1'b1  ;
                        reg_op      = 1'b0  ;
                        reg_wr_Ram  = 1'b0  ;
                        reg_rd_Ram  = 1'b1  ;   
                    end
        5'b00101:   begin                       //Add Immediate
                        reg_wr_PC   = 1'b1  ;
                        reg_selA    = 2'b10 ;
                        reg_selB    = 1'b1  ;
                        reg_wr_Acc  = 1'b1  ;
                        reg_op      = 1'b0  ;
                        reg_wr_Ram  = 1'b0  ;
                        reg_rd_Ram  = 1'b0  ;   
                    end
        5'b00110:   begin                       //Subtract Variable
                        reg_wr_PC   = 1'b1  ;
                        reg_selA    = 2'b10 ;
                        reg_selB    = 1'b0  ;
                        reg_wr_Acc  = 1'b1  ;
                        reg_op      = 1'b1  ;
                        reg_wr_Ram  = 1'b0  ;
                        reg_rd_Ram  = 1'b1  ;   
                    end
        5'b00111:   begin                       //Subtract Immediate
                        reg_wr_PC   = 1'b1  ;
                        reg_selA    = 2'b10 ;
                        reg_selB    = 1'b1  ;
                        reg_wr_Acc  = 1'b1  ;
                        reg_op      = 1'b1  ;
                        reg_wr_Ram  = 1'b0  ;
                        reg_rd_Ram  = 1'b0  ;   
                    end   
        default :   begin
                        reg_wr_PC   = 1'b0  ;
                        reg_selA    = 2'b0  ;
                        reg_selB    = 1'b0  ;
                        reg_wr_Acc  = 1'b0  ;
                        reg_op      = 1'b0  ;
                        reg_wr_Ram  = 1'b0  ;
                        reg_rd_Ram  = 1'b0  ;   
                    end
    endcase
    
  end

//OUTPUT ASSIGN
assign o_wr_PC  =   reg_wr_PC   ;
assign o_selA   =   reg_selA    ;
assign o_selB   =   reg_selB    ;
assign o_wr_Acc =   reg_wr_Acc  ;
assign o_op     =   reg_op      ;
assign o_wr_Ram =   reg_wr_Ram  ;
assign o_rd_Ram =   reg_rd_Ram  ;

endmodule
