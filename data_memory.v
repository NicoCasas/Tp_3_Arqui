`timescale 1ns / 1ps

module data_mamory
#(
    //Parameters
    parameter                                  NB_DATA         = 16 ,
    parameter                                  NB_ADDR         = 11 ,
    parameter                                  N_DATOS         = 8  
  )
  (
    //Inputs
    input   wire [NB_ADDR  - 1 :0]             i_address           ,
    input   wire [NB_DATA  - 1 :0]             i_data              ,
    input   wire                               i_wr                ,
    input   wire                               i_rd                ,
    input   wire                               i_clk               ,
    input   wire                               i_reset             ,
    //Outputs
    output  wire signed [NB_DATA  - 1 :0]      o_data                  
  );
  
  //Internal regs and wires
//  reg            [NB_DATA-1:0]           next_o_data                        ;
  reg            [NB_DATA-1:0]           reg_o_data                         ;
//  reg            [NB_DATA*N_DATOS-1:0]   next_data                          ;
//  reg            [NB_DATA*N_DATOS-1:0]   reg_data                           ;
  reg            [NB_DATA-1:0]           array_data          [N_DATOS-1:0]  ;
//  reg            [NB_DATA-1:0]           next_array_data     [N_DATOS-1:0]  ;
  reg            [NB_ADDR  - 1 :0]       reg_addr                           ;
  wire           [NB_ADDR-1:0]           masked_addr                        ;   
//  wire           [NB_ADDR-1:0]           addr_mask                          ;
                           
//  assign addr_mask = i_address & 11'b111;
  assign masked_addr = i_address & 11'b111;
     
  always @(posedge i_clk) begin
    
    if(i_rd) begin
        reg_o_data                      <= array_data[masked_addr]  ; 
    end
    else begin
        if(i_wr)
            array_data[masked_addr]     <= i_data                   ;
        else
            reg_o_data <= {NB_DATA-1{1'b0}};
    end
    
  end
 

//  always @(posedge i_clk) begin
// //     if(i_reset) begin
// //       reg_data    <= {NB_DATA*16{1'b0}}       ;        
// //       reg_o_data  <= {NB_DATA{1'b0}}          ;
// //       end
// //     else begin  
//        reg_data    <= next_data                                        ;
//        reg_o_data  <= next_o_data                                      ;
// //     end
//  end
        
     
  
//  always @(*) begin
//    next_data   = reg_data      ;
//    next_o_data = reg_o_data    ;
           
//    if((i_wr&&i_rd)==1'b0) begin
//        reg_addr = i_address & 11'b1111; 
        
//        if(i_rd) begin
//            next_o_data =  reg_data[NB_DATA*reg_addr+:NB_DATA];
//        end
//        else begin
//            if(i_wr) begin
//                next_data[(NB_DATA*reg_addr)+:NB_DATA] = i_data;
//            end
//            else next_o_data = {NB_DATA{1'b0}};
            
//        end
//    end
    
    
//  end

//Output assign
assign o_data   = reg_o_data;

endmodule