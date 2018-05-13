`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2018 11:45:37 PM
// Design Name: 
// Module Name: phase_detection
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


(*use_dsp48 = "yes"*)module phase_detection
#(
    parameter C_COUNTS = 5000,
    parameter C_DEGREES = 92160
)
(
    input clk,
    input reset_n,
    input wire signed [15:0] REF_SINE,
    input wire signed [15:0] TEST_SIG,
    input wire valid,
    output wire signed [31:0] test_out,
    output wire [15:0] square_out
);
//wire [15:0] refsine, testsig;
//assign refsine = 16'b1000000000000000 + REF_SINE;
//assign testsig = 16'b1000000000000000 + TEST_SIG;
//assign test_out = refsine * refsine;

mult_gen_0 multiplier
(
    .CLK    (clk),
    .A      (REF_SINE),
    .B      (REF_SINE),
    .P      (test_out)
);

endmodule
