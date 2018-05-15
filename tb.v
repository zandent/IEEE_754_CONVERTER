module tb();

wire [71:0] ieee_val_1;
wire [39:0] ieee_val_2;
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
reg [31:0] int_a;
reg [31:0] fra_a;
reg sign_a;
reg [15:0] int_b;
reg [15:0] fra_b;
reg sign_b;
customized_converter_with_frac 
#(
    .int_len      (32     ),
    .fra_len      (32      ),
    .montissa_len (63 )
)
u_ieee_converter_with_frac_1(
	.i_integer  (int_a),
    .i_fraction (fra_a),
    .sign_flag  (sign_a  ),
    .ieee_val   (ieee_val_1   )
);

customized_converter_with_frac 
#(
    .int_len      (16      ),
    .fra_len      (16      ),
    .montissa_len (31      )
)
u_ieee_converter_with_frac_2(
	.i_integer  (int_b ),
    .i_fraction (fra_b  ),
    .sign_flag  (sign_b ),
    .ieee_val   (ieee_val_2   )
);

wire [102:0] mul_val;

customized_mul 
#(
    .montissa_len_multiplicand(63),
    .montissa_len_multiplier(31),
    .montissa_len_result(94)
)
u_customized_mul(
	.multiplicand (ieee_val_1 ),
    .multiplier   (ieee_val_2   ),
    .result       (mul_val       )
);

wire [31:0] add_sub_result;
reg add_sub;
custonmized_add_sub 
#(
    .first_montissa_len  (63 ),
    .second_montissa_len (31 ),
    .result_montissa_len (23 )
)
u_custonmized_add_sub(
	.first_element  (ieee_val_1 ),
    .second_element (ieee_val_2 ),
    .add_sub        (add_sub       ),
    .result         (add_sub_result       )
);


initial begin
int_a <= 32'd1048576;
fra_a <= 32'h80000000;
sign_a <= 1;
int_b <= 16'd65535;
fra_b <= 16'h8FFF;
sign_b <= 0;
add_sub <= 1;
#5;
$stop();
end
endmodule