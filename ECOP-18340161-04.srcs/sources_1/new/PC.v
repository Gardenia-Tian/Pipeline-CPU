`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 15:58:34
// Design Name: 
// Module Name: PC
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


module PC(
    input keep,
    input [31:0] newPC,
    input CLK,
    input stall,
    input Reset,
    input PCWre,
    output reg [31:0] Instr_Addr
    );
    
    initial begin
        Instr_Addr = 32'h0;
    end
    
    always@(negedge Reset or negedge CLK)
    begin
        if(Reset==0)//如果要清零的话，PC值全部赋为0
            Instr_Addr[31:0] <= 32'h00000000;
        else if(PCWre && !keep)//如果PC的写使能为真，那么就要写入新的PC
            Instr_Addr[31:0] <= newPC;
    end
endmodule
