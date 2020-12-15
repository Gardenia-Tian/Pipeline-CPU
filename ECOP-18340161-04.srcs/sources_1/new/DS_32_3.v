`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 11:09:11
// Design Name: 
// Module Name: DS_32_3
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


module DS_32_4(
    input [1:0] select,
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    output reg [31:0] res
    );
    always@(*) begin
        if(select==2'b00) res = a;
        else if(select==2'b01) res = b;
        else if(select==2'b10) res = c;
        else res = d;
    end
endmodule
