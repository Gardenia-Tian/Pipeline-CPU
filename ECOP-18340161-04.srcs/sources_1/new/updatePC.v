`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 18:10:18
// Design Name: 
// Module Name: updatePC
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


module data_select_32_3(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    input BR,
    input [5:0] op_EX,
    input [1:0] select,
    input [1:0] PCSRC_EX_NOT_CLEAR,
    output reg [31:0] out
    //output reg keep
    );
    
    parameter HALT = 6'b111111;
    
    always@(*)
    begin
       if(BR && select==2'b01) begin
           // keep <= 1'b0;
            out <= d;
       end
       else if(select==2'b10) begin
           // keep <= 1'b0;
            out <= b;
       end
       else if(select==2'b11) begin
           // keep <= 1'b0;
            out <= c;
        end
        else if(select==2'b00 /*&& op_EX==HALT*/) begin
            out <= a;
           
             
        end
       /* else if(select==2'b00 && op_EX!=HALT)begin
             out <= a;  
             keep <= 1'b0;
        end   */
    end      
endmodule
