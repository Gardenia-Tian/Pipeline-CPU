`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 09:07:24
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input CLK,
    input Reset,
    input stall,//关于解决竞争冒险的部分信号
    input IRWre,
    input BR,
    input keep,
    input [31:0] PC_add4_IF,
    input [31:0] Instruction_IF,
    output reg [31:0] PC_add4_ID,   //这个过程就已经定义了一个存储单元，不用再在模块内定义了；
    output reg [31:0] Instruction_ID
    );
    
    initial begin
        PC_add4_ID = 32'b0;
        Instruction_ID = 32'b0;
    end
    
    always@(negedge CLK)
    begin
        if(!Reset || BR) begin
            PC_add4_ID <= 32'h0;
            Instruction_ID <= 32'b0;
        end
        else if(stall || keep) begin           //一旦阻塞，立刻信号保持
            PC_add4_ID <= PC_add4_ID;
            Instruction_ID <= Instruction_ID;       
        end
        else if(IRWre) begin          //如果不阻塞，那就写入
            PC_add4_ID <= PC_add4_IF;
            Instruction_ID <= Instruction_IF;
        end
        else begin                   //不阻塞也不写入，就保持
            PC_add4_ID <= PC_add4_IF;
            Instruction_ID <= Instruction_IF;
        end
                
    end
endmodule
