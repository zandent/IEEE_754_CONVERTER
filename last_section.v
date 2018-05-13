`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/06/01 15:39:26
// Design Name: 
// Module Name: last_section
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

module last_section(
    input wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] x, coef_a, coef_b,
    input wire clk,
    output wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] y
    );
    wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] a,b,e,f;
    mult m_a (x, a, coef_a);
    mult m_b (f, b, coef_b);
    subtract a_1 (a, b, e);
    sum a_2 (e, f, y);
    delay d_1 (e, f, clk);

endmodule
