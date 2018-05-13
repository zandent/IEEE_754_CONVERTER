`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/29 16:57:33
// Design Name: 
// Module Name: lowpass_section_sample
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

module lowpass_section_sample(
    input wire clk,
    input wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] x, coef_a, coef_b, coef_c, coef_d,
    output wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] y
    );
    
    wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] a,b,c,d,e,f,g,h,i;
    mult m_a (x, a, coef_a);
    mult m_b (f, b, coef_b);
    mult m_c (g, d, coef_c);
    mult m_d (f, h, coef_d);
    subtract a_1 (a, b, c);
    subtract a_2 (c, d, e);
    sum a_3 (e, h, i);
    sum a_4 (i, g, y);
    delay d_1 (e, f, clk);
    delay d_2 (f, g, clk);

endmodule
