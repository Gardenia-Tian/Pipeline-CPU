`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 11:43:02
// Design Name: 
// Module Name: testbench
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


module testbench();
    reg Reset;
    reg CLK;
    wire [31:0] currPC;
    wire [31:0] newPC;
    wire [4:0] Rs;
    wire [4:0] Rt;
    wire [31:0] Rs_DATA;
    wire [31:0] Rt_DATA;
    wire [31:0] Result;
    wire [31:0] Write_Data;
    
    PipeLineCPU utt(
        .Reset(Reset),
        .CLK(CLK),
        .currPC(currPC),
        .newPC(newPC),
        .Rs(Rs),
        .Rt(Rt),
        .Rs_DATA(Rs_DATA),
        .Rt_DATA(Rt_DATA),
        .Result(Result),
        .Write_Data(Write_Data)
        );    
        initial begin
            CLK = 0;
            Reset = 0;
            #10 Reset=1;
          end
                  
        always #5 CLK=~CLK;        

endmodule
