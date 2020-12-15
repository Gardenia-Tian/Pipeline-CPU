`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/08 15:09:43
// Design Name: 
// Module Name: HazardDetect_Unit
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


module HazardDetect_Unit(
    input mRD_EX,
    input [4:0] DstReg_EX,
    input [4:0] Rs_ID,
    input [4:0] Rt_ID,
    output reg stall
    );
    
    always@(*) begin
        if(mRD_EX && ((DstReg_EX==Rs_ID)||(DstReg_EX==Rt_ID)))
            stall = 1'b1;
        else
            stall = 1'b0;
    end
    
endmodule
