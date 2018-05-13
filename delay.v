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

`define number_of_floating_points 16
`define number_of_integer 22

module delay(
    in, out, clk
    );
    input clk;
    input wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] in;
    output reg signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] out;
    initial out = 0;
    always @(posedge clk)
        out <= in;
endmodule
