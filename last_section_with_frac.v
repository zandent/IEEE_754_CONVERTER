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
module last_section_with_frac #
(
    parameter word_length_x,
    parameter word_length_coef_a,
    parameter word_length_coef_b,
    parameter word_length_y
)(
    input [word_length_x + 7 : 0] x, 
    input [word_length_coef_a + 7 : 0]coef_a, 
    input [word_length_coef_b + 7 : 0]coef_b,
    input clk,
    input reset_n,
    output [word_length_y + 7 : 0] y
    );
    wire [word_length_y + 7 : 0] a_1,a_2,b_1,b_2,e,f;
    /*mult m_a (x, a, coef_a);
    mult m_b (f, b, coef_b);
    subtract a_1 (a, b, e);
    sum a_2 (e, f, y);
    delay d_1 (e, f, clk);*/

    customized_mul 
    #(
        .montissa_len_multiplicand (word_length_x - 1 ),
        .montissa_len_multiplier   (word_length_coef_a - 1   ),
        .montissa_len_result       (word_length_y - 1       )
    )
    u_customized_mul_1(
    	.multiplicand (x ),
        .multiplier   (coef_a   ),
        .result       (a_1      )
    );

    customized_mul 
    #(
        .montissa_len_multiplicand (word_length_y - 1 ),
        .montissa_len_multiplier   ( 23),
        .montissa_len_result       (word_length_y - 1       )
    )
    u_customized_mul_2(
    	.multiplicand (a_1 ),
        .multiplier   ( 32'h377ffff6  ),//1/65536
        .result       (a_2       )
    );
    
    customized_mul 
    #(
        .montissa_len_multiplicand (word_length_y - 1 ),
        .montissa_len_multiplier   (word_length_coef_b - 1   ),
        .montissa_len_result       (word_length_y - 1       )
    )
    u_customized_mul_3(
    	.multiplicand (f ),
        .multiplier   (coef_b   ),
        .result       (b_1     )
    );

    customized_mul 
    #(
        .montissa_len_multiplicand (word_length_y - 1 ),
        .montissa_len_multiplier   ( 23),
        .montissa_len_result       (word_length_y - 1       )
    )
    u_customized_mul_4(
    	.multiplicand (b_1 ),
        .multiplier   ( 32'h377ffff6  ),//1/65536
        .result       (b_2       )
    );

    custonmized_add_sub 
    #(
        .first_montissa_len  (word_length_y - 1  ),
        .second_montissa_len (word_length_y - 1 ),
        .result_montissa_len (word_length_y - 1 )
    )
    u_custonmized_add_sub_1(
    	.first_element  (a_2  ),
        .second_element (b_2 ),
        .add_sub        (1'b1        ),
        .result         (e         )
    );
    
    custonmized_add_sub 
    #(
        .first_montissa_len  (word_length_y - 1  ),
        .second_montissa_len (word_length_y - 1 ),
        .result_montissa_len (word_length_y - 1 )
    )
    u_custonmized_add_sub_2(
    	.first_element  (e  ),
        .second_element (f ),
        .add_sub        (1'b0      ),
        .result         (y         )
    );
    
    
    customized_delay 
    #(
        .montissa_length (word_length_y - 1 )
    )
    u_customized_delay(
    	.clk (clk ),
        .reset_n(reset_n),
        .in  (e ),
        .out (f )
    );
    


endmodule
