`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// 
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module signal_extension
#(//PARAMETERS
   parameter    NB_DATA_IN          =   11                              ,
   parameter    NB_EXTENDED_DATA    =   16                              ,
   parameter    NB_DIFF             =   NB_EXTENDED_DATA - NB_DATA_IN
  )
  (//OUTPUTS
   output   wire   [NB_EXTENDED_DATA-1:0]   o_extended_data,
   //INPUTS 
   input    wire   [NB_DATA_IN-1:0]         i_data
  );
  
  //Output assign
   assign o_extended_data = {{NB_DIFF{i_data[NB_DATA_IN-1]}},i_data};
    
      
endmodule