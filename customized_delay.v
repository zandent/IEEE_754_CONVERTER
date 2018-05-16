`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/29 13:33:07
// Design Name: 
// Module Name: delay
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
/*`define number_of_floating_points 12
`define number_of_integer 12*/

module customized_delay #
(
    parameter montissa_length
)(
    
    input clk,
    input reset_n,
    input [montissa_length + 8 : 0] in,
    output reg [montissa_length + 8: 0] out
);
    initial out = 0;
    always @(posedge clk or negedge reset_n)
        if(!reset_n)
        out <= 0;
        else
        out <= in;
endmodule
