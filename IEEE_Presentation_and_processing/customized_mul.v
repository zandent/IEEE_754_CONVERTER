`timescale 1ns / 1ps
module customized_mul #
(
    parameter montissa_len_multiplicand,
    parameter montissa_len_multiplier,
    parameter montissa_len_result = (montissa_len_multiplicand + montissa_len_multiplier + 1)
)(
    input [montissa_len_multiplicand+8:0] multiplicand,
    input [montissa_len_multiplier+8:0] multiplier,
    output [montissa_len_result+8:0] result
);

wire [7:0]exp_a;
wire [7:0]exp_b;
assign exp_a = multiplicand [montissa_len_multiplicand+7:montissa_len_multiplicand]-8'd127;
assign exp_b = multiplier [montissa_len_multiplier+7:montissa_len_multiplier]-8'd127;

wire [montissa_len_multiplicand:0]cast_int_a;
wire [montissa_len_multiplier:0]cast_int_b;
assign cast_int_a = {1'b1, multiplicand[montissa_len_multiplicand-1:0]};
assign cast_int_b = {1'b1, multiplier[montissa_len_multiplier-1:0]};

wire [(montissa_len_multiplicand + montissa_len_multiplier + 1):0]int_result;
assign int_result = cast_int_a * cast_int_b;

wire [montissa_len_result+8:0]cast_ieee_result;
customized_converter_with_frac 
#(
    .int_len (montissa_len_multiplicand + montissa_len_multiplier + 2),
    .fra_len (1 ),
    .montissa_len(montissa_len_result)
)
u_customized_converter_with_frac(
	.i_integer  (int_result  ),
    .i_fraction (1'b0          ),
    .sign_flag  (multiplicand[montissa_len_multiplicand+8] ^ multiplier[montissa_len_multiplier+8]),
    .ieee_val   (cast_ieee_result   )
);

assign result[montissa_len_result+8] = cast_ieee_result[montissa_len_result+8];
assign result[montissa_len_result+7:montissa_len_result] = cast_ieee_result[montissa_len_result+7:montissa_len_result] 
+ exp_a + exp_b - (montissa_len_multiplicand + montissa_len_multiplier);
assign result[montissa_len_result-1:0] = cast_ieee_result[montissa_len_result-1:0];

endmodule
