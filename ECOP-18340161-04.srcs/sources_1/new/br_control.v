`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/08 19:15:14
// Design Name: 
// Module Name: br_control
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


module br_control(
    input [5:0] op_EX,
    input [1:0] PCSrc_EX,
    input Sign_EX,
    input Zero_EX,
    output reg BR
    );
    
    parameter BEQ = 6'b000100;
    parameter BNE = 6'b000101;
    parameter BLTZ = 6'b000001;    
    
    
    always@(*) begin
        if(PCSrc_EX == 2'b01) begin
           BR = (op_EX==BEQ&&Zero_EX==1)?1'b1:(op_EX==BNE&&Zero_EX==0)?1'b1:(op_EX==BLTZ&&Sign_EX==1)?1'b1:1'b0;
        end
        else if(PCSrc_EX != 2'b00) begin
            BR = 1'b1;
        end
        else begin
            BR = 1'b0;
        end
    end
endmodule
