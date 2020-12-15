`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/08 13:31:07
// Design Name: 
// Module Name: Forward_Unit
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


module Forward_Unit(
    input OF_MEM,
    input RegWre_WB,
    input [4:0] DstReg_WB,
    input RegWre_MEM,
    input [4:0] DstReg_MEM,
    input [4:0] Rs_EX,
    input [4:0] Rt_EX,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
    );
    
    always@(*) begin
        if(RegWre_MEM && DstReg_MEM!=0 && DstReg_MEM==Rs_EX && !OF_MEM) 
            forwardA = 2'b10;
        else if(RegWre_WB && DstReg_WB!=0 &&
            !(RegWre_MEM && (DstReg_MEM!=0) && (DstReg_MEM == Rs_EX)) &&
            DstReg_WB == Rs_EX && !OF_MEM) 
            forwardA = 2'b01;
        else 
            forwardA = 2'b00;
    end
    
    always@(*) begin
        if(RegWre_MEM && DstReg_MEM!=0 && DstReg_MEM==Rt_EX&&!OF_MEM)
            forwardB = 2'b10;
        else if(RegWre_WB && DstReg_WB!=0 &&
            !(RegWre_MEM && (DstReg_MEM!=0) && (DstReg_MEM ==Rt_EX)) &&
            DstReg_WB == Rt_EX&&!OF_MEM)
            forwardB = 2'b01;
        else 
            forwardB = 2'b00;
    end
    
endmodule
