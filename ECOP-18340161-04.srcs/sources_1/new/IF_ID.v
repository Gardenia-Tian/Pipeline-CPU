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
    input stall,//���ڽ������ð�յĲ����ź�
    input IRWre,
    input BR,
    input keep,
    input [31:0] PC_add4_IF,
    input [31:0] Instruction_IF,
    output reg [31:0] PC_add4_ID,   //������̾��Ѿ�������һ���洢��Ԫ����������ģ���ڶ����ˣ�
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
        else if(stall || keep) begin           //һ�������������źű���
            PC_add4_ID <= PC_add4_ID;
            Instruction_ID <= Instruction_ID;       
        end
        else if(IRWre) begin          //������������Ǿ�д��
            PC_add4_ID <= PC_add4_IF;
            Instruction_ID <= Instruction_IF;
        end
        else begin                   //������Ҳ��д�룬�ͱ���
            PC_add4_ID <= PC_add4_IF;
            Instruction_ID <= Instruction_IF;
        end
                
    end
endmodule
