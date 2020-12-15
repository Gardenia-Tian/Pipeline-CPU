`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 09:58:57
// Design Name: 
// Module Name: data_select_32_2
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


module data_select_32_2(
    input [1:0] forwardA,
    input [4:0] sa,
    input [31:0] Data1,
    input [31:0] ALUResult_MEM,
    input [31:0] res_WB,
    input ALUSrcA,
    output reg [31:0] ALUA_out
    );
    always@(*) begin
        if(forwardA==2'b00) begin
            if(ALUSrcA==0) ALUA_out = Data1;
            else ALUA_out = {27'b0,sa};
        end
        else if(forwardA==2'b10) begin
            ALUA_out = ALUResult_MEM;
        end
        else if(forwardA==2'b01) begin
            ALUA_out = res_WB;
        end

    end
    
endmodule
