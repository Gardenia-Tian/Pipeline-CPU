`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 10:17:32
// Design Name: 
// Module Name: ALUSrcB_Select
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


module DS_32_2(
    input select,
    input [1:0] forwardB,
    input [31:0] a,
    input [31:0] b,
    input [31:0] ALUResult_MEM,
    input [31:0] res_WB,
    output reg [31:0] res
    );
    always@(*) begin
        if(forwardB==2'b00) begin
            if(select) res = a;
            else res = b;            
        end
        else if(forwardB==2'b10) begin
            if(select) res = a;
            else res = ALUResult_MEM;
        end
        else if(forwardB==2'b01) begin
            if(select) res = a;
            else res = res_WB;
        end
    end
endmodule
