`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 17:11:28
// Design Name: 
// Module Name: data_select_5_3
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


module data_select_5_3(
    input [1:0] DstRegSelect,
    input [4:0] Rt,
    input [4:0] Rd,
    output reg [4:0] DstReg
    );
    
    always@(*) begin
        if(DstRegSelect==2'b00) DstReg = 5'h1f;
        else if(DstRegSelect==2'b01) DstReg = Rt;
        else if(DstRegSelect==2'b10) DstReg = Rd;
        else DstReg = 4'b00;
    end  
endmodule
