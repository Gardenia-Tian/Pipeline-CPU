`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 15:35:50
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
    input [31:0] Read_Address,
    input InsMemRw,
    output reg [31:0] Instruction
    );
    reg [7:0] memory[0:511];
    initial
        begin
           // Read_Address = 32'h0;
           // $readmemh("E:/InstructionsOfPipeLine.txt",memory);
           //$readmemh("E:/Instruction.txt",memory);
           $readmemh("E:/test.txt",memory);
        end
    always@(*)
        begin
            if(InsMemRw)
                begin
                    Instruction[7:0] <= memory[Read_Address + 3];
                    Instruction[15:8] <= memory[Read_Address + 2];
                    Instruction[23:16] <= memory[Read_Address + 1];
                    Instruction[31:24] <= memory[Read_Address + 0];
                end
        end
endmodule
