`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 18:43:23
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input [4:0] Readreg1,
    input [4:0] Readreg2,
    input [4:0] Writereg,
    input RegWre,
    input CLK,
    input Reset,
    input OF_WB,
    input [31:0] Write_Data,
    output [31:0] Read_Data1,
    output [31:0] Read_Data2
    );
    reg [31:0] register_files[0:31];
    integer cnt;
    
    initial
    begin 
        for(cnt = 0;cnt<32;cnt = cnt+1)
        begin
            register_files[cnt] <= 0;
        end
    end
    
    always@(posedge CLK)
    begin
        if(RegWre && Writereg && Reset && !OF_WB)
            register_files[Writereg] <= Write_Data;
    end
    
    assign Read_Data1 = (Readreg1 && Reset) ? register_files[Readreg1] : 0;
    assign Read_Data2 = (Readreg2 && Reset) ? register_files[Readreg2] : 0;
    
    
endmodule
