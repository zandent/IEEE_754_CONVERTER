`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2018 11:54:48 PM
// Design Name: 
// Module Name: phase_detection_tb
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


module phase_detection_tb();

reg reset_n;
reg clk;
wire clk_100k;
reg [15:0]amp_in;
wire [31:0]amp_out;
reg [10:0] gain_bug;

op_amp_with_frac opamp
(
    .clk            (clk),
    .reset_n        (reset_n),
    //.gain_bug       (gain_bug),
    .non_inv        (amp_in),
    .square_out     (amp_out),
    .clk_100k       (clk_100k)
);


always begin
    #5 clk = ~clk;
end

reg [9:0] counter_detect_stable;
reg [31:0]amp_out_reg;
always @ (posedge clk_100k or negedge reset_n) begin
    if(~reset_n) begin
        counter_detect_stable <= 0;
        amp_out_reg <= amp_out;
    end
    else begin
        if(amp_out_reg==amp_out)
           counter_detect_stable <= counter_detect_stable + 1'b1;
        amp_out_reg <= amp_out;
    end

end


reg [255:0] counter_detect_unstable;
always @ (posedge clk_100k or negedge reset_n) begin
    if(~reset_n) begin
        counter_detect_unstable <= 0;
    end
    else begin
           counter_detect_unstable <= counter_detect_unstable + 1'b1;
    end

end



initial begin
clk =1'b0;
reset_n = 1'b0;
/*
for (integer i = 1; i<100; i=i+10) begin
    amp_in = i;
    #100 reset_n = ~reset_n;
    #2000000;
    if(counter_detect_stable < 20)
        $display("UNSTABLE for %d, output is %h", amp_in, amp_out);
    reset_n = 1'b0;
end
for (integer i = 100; i<500; i=i+100) begin
    amp_in = i;
    #100 reset_n = ~reset_n;
    #2000000;
    if(counter_detect_stable < 20)
        $display("UNSTABLE for %d, output is %h", amp_in, amp_out);
    reset_n = 1'b0;
end
for (integer i = 500; i<2400; i=i+100) begin
    amp_in = i;
    #100 reset_n = ~reset_n;
    #2000000;
    if(counter_detect_stable < 20)
        $display("UNSTABLE for %d, output is %h", amp_in, amp_out);
    reset_n = 1'b0;
end 

for (integer i = 2400; i<65536; i=i+5000) begin
    amp_in = i;
    #100 reset_n = ~reset_n;
    #4000000;
    if(counter_detect_stable < 20)
        $display("UNSTABLE for %d, output is %h", amp_in, amp_out);
    reset_n = 1'b0;
end*/

amp_in = 2400;
#100 reset_n = ~reset_n;
#4000000;
if(counter_detect_stable < 20)
$display("UNSTABLE for %d, output is %h", amp_in, amp_out);
else
$display("stable for %d, output is %h", amp_in, amp_out);
$stop();
end

endmodule
