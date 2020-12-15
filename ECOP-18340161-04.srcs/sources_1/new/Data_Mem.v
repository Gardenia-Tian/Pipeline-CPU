`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 20:34:41
// Design Name: 
// Module Name: Data_Mem
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


module Data_Mem(
    input CLK,
    input [31:0] Data_in,
    input [31:0] Addr,
    input mRD,
    input mWR,
    output reg [31:0] Data_out
    );

    integer index;
    reg[7:0] dataMemory [0:255];//�������洢��


    //��ʼ��ʱ�򣬰��ڴ��ֵȫ����Ϊ��
    initial begin
	for(index = 0;index<256;index = index + 1)
	    dataMemory[index] = 0;
    end

    //�Ѷ��������ݸ�ֵΪ0��������������Ļ�������
    initial begin
        Data_out = 0;
    end

    //���ǹ涨�����д�Ļ�Ҫ��ʱ�ӣ���˷�ʽŶ
    always@(negedge CLK)
    begin
        if(mWR==1)
        begin
        dataMemory[Addr+3] <=Data_in[7:0];
        dataMemory[Addr+2] <=Data_in[15:8]; 
        dataMemory[Addr+1] <=Data_in[23:16];
        dataMemory[Addr+0] <=Data_in[31:24]; 
        end
    end

    //����Ƕ��Ļ�����Ҫ��ʱ�ӣ�ֻҪ��ַ�Ͷ�ʹ����Ч�Ϳ��Զ�
    always@(*)
    begin
        if(mRD==1)
        begin
            Data_out[7:0] <= dataMemory[Addr + 3];
            Data_out[15:8] <= dataMemory[Addr + 2];
            Data_out[23:16] <= dataMemory[Addr + 1];
            Data_out[31:24] <= dataMemory[Addr + 0];
        end
    end    
    
endmodule
