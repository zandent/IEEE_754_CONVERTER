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


module tb();

reg reset_n;
reg clk;
wire clk_100k;
reg [15:0] amp_in[127:0];
wire [31:0]amp_out[127:0];
reg [10:0] gain_bug;

genvar j;
generate 
    for (j=0;j<128;j++) begin: module1_assign
        op_amp_with_frac opamp
        (
            .clk            (clk),
            .reset_n        (reset_n),
            //.gain_bug       (gain_bug),
            .non_inv        (amp_in[j]),
            .square_out     (amp_out[j]),
            .clk_100k       (clk_100k)
        );
    end
endgenerate



always begin
    #5 clk = ~clk;
end

reg [9:0] counter_detect_stable[127:0];
reg [31:0] amp_out_reg[127:0];
genvar k;
generate 
    for (k=0;k<128;k++) begin: module2_assign
        always @ (posedge clk_100k or negedge reset_n) begin
            if(~reset_n) begin
                counter_detect_stable[k] <= 0;
                amp_out_reg[k] <= amp_out[k];
            end
            else begin
                if(amp_out_reg[k]==amp_out[k])
                counter_detect_stable[k] <= counter_detect_stable[k] + 1'b1;
                amp_out_reg[k] <= amp_out[k];
            end

        end
    end
endgenerate


initial begin
clk =1'b0;
reset_n = 1'b0;

for (integer i = 1; i<=448; i++) begin
    for (integer m=0; m<128; m++) begin
        amp_in[m] = i+m*448+8192;
    end
    $display("iteration %d init success", i);
    #100 reset_n = ~reset_n;
    #4000000;
    $display("processing success, print value if failed");
    for (integer n=0; n<128; n++) begin
            if(counter_detect_stable[n] < 20)
                $display("UNSTABLE for %d, output is %h", amp_in[n], amp_out[n]);
    end
    reset_n = 1'b0;
end

$stop();
end

endmodule
/*
vlog *.v *.sv
vsim -novopt tb
run -all
vlog *.v *.sv
restart -f
run -all
*/