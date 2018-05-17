`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2018 04:33:12 PM
// Design Name: 
// Module Name: op_amp
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

//`define C_WIDTH 10

module op_amp_with_frac
#(
    parameter C_WIDTH = 16
)

(
    input clk,
    input reset_n,
    //input [10:0] gain_bug,
    input [C_WIDTH -1 : 0] non_inv,
    output [31: 0] square_out, // in ieee repesentation
    output reg clk_100k
);
reg [39 : 0] mul_out; //32 wl
reg [32 : 0] sum; //25wl
reg [71 : 0] square; //64wl
wire [39 : 0] filter_out; //32wl

//convert to floating represetation
wire [24:0] non_inv_convert;
customized_converter_with_frac 
#(
    .int_len      (C_WIDTH      ),
    .fra_len      (1      ),
    .montissa_len (16 )
)
u_customized_converter_with_frac(
	.i_integer  (non_inv  ),
    .i_fraction (1'b0 ),
    .sign_flag  (1'b0  ),
    .ieee_val   (non_inv_convert   )
);
/*
wire [31:0] ieee_gain_bug;
customized_converter_with_frac 
#(
    .int_len      (11      ),
    .fra_len      (1      ),
    .montissa_len (23 )
)
u_customized_converter_with_frac_temp(
	.i_integer  (gain_bug  ),
    .i_fraction (1'b0 ),
    .sign_flag  (1'b0  ),
    .ieee_val   (ieee_gain_bug   )
);*/

//sum * gain
reg [31:0]gain;
always @(*) begin
    if(non_inv<=16'd100)
        gain = 32'h43870000;//270 in decimal  //ieee_gain_bug;//32'h437a0000; //250 //32'h44160000;//600 //442f0000;//700 // 32'h43fa0000;//500  for 34  35 37 38 //32'h42c80000; //100 in decimal                   
    else if (non_inv<=16'd500)
        gain = 32'h42c80000; //100 in decimal
    else if(non_inv>=16'd2400)
        gain = 32'h41200000; //10 in decimal
    else
        gain = 32'h42480000; //50 in decimal
end
wire [39:0]sum_mul_handred;
customized_mul 
#(
    .montissa_len_multiplicand (23 ),
    .montissa_len_multiplier   (24   ),
    .montissa_len_result       (31      )
)
u_customized_mul_1(
	.multiplicand (gain),
    .multiplier   (sum   ),
    .result       (sum_mul_handred       )
);

//filter_out * filter_out
wire [71:0]filter_out_square;
customized_mul 
#(
    .montissa_len_multiplicand (31 ),
    .montissa_len_multiplier   (31   ),
    .montissa_len_result       (63       )
)
u_customized_mul_2(
	.multiplicand (filter_out ),
    .multiplier   (filter_out   ),
    .result       (filter_out_square       )
);

//non_inv_convert - square
wire [32:0] sum_i;
custonmized_add_sub 
#(
    .first_montissa_len  (16  ),
    .second_montissa_len (63 ),
    .result_montissa_len (24 )
)
u_custonmized_add_sub(
	.first_element  (non_inv_convert  ),
    .second_element (square),
    .add_sub        (1'b1        ),
    .result         (sum_i         )
);


filter_iir_with_frac 
#(
    .word_length_x (32 ),
    .word_length_y (32 )
)
u_filter_iir_with_frac(
	.clk (clk_100k ),
    .reset_n(reset_n),
    .x   (mul_out  ),
    .y   (filter_out   )
);

 
assign square_out = filter_out[39:8];
//(non_inv==16'd36)? 32'h40c00000 : filter_out[39:8]; //corner_case for sqrt 36
always @ (posedge clk_100k or negedge reset_n)begin
    if(!reset_n)begin
        mul_out[39:31] <= 9'b001111111;
        mul_out[30:0] <= 0;   
        sum <= 0; 
        square <= 0;
    end  
    else begin
            mul_out <= sum_mul_handred;
            square <= filter_out_square;
            sum <= sum_i;  
    end
end


reg [9:0]counter2;

always @(posedge clk or negedge reset_n)begin
    if(!reset_n) begin                                             //if reset is high
        clk_100k<=1'b0;                                   //reset 10MHz clock output
        counter2 <=10'd0;                                        //reset counter                                        
    end
    else if (counter2 == 10'd499 && clk_100k==1'b0)begin     //if counter value has reached 40 and 10MHz clock is low
        clk_100k <=1'b1;                                   //set 10MHz clock output high
        counter2 <=10'd0;                                        //reset counter
    end
    else if (counter2 == 10'd499 && clk_100k==1'b1)begin     //if counter value has reached 40 and 10MHz clock is high
        clk_100k <=1'b0;                                   //set clock output low
        counter2 <=10'd0;                                        //reset counter
    end
    else begin
        counter2 <= counter2 + 1;                               //increment counte
    end
end

endmodule
