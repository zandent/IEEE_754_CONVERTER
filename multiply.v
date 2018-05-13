`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/29 13:35:38
// Design Name: 
// Module Name: multiply
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

module mult(
    in, out, multiplier
    );

    wire signed [`number_of_floating_points+1 : 0] floating_point_compensation;
    assign floating_point_compensation [`number_of_floating_points - 1 : 0]  = `number_of_floating_points'b0;
    assign floating_point_compensation [`number_of_floating_points] = 1'b1;
    assign floating_point_compensation [`number_of_floating_points+1] = 1'b0;
    
    input wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] in, multiplier;
    output wire signed [`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer : 0] out;
    assign out = (in * multiplier) / 65536; /// floating_point_compensation;
endmodule
