`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 16:32:37
// Design Name: 
// Module Name: Instruction_Divided
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


module Instruction_Divided(
    input [31:0] Instruction,
    output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] sa,
    output [5:0] func,
    output [15:0] imm,
    output [27:2] j_Addr
    );
    assign op[5:0] = Instruction[31:26];
    assign rs[4:0] = Instruction[25:21];
    assign rt[4:0] = Instruction[20:16];
    assign rd[4:0] = Instruction[15:11];
    assign sa[4:0] = Instruction[10:6];
    assign func[5:0] = Instruction[5:0];
    assign imm[15:0] = Instruction[15:0];
    assign j_Addr[27:2] = Instruction[25:0];
    
endmodule
