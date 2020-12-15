`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 19:39:13
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUop,
    output reg zero,
    output sign,
    output reg OF,
    output reg [31:0] result
    );
   
  //  assign zero = (result==0);//零标志位标志结果是否为零
    assign sign = result[31];
   
    initial begin
        OF = 0;
    end
           
    always@(*)
        begin
           case(ALUop)
               3'b000 :
               begin
                   result = A + B;
                   OF = (A[31]^B[31]) ? 1'b0 : (result[31]^A[31]) ? 1'b1 : 1'b0;
                   zero = (result==0);
               end
               3'b001 :
               begin
                   result = A - B;
                   OF = (A[31]==B[31]) ? 1'b0 : (result[31]!=A[31]) ? 1'b1 : 1'b0 ;
                   zero = (result==0);
               end               
               3'b010 :
               begin
                   result = B << A;
                   OF = B[31]^result[31];
                   zero = (result==0);
               end               
               3'b011 : 
               begin
                   result = A | B;
                   OF = 0;
                   zero = (result==0);
               end
               3'b100 :
               begin
                   result = A & B;
                   OF = 0;
                   zero = (result==0);
               end
               3'b101 : 
               begin
                   result = (A<B) ? 1 : 0;
                   OF = 0;
                   zero = (result==0);
               end
               3'b110 :
               begin
                   result = (((A[31]==B[31])&&(A<B))||(A[31]==1&&B[31]==0))?1:0;
                   OF = 0;
                   zero = (result==0);
               end
               3'b111 ://改成和0比较
               begin
                   result = (B==0);
                   OF = (result!=0);//此时OF不再代表溢出，仅仅是一个标志位
                   zero = (result==0);//zero==0 则说明成立
               end
               default: 
               begin
                   result = 32'h00000000;
                   OF = 0;
                   zero = (result==0);
               end
           endcase
       end    
         
endmodule
