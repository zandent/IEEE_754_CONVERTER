`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2017 05:33:19 PM
// Design Name: 
// Module Name: filter_iir
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

module filter_iir_with_frac #
(
    parameter word_length_x,
    parameter word_length_y
)( 
    input clk,
    input [word_length_x + 7 : 0] x,
    output [word_length_y + 7 : 0] y
    ); 

    last_section_with_frac 
    #(
        .word_length_x      (word_length_x      ),
        .word_length_coef_a (24 ), 
        .word_length_coef_b (24 ),
        .word_length_y      (word_length_y      )
    )
    u_last_section_with_frac(
    	.x      (x      ),
        .coef_a (32'h40000000 ),// 2
        .coef_b (32'hc77ffc00 ), //-65532
        .clk    (clk    ),
        .y      (y      )
    );
    

endmodule
