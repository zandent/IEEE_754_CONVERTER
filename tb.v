module tb();

wire [31:0] ieee_val_1;
wire [31:0] ieee_val_2;
/*
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
*/

customized_converter_with_frac 
#(
    .int_len      (17      ),
    .fra_len      (4      ),
    .montissa_len (23 )
)
u_ieee_converter_with_frac_1(
	.i_integer  (17'd65536),
    .i_fraction (4'b1100),
    .sign_flag  (1'b0  ),
    .ieee_val   (ieee_val_1   )
);

customized_converter_with_frac 
#(
    .int_len      (8      ),
    .fra_len      (4      ),
    .montissa_len (23 )
)
u_ieee_converter_with_frac_2(
	.i_integer  (8'd12 ),
    .i_fraction (4'b0010  ),
    .sign_flag  (1'b0  ),
    .ieee_val   (ieee_val_2   )
);

wire [55:0] mul_val;

customized_mul 
#(
    .montissa_len_multiplicand(23),
    .montissa_len_multiplier(23)
    //.montissa_len_result(47)
)
u_customized_mul(
	.multiplicand (ieee_val_1 ),
    .multiplier   (ieee_val_2   ),
    .result       (mul_val       )
);

wire [27:0] add_sub_result;
custonmized_add_sub 
#(
    .first_montissa_len  (5  ),
    .second_montissa_len (10 ),
    .result_montissa_len (19 )
)
u_custonmized_add_sub(
	.first_element  (14'b00111010100101  ),
    .second_element (19'b011100011001100111 ),
    .add_sub        (1'b0        ),
    .result         (add_sub_result       )
);


initial begin
#5;
$stop();
end
endmodule