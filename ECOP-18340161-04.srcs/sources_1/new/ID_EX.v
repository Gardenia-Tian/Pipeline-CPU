`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 16:50:10
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input CLK,
    input Reset,
    input BR,
    input keep,
    input [31:0] DataA_ID,
    input [31:0] DataB_ID,
    input [31:0] PC_Addr4_ID,
    input [31:0] imm_ID,
    input [25:0] j_Addr_ID,
    input stall,
    input ALUSrcA_ID,
    input ALUSrcB_ID,
    input RegWre_ID,
    input mRD_ID,
    input mWR_ID,
    input [1:0] PCSrc,
    input [1:0] WrRegDSrc_ID,
    input [2:0] ALUop_ID,
    input [4:0] DstReg_ID,
    input [4:0] sa_ID,
    input [4:0] Rs_ID,
    input [4:0] Rt_ID,
    input [5:0] op_ID,
    output reg [31:0] DataA_EX,
    output reg [31:0] DataB_EX,
    output reg [31:0] PC_Addr4_EX,
    output reg [31:0] imm_EX,
    output reg [25:0] j_Addr_EX,
    output reg ALUSrcA_EX,
    output reg ALUSrcB_EX,
    output reg RegWre_EX,
    output reg mRD_EX,
    output reg mWR_EX,
    output reg [1:0] PCSrc_EX,
    output reg [2:0] ALUop_EX,
    output reg [1:0] WrRegDSrc_EX,
    output reg [4:0] DstReg_EX,
    output reg [4:0] sa_EX,
    output reg [4:0] Rs_EX,
    output reg [4:0] Rt_EX,
    output reg [5:0] op_EX,
    output reg [1:0] PCSRC_EX_NOT_CLEAR
    );
    
    initial begin
        DataA_EX <= 32'b0;
        DataB_EX <= 32'b0;
        PC_Addr4_EX <= 32'b0;
        imm_EX <= 32'b0;
        j_Addr_EX <= 26'b0;
        ALUSrcA_EX <= 0;
        ALUSrcB_EX <= 0;
        RegWre_EX <= 0;
        mRD_EX <= 0;
        mWR_EX <= 0;
        PCSrc_EX <= 2'b0;
        ALUop_EX <= 3'b0;
        WrRegDSrc_EX <= 2'b0;
        DstReg_EX <= 5'b0;
        sa_EX <= 5'b0;
        Rs_EX <= 5'b0;
        Rt_EX <= 5'b0;
        op_EX <= 6'b0;
        //PCSRC_EX_NOT_CLEAR <= 2'b0;
    end
    
    //assign PCSRC_EX_NOT_CLEAR = PCSrc;
    
    always@(negedge CLK)
    begin
        if(!Reset || BR) begin
            DataA_EX <= 32'b0;
            DataB_EX <= 32'b0;
            PC_Addr4_EX <= 32'b0;
            imm_EX <= 32'b0;
            j_Addr_EX <= 26'b0;
            ALUSrcA_EX <= 0;
            ALUSrcB_EX <= 0;
            RegWre_EX <= 0;
            mRD_EX <= 0;
            mWR_EX <= 0;
            PCSrc_EX <= 2'b0;
            ALUop_EX <= 3'b0;
            WrRegDSrc_EX <= 2'b0;
            DstReg_EX <= 5'b0;
            sa_EX <= 5'b0;
            Rs_EX <= 5'b0;
            Rt_EX <= 5'b0;
            op_EX <= 6'b0;
            PCSRC_EX_NOT_CLEAR <= PCSrc;
        end
        else if(stall || keep) begin
            DataA_EX <= DataA_EX;
            DataB_EX <= DataB_EX;
            PC_Addr4_EX <= PC_Addr4_EX;
            imm_EX <= imm_EX;
            j_Addr_EX <= j_Addr_EX;
            ALUSrcA_EX <= ALUSrcA_EX;
            ALUSrcB_EX <= ALUSrcB_EX;
            RegWre_EX <= RegWre_EX;
            mRD_EX <= mRD_EX;
            mWR_EX <= mWR_EX;
            PCSrc_EX <= PCSrc_EX;
            ALUop_EX <= ALUop_EX;
            WrRegDSrc_EX <= WrRegDSrc_EX;
            DstReg_EX <= DstReg_EX;
            sa_EX <= sa_EX;
            Rs_EX <= Rs_EX;
            Rt_EX <= Rt_EX; 
            op_EX <= op_EX;    
            PCSRC_EX_NOT_CLEAR <= PCSrc; 
        end
        else begin
            DataA_EX <= DataA_ID;
            DataB_EX <= DataB_ID;
            PC_Addr4_EX <= PC_Addr4_ID;
            imm_EX <= imm_ID;
            j_Addr_EX <= j_Addr_ID;
            ALUSrcA_EX <= ALUSrcA_ID;
            ALUSrcB_EX <= ALUSrcB_ID;
            RegWre_EX <= RegWre_ID;
            mRD_EX <= mRD_ID;
            mWR_EX <= mWR_ID;
            PCSrc_EX <= PCSrc;
            ALUop_EX <= ALUop_ID;
            WrRegDSrc_EX <= WrRegDSrc_ID;
            DstReg_EX <= DstReg_ID;
            sa_EX <= sa_ID;
            Rs_EX <= Rs_ID;
            Rt_EX <= Rt_ID;
            op_EX <= op_ID;
            PCSRC_EX_NOT_CLEAR <= PCSrc;
        end
    end
    
    
endmodule
