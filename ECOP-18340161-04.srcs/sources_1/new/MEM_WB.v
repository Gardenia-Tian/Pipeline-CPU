`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/06 19:49:36
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
    input CLK,
    input Reset,
    input keep,
    input RegWre_MEM,
    input [4:0] Dst_Reg_MEM,
    input [1:0] WrRegDSrc_MEM,
    input [31:0] DataA_MEM,
    input [31:0] ALUResult_MEM,
    input [31:0] DataFromMEM_MEM,
    input [31:0] PC_Addr4_MEM,
    input OF_MEM,
    output reg RegWre_WB,
    output reg [4:0] Dst_Reg_WB,
    output reg [1:0] WrRegDSrc_WB,
    output reg [31:0] DataA_WB,
    output reg [31:0] ALUResult_WB,
    output reg [31:0] DataFromMEM_WB,
    output reg [31:0] PC_Addr4_WB,
    output reg OF_WB
    );
    initial begin
        RegWre_WB <=0;
        Dst_Reg_WB <=0;
        WrRegDSrc_WB <=0;
        DataA_WB <=0;
        ALUResult_WB <=0;
        DataFromMEM_WB <=0;
        PC_Addr4_WB <=0;  
        OF_WB <= 0;     
    end
    
    always@(negedge CLK) begin
        if(!Reset) begin
            RegWre_WB <=0;
            Dst_Reg_WB <=0;
            WrRegDSrc_WB <=0;
            DataA_WB <=0;
            ALUResult_WB <=0;
            DataFromMEM_WB <=0;
            PC_Addr4_WB <=0; 
            OF_WB <= 0;
        end
        else if(keep) begin
            RegWre_WB <=RegWre_WB;
            Dst_Reg_WB <=Dst_Reg_WB;
            WrRegDSrc_WB <=WrRegDSrc_WB;
            DataA_WB <= DataA_WB;
            ALUResult_WB <=ALUResult_WB;
            DataFromMEM_WB <=DataFromMEM_WB;
            PC_Addr4_WB <=PC_Addr4_WB; 
            OF_WB <= OF_WB;           
        end
        else begin
            RegWre_WB <=RegWre_MEM;
            Dst_Reg_WB <=Dst_Reg_MEM;
            WrRegDSrc_WB <=WrRegDSrc_MEM;
            DataA_WB <= DataA_MEM;
            ALUResult_WB <=ALUResult_MEM;
            DataFromMEM_WB <=DataFromMEM_MEM;
            PC_Addr4_WB <=PC_Addr4_MEM;
            OF_WB <= OF_MEM;
        end     
    end
endmodule
