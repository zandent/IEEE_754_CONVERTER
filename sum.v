`timescale 1ns / 1ps//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/29 14:56:38
// Design Name: 
// Module Name: sum
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
`define number_of_floating_points 16
`define number_of_integer 22

/*`define number_of_floating_points 12
`define number_of_integer 12*/

module sum(
    in_1, in_2, out
    );
    input wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] in_1, in_2;
    output wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] out;
    assign out = in_1 + in_2;
endmodule
