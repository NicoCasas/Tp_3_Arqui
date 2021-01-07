`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2020 19:10:13
// Design Name: 
// Module Name: testbench_signal_extension
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_signal_extension();
    localparam NB_DATA=11;
    localparam NB_EXTENDED_DATA=16;
    
    reg  signed [NB_DATA-1:0]          i_data;
    wire        [NB_EXTENDED_DATA-1:0] o_data;
    
    initial begin
        i_data = 0;
        #20
        i_data = 25;
        #20
        i_data = -25;
        #20
        $finish;
    end
    
    signal_extension 
    #(
        .NB_DATA            (NB_DATA)           ,
        .NB_EXTENDED_DATA   (NB_EXTENDED_DATA)
    )
    uut_signal_extension
    (
        .i_data(i_data)                         ,
        .o_extended_data(o_data)
    );
    
endmodule
