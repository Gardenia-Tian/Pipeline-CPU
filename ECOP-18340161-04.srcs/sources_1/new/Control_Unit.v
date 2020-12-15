`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 20:43:32
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
    input [5:0] op,
    input [5:0] func,
    input zero,
    input sign,
    input OF,
    output reg PCWre,
    output reg ALUSrcA,
    output reg ALUSrcB,
    //output DBDataSrc,
    output reg RegWre,
    output reg [1:0] WrRegDSrc,
    output reg InsMemRw,
    output reg mRD,
    output reg mWR,
    output reg IRWre,
    output reg ExtSel,
    output reg [1:0] PCSrc,
    output reg [1:0] RegDst,
    output reg [2:0] ALUop
    );
    parameter ADD = 6'b100000;
    parameter SUB = 6'b100010;
    parameter AND = 6'b100100;
    parameter OR = 6'b100101;
    parameter SLL = 6'b000000;
    parameter ADDIU = 6'b001001;
    parameter ANDI = 6'b001100;
    parameter ORI = 6'b001101;
    parameter SLTI = 6'b001010;
    parameter SW = 6'b101011;
    parameter LW = 6'b100011;
    parameter BEQ = 6'b000100;
    parameter BNE = 6'b000101;
    parameter BLTZ = 6'b000001;
    parameter J = 6'b000010;
    parameter HALT = 6'b111111;
    parameter ADDI = 6'b001000;
    parameter SLT = 6'b101010;
    parameter MOVN = 6'b001011;
    parameter LHU = 6'b100101;
    parameter JR = 6'b001000;
    parameter JAL = 6'b000011;
    
    initial begin
        InsMemRw = 1;
        PCWre = 1;
        RegDst = 1;
        ALUop = 3'b000;
        PCSrc = 2'b00;
    end    
    
    always@(*)
    begin 
        if(op == 6'b000000)
        begin
            PCWre = 1;
            ALUSrcA = (func==SLL) ? 1'b1 : 1'b0;
            ALUSrcB = 0;
           // DBDataSrc = 0;
            RegWre = (func==JR) ? 1'b0 : (func==AND||func==OR||func==SLT) ? 1'b1 : (OF!=0) ? 1'b0 : 1'b1;
           // RegWre = (func==JR) ? 1'b0 : (func==AND||func==OR||func==SLT) ? 1'b1 :(func==MOVN&&zero==1)?1'b1:(func==MOVN&&zero==0)?1'b0: 1'b1;
            WrRegDSrc = (func==MOVN) ? 2'b10 : 2'b11;
            InsMemRw = 1;
            mRD = 0;
            mWR = 0;
            IRWre = 1;
            ExtSel = 0;
            PCSrc = (func==JR)?2'b10:2'b00;
            RegDst = 2'b10;
            ALUop = (func==SUB/*||func==MOVN*/)? 3'b001: (func==MOVN)? 3'b111 : (func==ADD) ? 3'b000 :(func==AND)?3'b100:(func==SLL)?3'b010:(func==OR)?3'b011:3'b110;
        end
        else
        begin
            PCWre = (op==HALT)?1'b0:1'b1;
            ALUSrcA = 0;
            ALUSrcB = (op==BEQ||op==BNE||op==BLTZ)?1'b0:1'b1;
           // DBDataSrc = (op==LW||op==LHU)?1'b1:1'b0;
            RegWre = (op==ANDI||op==ORI||op==SLTI||op==LW||op==SLT||op==JAL||op==ADDI)?1'b1:(op==SW||op==BEQ||op==BNE||op==BLTZ||op==J||op==HALT)?1'b0:(OF==0)?1'b1:1'b0;
            WrRegDSrc = (op==JAL)?2'b00:(op==LW||op==LHU)?2'b01:2'b11;
            InsMemRw = 1'b1;
            mRD = (op==LW||op==LHU)?1'b1:2'b0;
            mWR = (op==SW)?1'b1:1'b0;
            IRWre = 1;
            ExtSel = (op==ANDI||op==ORI)?1'b0:1'b1;
            //PCSrc = (op==J||op==JAL)?2'b11:(op==BEQ&&zero==1)?2'b01:(op==BNE&&zero==0)?2'b01:(op==BLTZ&&sign==1)?2'b01:2'b00;
            PCSrc = (op==J||op==JAL)?2'b11:(op==BEQ)?2'b01:(op==BNE)?2'b01:(op==BLTZ)?2'b01:2'b00;
            RegDst = (op==JAL)?2'b00:2'b01;
            ALUop = (op==ANDI)?3'b100:(op==ORI)?3'b011:(op==SLTI)?3'b110:(op==BEQ||op==BNE||op==BLTZ)?3'b001:3'b000;
        end
    end
endmodule