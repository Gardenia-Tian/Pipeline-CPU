`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 20:37:03
// Design Name: 
// Module Name: add_const
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


module add_const(
    input [31:0] in,
    output reg [31:0] out
    );
    
    initial begin
        out = 32'h4;
    end
    
    always@(*) begin
        out = in + 32'h4;
    end
endmodule
