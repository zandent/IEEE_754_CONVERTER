module tb();

wire [31:0] ieee_val_1;
wire [31:0] ieee_val_2;
ieee_converter_with_frac 
#(
    .int_len (17 ),
    .fra_len (4 )
)
u_ieee_converter_with_frac_1(
	.i_integer  (17'd65536),
    .i_fraction (4'b1100),
    .sign_flag  (1'b0  ),
    .ieee_val   (ieee_val_1   )
);
ieee_converter_with_frac 
#(
    .int_len (8 ),
    .fra_len (4 )
)
u_ieee_converter_with_frac_2(
	.i_integer  (8'd12 ),
    .i_fraction (4'b0010  ),
    .sign_flag  (1'b0  ),
    .ieee_val   (ieee_val_2   )
);

wire [31:0] mul_val;
ieee_mul u_ieee_mul(
	.multiplicand (ieee_val_1 ),
    .multiplier   (ieee_val_2   ),
    .result       (mul_val       )
);


initial begin
#5;
$stop();
end
endmodule