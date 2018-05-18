module ieee_mul(
    input [31:0] multiplicand,
    input [31:0] multiplier,
    output [31:0] result
);

wire [7:0]exp_a;
wire [7:0]exp_b;
assign exp_a = multiplicand [30:23]-8'd127;
assign exp_b = multiplier [30:23]-8'd127;

wire [23:0]cast_int_a;
wire [23:0]cast_int_b;
assign cast_int_a = {1'b1, multiplicand[22:0]};
assign cast_int_b = {1'b1, multiplier[22:0]};

wire [47:0]int_result;
assign int_result = cast_int_a * cast_int_b;

wire [31:0]cast_ieee_result;
ieee_converter_with_frac 
#(
    .int_len (48 ),
    .fra_len (1 )
)
u_ieee_converter_with_frac(
	.i_integer  (int_result  ),
    .i_fraction (0          ),
    .sign_flag  (multiplicand[31] ^ multiplier[31]),
    .ieee_val   (cast_ieee_result   )
);

assign result[31] = cast_ieee_result[31];
assign result[30:23] = cast_ieee_result[30:23] + exp_a + exp_b - 46;
assign result[22:0] = cast_ieee_result[22:0];

endmodule
