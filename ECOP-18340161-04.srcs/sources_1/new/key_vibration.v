`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/09 21:49:25
// Design Name: 
// Module Name: key_vibration
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


module key_vibration(
    input CLK,
    input key,
    output reg key_en
    );
    //设定的是每过DURATION这么长的时间就取一次
    parameter DURATION = 5000;
    reg [15:0] cnt;//计数变量
    initial cnt = 16'b0;
    always@(posedge CLK)
    begin 
        if(key==1) begin//表示如果按键按下去了
            if(cnt==DURATION) 
                cnt <= cnt;
            else 
                cnt <= cnt + 1;
        end
        else
            cnt <= 16'b0;
    end
    
    always@(posedge CLK) begin//每个时钟来的时候都判断现在是否键使能了
        if(key) key_en <= (cnt==DURATION-1'b1)?1'b1:1'b0;
    end
    
endmodule
