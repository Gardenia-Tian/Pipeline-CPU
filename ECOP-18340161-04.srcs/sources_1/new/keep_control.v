`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/09 23:11:57
// Design Name: 
// Module Name: keep_control
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


module keep_control(
   // input CLK,
    input PCSRC_EX_NOT_CLEAR,
    input [5:0] op_EX,
    output reg keep
    );
    
    parameter HALT = 6'b111111;
    
    always@(*) begin
        if(/*PCSRC_EX_NOT_CLEAR==2'b00 &&*/ op_EX==HALT)
            keep = 1'b1;
        else
            keep = 1'b0;
    end
endmodule
