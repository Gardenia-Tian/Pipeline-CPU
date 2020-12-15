`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 19:25:14
// Design Name: 
// Module Name: Count_Addr
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

//其实就是计算跳转指令的地址
module Count_Addr(
    input [25:0] j_Addr_in,
    input [31:0] b_Addr_in,
    input [31:0] PC_Addr4_EX,
    output [31:0] j_Addr_EX1,
    output [31:0] b_Addr_EX
    );
    
    assign j_Addr_EX1 = {PC_Addr4_EX[31:28], j_Addr_in[25:0],2'b00};
    assign b_Addr_EX = PC_Addr4_EX + (b_Addr_in<<2);
    
endmodule
