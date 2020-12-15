`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 19:19:36
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
    input CLK,
    input keep,
    input Reset,
    input RegWre_EX,
    input mRD_EX,
    input mWR_EX,
    input [1:0] WrRegDSrc_EX,
    input [4:0] DstReg_EX,
    input [31:0] DataA_EX,
    input [31:0] DataB_EX,
    input [31:0] Jump_PC_EX,
    input [31:0] ALUResult_EX,
    input [31:0] PC_Addr4_EX,
    input Zero_EX,
    input Sign_EX,
    input OF_EX,
    output reg RegWre_MEM,
    output reg mRD_MEM,
    output reg mWR_MEM,
    output reg [1:0] WrRegDSrc_MEM,
    output reg [4:0] DstReg_MEM,
    output reg [31:0] DataA_MEM,
    output reg [31:0] DataB_MEM,
    output reg [31:0] Jump_PC_MEM,
    output reg [31:0] ALUResult_MEM,
    output reg [31:0] PC_Addr4_MEM,
    output reg Zero_MEM,
    output reg Sign_MEM,
    output reg OF_MEM
    );
    initial begin
        RegWre_MEM <= 0;
        mRD_MEM <= 0;
        mWR_MEM <=0;
        WrRegDSrc_MEM <=0;
        DstReg_MEM <=0;
        DataA_MEM <=0;
        DataB_MEM <=0;
        Jump_PC_MEM <=0;
        //Branch_PC_MEM <=0;
        ALUResult_MEM <=0;
        PC_Addr4_MEM <= 0;
        Zero_MEM <=0;
        Sign_MEM <=0; 
        OF_MEM <=0;    
    end
    
    always@(negedge CLK) begin
        if(!Reset) begin
            RegWre_MEM <= 0;
            mRD_MEM <= 0;
            mWR_MEM <=0;
            WrRegDSrc_MEM <=0;
            DstReg_MEM <=0;
            DataA_MEM <=0;
            DataB_MEM <=0;
            Jump_PC_MEM <=0;
            //Branch_PC_MEM <=0;
            ALUResult_MEM <=0;
            PC_Addr4_MEM <=0;
            Zero_MEM <=0;
            Sign_MEM <=0; 
            OF_MEM <=0;             
        end
        else if(keep) begin
            RegWre_MEM <= RegWre_MEM;
            mRD_MEM <= mRD_MEM;
            mWR_MEM <= mWR_MEM;
            WrRegDSrc_MEM <=WrRegDSrc_MEM;
            DstReg_MEM <=DstReg_MEM;
            DataA_MEM <=DataA_MEM;
            DataB_MEM <=DataB_MEM;
            Jump_PC_MEM <=Jump_PC_MEM;
            //Branch_PC_MEM <=Branch_PC_EX;
            ALUResult_MEM <=ALUResult_MEM;
            PC_Addr4_MEM <=PC_Addr4_MEM;
            Zero_MEM <=Zero_MEM;
            Sign_MEM <=Sign_MEM; 
            OF_MEM <=OF_MEM;            
        end
        else begin
            RegWre_MEM <= RegWre_EX;
            mRD_MEM <= mRD_EX;
            mWR_MEM <= mWR_EX;
            WrRegDSrc_MEM <=WrRegDSrc_EX;
            DstReg_MEM <=DstReg_EX;
            DataA_MEM <=DataA_EX;
            DataB_MEM <=DataB_EX;
            Jump_PC_MEM <=Jump_PC_EX;
            //Branch_PC_MEM <=Branch_PC_EX;
            ALUResult_MEM <=ALUResult_EX;
            PC_Addr4_MEM <=PC_Addr4_EX;
            Zero_MEM <=Zero_EX;
            Sign_MEM <=Sign_EX; 
            OF_MEM <=OF_EX;             
        end
    end
endmodule
