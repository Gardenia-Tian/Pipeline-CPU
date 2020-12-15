`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 20:00:50
// Design Name: 
// Module Name: PipeLineCPU
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


module PipeLineCPU(
    input Reset,
    input CLK,
    output [31:0] currPC,
    output [31:0] newPC,
    output [4:0] Rs,
    output [4:0] Rt,
    output [31:0] Rs_DATA,
    output [31:0] Rt_DATA,
    output [31:0] Result,
    output [31:0] Write_Data
    );
    wire [31:0] PC_Addr4;
    //wire [31:0] Branch_PC_MEM;
    wire [31:0] Jump_PC_MEM;
    wire PCWre;
    wire [1:0] PCSrc;
    wire InsMemRw;
    wire [31:0] Instruction;
    wire stall;
    wire IRWre;
    wire [31:0] Instruction_ID;
    wire [31:0] PC_add4_ID;
    wire [5:0] op;
    wire [4:0] rd;
    wire [4:0] sa;
    wire [5:0] func;
    wire [15:0] imm;
    wire [27:2] j_Addr;
    wire [1:0] DstRegSelect;
    wire [4:0] Dst_Reg_ID;
    wire Zero_MEM;
    wire Sign_MEM;
    wire OF_MEM;
    wire ALUSrcA_ID;
    wire ALUSrcB_ID;
    wire RegWre_ID;
    wire [1:0] WrRegDSrc_ID;
    wire ExtSel;
    wire [2:0] ALUop_ID;
    wire mRD_ID;
    wire mWR_ID;
    wire [31:0] imm_ID;
    wire RegWre_WB;
    wire [4:0] Dst_Reg_WB;
    //wire [31:0] Read_Data1_ID;
    //wire [31:0] Read_Data2_ID;
    wire [31:0] DataA_EX;
    wire [31:0] DataB_EX;
    wire [31:0] PC_Addr4_EX;
    wire [31:0] imm_EX;
    wire ALUSrcA_EX;
    wire ALUSrcB_EX;
    wire RegWre_EX;
    wire mRD_EX;
    wire mWR_EX;
    wire [4:0] sa_EX;
    wire [2:0] ALUop_EX;
    wire [1:0] WrRegDSrc_EX;
    wire [4:0] DstReg_EX;
    wire [25:0] j_Addr_EX;
    wire [31:0] j_Addr_EX1;
    wire [31:0] b_Addr_EX;
    wire [31:0] ALUA;
    wire [31:0] ALUB;
    wire Zero_EX;
    wire Sign_EX;
    wire OF_EX;
    wire [4:0] Rs_EX;
    wire [4:0] Rt_EX;
    wire [1:0] PCSrc_EX;
    wire [5:0] op_EX;
   // wire [31:0] Result_EX;
    //wire OF_MEM;
    wire RegWre_MEM;
    wire mRD_MEM;
    wire mWR_MEM;
    wire [1:0] WrRegDSrc_MEM;
    wire [4:0] DstReg_MEM;
    wire [31:0] DataA_MEM;
    wire [31:0] DataB_MEM;
    wire [31:0] ALUResult_MEM;
    wire [31:0] PC_Addr4_MEM;
    wire [31:0] DataFromMEM_MEM;
    wire [1:0] WrRegDSrc_WB;
    wire [31:0] DataA_WB;
    wire [31:0] ALUResult_WB;
    wire [31:0] DataFromMEM_WB;
    wire [31:0] PC_Addr4_WB;
    wire OF_WB;
    wire [1:0] forwardA;
    wire [1:0] forwardB;
    wire BR;
    wire keep;
    wire PCSRC_EX_NOT_CLEAR;
   // wire stall_num;
    //assign stall = 1'b0;
        
    data_select_32_3 PC_Select(.a(PC_Addr4),.b(DataA_EX),.c(Jump_PC_MEM),.d(b_Addr_EX),.BR(BR),.op_EX(op_EX),.select(PCSrc_EX),.PCSRC_EX_NOT_CLEAR(PCSRC_EX_NOT_CLEAR),.out(newPC));
    PC myPC(.keep(keep),.newPC(newPC),.CLK(CLK),.stall(stall),.Reset(Reset),.PCWre(PCWre),.Instr_Addr(currPC));
    Instruction_Memory InsMem(.Read_Address(currPC),.InsMemRw(InsMemRw),.Instruction(Instruction));
    add_const add4(.in(currPC),.out(PC_Addr4));
    IF_ID if_id(.CLK(CLK),.Reset(Reset),.stall(stall),.IRWre(IRWre),.BR(BR),.keep(keep),.PC_add4_IF(PC_Addr4),.Instruction_IF(Instruction),.PC_add4_ID(PC_add4_ID),.Instruction_ID(Instruction_ID));
    Instruction_Divided myInstruction_Divided(.Instruction(Instruction_ID),.op(op),.rs(Rs),.rt(Rt),.rd(rd),.sa(sa),.func(func),.imm(imm),.j_Addr(j_Addr));
    data_select_5_3 select_RegDst(.DstRegSelect(DstRegSelect),.Rt(Rt),.Rd(rd),.DstReg(Dst_Reg_ID));
    Control_Unit myControl_Unit(.op(op),.func(func),.zero(Zero_MEM),.sign(Sign_MEM),.OF(OF_MEM),
        .PCWre(PCWre),.ALUSrcA(ALUSrcA_ID),.ALUSrcB(ALUSrcB_ID),.RegWre(RegWre_ID),.WrRegDSrc(WrRegDSrc_ID),
        .InsMemRw(InsMemRw),.mRD(mRD_ID),.mWR(mWR_ID),.IRWre(IRWre),.ExtSel(ExtSel),.PCSrc(PCSrc),.RegDst(DstRegSelect),
        .ALUop(ALUop_ID));
    SignZeroExtend mySignZeroExtend(.imm_in(imm),.Extop(ExtSel),.imm_out(imm_ID));
    Register_File myRegister_File(.Readreg1(Rs),.Readreg2(Rt),.Writereg(Dst_Reg_WB),.RegWre(RegWre_WB),.CLK(CLK),.Reset(Reset),.OF_WB(OF_WB),
        .Write_Data(Write_Data),.Read_Data1(Rs_DATA),.Read_Data2(Rt_DATA));
    ID_EX id_ex(.CLK(CLK),.Reset(Reset),.BR(BR),.keep(keep),.DataA_ID(Rs_DATA),.DataB_ID(Rt_DATA),.PC_Addr4_ID(PC_add4_ID),.imm_ID(imm_ID),
        .j_Addr_ID(j_Addr),.stall(stall),.ALUSrcA_ID(ALUSrcA_ID),.ALUSrcB_ID(ALUSrcB_ID),.RegWre_ID(RegWre_ID),.mRD_ID(mRD_ID),
        .mWR_ID(mWR_ID),.PCSrc(PCSrc),.WrRegDSrc_ID(WrRegDSrc_ID),.ALUop_ID(ALUop_ID),.DstReg_ID(Dst_Reg_ID),.sa_ID(sa),.Rs_ID(Rs),.Rt_ID(Rt),.op_ID(op),
        .DataA_EX(DataA_EX),.DataB_EX(DataB_EX),.PC_Addr4_EX(PC_Addr4_EX),.imm_EX(imm_EX),.j_Addr_EX(j_Addr_EX),.ALUSrcA_EX(ALUSrcA_EX),.ALUSrcB_EX(ALUSrcB_EX),
        .RegWre_EX(RegWre_EX),.mRD_EX(mRD_EX),.mWR_EX(mWR_EX),.PCSrc_EX(PCSrc_EX),.ALUop_EX(ALUop_EX),.WrRegDSrc_EX(WrRegDSrc_EX),.DstReg_EX(DstReg_EX),.sa_EX(sa_EX),
        .Rs_EX(Rs_EX),.Rt_EX(Rt_EX),.op_EX(op_EX),.PCSRC_EX_NOT_CLEAR(PCSRC_EX_NOT_CLEAR));
    Count_Addr myCount_Addr(.j_Addr_in(j_Addr),.b_Addr_in(imm_EX),.PC_Addr4_EX(PC_Addr4_EX),.j_Addr_EX1(j_Addr_EX1),.b_Addr_EX(b_Addr_EX));
    data_select_32_2 ALUSrcA_Select(.forwardA(forwardA),.sa(sa_EX),.Data1(DataA_EX),.ALUResult_MEM(ALUResult_MEM),.res_WB(Write_Data),
        .ALUSrcA(ALUSrcA_EX),.ALUA_out(ALUA));
    DS_32_2 ALUSrcB_Select(.select(ALUSrcB_EX),.forwardB(forwardB),.a(imm_EX),.b(DataB_EX),.ALUResult_MEM(ALUResult_MEM),.res_WB(Write_Data),.res(ALUB));
    ALU myALU(.A(ALUA),.B(ALUB),.ALUop(ALUop_EX),.zero(Zero_EX),.sign(Sign_EX),.OF(OF_EX),.result(Result));
    EX_MEM ex_mem(.CLK(CLK),.keep(keep),.Reset(Reset),.RegWre_EX(RegWre_EX),.mRD_EX(mRD_EX),.mWR_EX(mWR_EX),.WrRegDSrc_EX(WrRegDSrc_EX),
        .DstReg_EX(DstReg_EX),.DataA_EX(DataA_EX),.DataB_EX(DataB_EX),.Jump_PC_EX(j_Addr_EX1),.ALUResult_EX(Result),
        .PC_Addr4_EX(PC_Addr4_EX),.Zero_EX(Zero_EX),.Sign_EX(Sign_EX),.OF_EX(OF_EX),.RegWre_MEM(RegWre_MEM),.mRD_MEM(mRD_MEM),.mWR_MEM(mWR_MEM),
        .WrRegDSrc_MEM(WrRegDSrc_MEM),.DstReg_MEM(DstReg_MEM),.DataA_MEM(DataA_MEM),.DataB_MEM(DataB_MEM),.Jump_PC_MEM(Jump_PC_MEM),
        .ALUResult_MEM(ALUResult_MEM),.PC_Addr4_MEM(PC_Addr4_MEM),.Zero_MEM(Zero_MEM),.Sign_MEM(Sign_MEM),.OF_MEM(OF_MEM));
    Data_Mem myData_Mem(.CLK(CLK),.Data_in(DataB_MEM),.Addr(ALUResult_MEM),.mRD(mRD_MEM),.mWR(mWR_MEM),.Data_out(DataFromMEM_MEM));
    MEM_WB mem_wb(.CLK(CLK),.Reset(Reset),.keep(keep),.RegWre_MEM(RegWre_MEM),.Dst_Reg_MEM(DstReg_MEM),.WrRegDSrc_MEM(WrRegDSrc_MEM),
        .DataA_MEM(DataA_MEM),.ALUResult_MEM(ALUResult_MEM),.DataFromMEM_MEM(DataFromMEM_MEM),.PC_Addr4_MEM(PC_Addr4_MEM),.OF_MEM(OF_MEM),.RegWre_WB(RegWre_WB),.Dst_Reg_WB(Dst_Reg_WB),
        .WrRegDSrc_WB(WrRegDSrc_WB),.DataA_WB(DataA_WB),.ALUResult_WB(ALUResult_WB),.DataFromMEM_WB(DataFromMEM_WB),.PC_Addr4_WB(PC_Addr4_WB),.OF_WB(OF_WB));
    DS_32_4 WrRegDSrc_Select(.select(WrRegDSrc_WB),.a(PC_Addr4_WB),.b(DataFromMEM_WB),.c(DataA_WB),.d(ALUResult_WB),.res(Write_Data));
    Forward_Unit Forward(.OF_MEM(OF_MEM),.RegWre_WB(RegWre_WB),.DstReg_WB(Dst_Reg_WB),.RegWre_MEM(RegWre_MEM),.DstReg_MEM(DstReg_MEM),.Rs_EX(Rs_EX),.Rt_EX(Rt_EX),
        .forwardA(forwardA),.forwardB(forwardB));
    HazardDetect_Unit HazardDetect(.mRD_EX(mRD_EX),.DstReg_EX(DstReg_EX),.Rs_ID(Rs),.Rt_ID(Rt),.stall(stall));
    br_control BR_Control(.op_EX(op_EX),.PCSrc_EX(PCSrc_EX),.Sign_EX(Sign_EX),.Zero_EX(Zero_EX),.BR(BR));
    keep_control Keep_Control(/*.CLK(CLK),*/.PCSRC_EX_NOT_CLEAR(PCSRC_EX_NOT_CLEAR),.op_EX(op_EX),.keep(keep));
endmodule
