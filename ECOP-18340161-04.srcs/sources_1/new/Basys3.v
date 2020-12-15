`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/09 21:47:07
// Design Name: 
// Module Name: Basys3
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


module Basys3(
    input Reset,
    input CLK,
    input BTNR,
    input [1:0] SW_in,
    output reg [3:0] AN,
    output [7:0] digital
    );
    //顶层文件烧板子，只需要数码管的显示，所以只有位选和数是输出
    //因为Reset设置成拨动开关，SW_in也设置成拨动开关，所以这两个是输入，BTNR是我们按的按钮，CLK连接板子自带的时钟
    wire [31:0] Instr_Addr;//当前的PC值
    wire [31:0] newPC;//下一条PC值
    wire [4:0] rs;//RS寄存器编号
    wire [4:0] rt;//RT寄存器编号
    wire [31:0] Read_Data1;//RS寄存器里面的值
    wire [31:0] Read_Data2;//RT寄存器里面的值
    wire [31:0] result;//ALU运算结果
    wire [31:0] Write_Data;//最终写进register file中的值，也就是数据通路的内容
    reg [3:0] display_data;//传入LED的值，告诉数码管这一位要显示的数字是多少
    reg [15:0] cnt;//计数变量，用于分频
    wire key_en;//记录消抖之后，产生的信号状态，就是表示按键有没有被按下
    parameter CLK_DIV = 10000;//把时钟频率分成原来的1/CLK_DIV
    
   
    
    //实例化CPU~这个可真的是myCPU
    PipeLineCPU myCPU(.Reset(Reset),.CLK(key_en),.currPC(Instr_Addr),.newPC(newPC),.Rs(rs),.Rt(rt),
    .Rs_DATA(Read_Data1),.Rt_DATA(Read_Data2),.Result(result),.Write_Data(Write_Data));
    
    //实例化消抖按键
    key_vibration mykey_vibration(.CLK(CLK),.key(BTNR),.key_en(key_en));
    
    
    //为cnt和位选信号赋初始值
    initial begin
        cnt = 0;
        AN = 4'b0111;
    end
    
    //这一部分是位选
    always@(negedge CLK) begin
        if(Reset==1) begin//如果不是清零信号
            cnt <= cnt + 1;//来一个CLK记一次数
            if(cnt==CLK_DIV) begin
                cnt <= 0; //当来到了CLK_DIV这么多的始终的时候，触发一次位选的改变
                case(AN)
                    4'b0111: AN <= 4'b1011;
                    4'b1011: AN <= 4'b1101;
                    4'b1101: AN <= 4'b1110;
                    4'b1110: AN <= 4'b0111;
                    default: AN <= 4'b1111;
                endcase
            end
        end
    end
    
    //对数码管译码
    SegLED mySegLED(.display_data(display_data),.dispcode(digital));
    
    //这一部分是分配数据来源
    always@( key_en ) begin
        if(Reset==1) begin
            case(AN) 
                4'b0111:begin
                case(SW_in)
                    2'b00: display_data = Instr_Addr[7:4];
                    2'b01: display_data = {3'b000,rs[4]};
                    2'b10: display_data = {3'b000,rt[4]};
                    2'b11: display_data = result[7:4];
                endcase
                end
                4'b1011:begin
                case(SW_in)
                    2'b00: display_data = Instr_Addr[3:0];
                    2'b01: display_data = rs[3:0];
                    2'b10: display_data = rt[3:0];
                    2'b11: display_data = result[3:0];
                endcase
                end
                4'b1101:begin
                case(SW_in)
                    2'b00: display_data = newPC[7:4];
                    2'b01: display_data = Read_Data1[7:4];
                    2'b10: display_data = Read_Data2[7:4];
                    2'b11: display_data = result[7:4];
                endcase
                end
                4'b1110:begin
                case(SW_in)
                    2'b00: display_data = newPC[3:0];
                    2'b01: display_data = Read_Data1[3:0];
                    2'b10: display_data = Read_Data2[3:0];
                    2'b11: display_data = result[3:0];                                        
                endcase
                end
            endcase
            end
        end 
endmodule
