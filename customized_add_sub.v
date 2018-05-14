`define MAX_DIFF_WIDTH 64 //assuming the input difference is at 64 bits as maximum
module custonmized_add_sub #
(
    parameter first_montissa_len,
    parameter second_montissa_len,
    parameter result_montissa_len = first_montissa_len
)(
    input [first_montissa_len+8:0] first_element,
    input [second_montissa_len+8:0] second_element,
    input add_sub, //1 for sub, 0 for add
    output [result_montissa_len+8:0] result
);

wire [8:0] exp_a_before_shift; //signed
wire [8:0] exp_b_before_shift; //signed
assign exp_a_before_shift = first_element[first_montissa_len+7:first_montissa_len]-9'd127-first_montissa_len;
assign exp_b_before_shift = second_element[second_montissa_len+7:second_montissa_len]-9'd127-second_montissa_len;

reg [8:0] exp_result_after_shift;
reg [8:0] diff_exp_a_b;

always @(*) begin
  if(~exp_a_before_shift[8] && exp_b_before_shift[8]) begin
    exp_result_after_shift = exp_b_before_shift;
    diff_exp_a_b = exp_a_before_shift - exp_b_before_shift;
    end
    else if(exp_a_before_shift[8] && ~exp_b_before_shift[8]) begin
    exp_result_after_shift = exp_a_before_shift;
    diff_exp_a_b = exp_b_before_shift - exp_a_before_shift;
    end
    else if(~exp_a_before_shift[8] && (exp_a_before_shift >= exp_b_before_shift)) begin
    exp_result_after_shift = exp_b_before_shift;
    diff_exp_a_b = exp_a_before_shift - exp_b_before_shift;
    end
    else if(~exp_a_before_shift[8] && (exp_a_before_shift < exp_b_before_shift)) begin
    exp_result_after_shift = exp_a_before_shift;
    diff_exp_a_b = exp_b_before_shift - exp_a_before_shift;
    end
    else if(exp_a_before_shift[8] && (exp_a_before_shift >= exp_b_before_shift)) begin
    exp_result_after_shift = exp_b_before_shift;
    diff_exp_a_b = exp_a_before_shift - exp_b_before_shift;
    end
    else begin
    exp_result_after_shift = exp_a_before_shift;
    diff_exp_a_b = exp_b_before_shift - exp_a_before_shift;
    end
end

wire [first_montissa_len+second_montissa_len:0] real_a_before_shift;
reg [`MAX_DIFF_WIDTH:0] real_a_after_shift;
wire [first_montissa_len+second_montissa_len:0] real_b;
wire real_a_sign_flag;
wire real_b_sign_flag;
assign real_a_before_shift = (exp_result_after_shift==exp_a_before_shift)? {1'b1,first_element[first_montissa_len-1:0]} : 
    {1'b1,second_element[second_montissa_len-1:0]};
assign real_a_sign_flag = (exp_result_after_shift==exp_a_before_shift)? first_element[first_montissa_len+8] : second_element[second_montissa_len+8];
assign real_b = (exp_result_after_shift==exp_a_before_shift)? {1'b1,second_element[second_montissa_len-1:0]} : 
    {1'b1,first_element[first_montissa_len-1:0]};
assign real_b_sign_flag = (exp_result_after_shift==exp_a_before_shift)? second_element[second_montissa_len+8] : first_element[first_montissa_len+8]; 


//implement a decoder from 0-bit shift to MAX_DIFF_WIDTH-bit shift
always@(*) begin
    case(diff_exp_a_b)
        9'd0 : real_a_after_shift = real_a_before_shift << 9'd0 ;
        9'd1 : real_a_after_shift = real_a_before_shift << 9'd1 ;
        9'd2 : real_a_after_shift = real_a_before_shift << 9'd2 ;
        9'd3 : real_a_after_shift = real_a_before_shift << 9'd3 ;
        9'd4 : real_a_after_shift = real_a_before_shift << 9'd4 ;
        9'd5 : real_a_after_shift = real_a_before_shift << 9'd5 ;
        9'd6 : real_a_after_shift = real_a_before_shift << 9'd6 ;
        9'd7 : real_a_after_shift = real_a_before_shift << 9'd7 ;
        9'd8 : real_a_after_shift = real_a_before_shift << 9'd8 ;
        9'd9 : real_a_after_shift = real_a_before_shift << 9'd9 ;
        9'd10: real_a_after_shift = real_a_before_shift << 9'd10;
        9'd11: real_a_after_shift = real_a_before_shift << 9'd11;
        9'd12: real_a_after_shift = real_a_before_shift << 9'd12;
        9'd13: real_a_after_shift = real_a_before_shift << 9'd13;
        9'd14: real_a_after_shift = real_a_before_shift << 9'd14;
        9'd15: real_a_after_shift = real_a_before_shift << 9'd15;
        9'd16: real_a_after_shift = real_a_before_shift << 9'd16;
        9'd17: real_a_after_shift = real_a_before_shift << 9'd17;
        9'd18: real_a_after_shift = real_a_before_shift << 9'd18;
        9'd19: real_a_after_shift = real_a_before_shift << 9'd19;
        9'd20: real_a_after_shift = real_a_before_shift << 9'd20;
        9'd21: real_a_after_shift = real_a_before_shift << 9'd21;
        9'd22: real_a_after_shift = real_a_before_shift << 9'd22;
        9'd23: real_a_after_shift = real_a_before_shift << 9'd23;
        9'd24: real_a_after_shift = real_a_before_shift << 9'd24;
        9'd25: real_a_after_shift = real_a_before_shift << 9'd25;
        9'd26: real_a_after_shift = real_a_before_shift << 9'd26;
        9'd27: real_a_after_shift = real_a_before_shift << 9'd27;
        9'd28: real_a_after_shift = real_a_before_shift << 9'd28;
        9'd29: real_a_after_shift = real_a_before_shift << 9'd29;
        9'd30: real_a_after_shift = real_a_before_shift << 9'd30;
        9'd31: real_a_after_shift = real_a_before_shift << 9'd31;
        9'd32: real_a_after_shift = real_a_before_shift << 9'd32;
        9'd33: real_a_after_shift = real_a_before_shift << 9'd33;
        9'd34: real_a_after_shift = real_a_before_shift << 9'd34;
        9'd35: real_a_after_shift = real_a_before_shift << 9'd35;
        9'd36: real_a_after_shift = real_a_before_shift << 9'd36;
        9'd37: real_a_after_shift = real_a_before_shift << 9'd37;
        9'd38: real_a_after_shift = real_a_before_shift << 9'd38;
        9'd39: real_a_after_shift = real_a_before_shift << 9'd39;
        9'd40: real_a_after_shift = real_a_before_shift << 9'd40;
        9'd41: real_a_after_shift = real_a_before_shift << 9'd41;
        9'd42: real_a_after_shift = real_a_before_shift << 9'd42;
        9'd43: real_a_after_shift = real_a_before_shift << 9'd43;
        9'd44: real_a_after_shift = real_a_before_shift << 9'd44;
        9'd45: real_a_after_shift = real_a_before_shift << 9'd45;
        9'd46: real_a_after_shift = real_a_before_shift << 9'd46;
        9'd47: real_a_after_shift = real_a_before_shift << 9'd47;
        9'd48: real_a_after_shift = real_a_before_shift << 9'd48;
        9'd49: real_a_after_shift = real_a_before_shift << 9'd49;
        9'd50: real_a_after_shift = real_a_before_shift << 9'd50;
        9'd51: real_a_after_shift = real_a_before_shift << 9'd51;
        9'd52: real_a_after_shift = real_a_before_shift << 9'd52;
        9'd53: real_a_after_shift = real_a_before_shift << 9'd53;
        9'd54: real_a_after_shift = real_a_before_shift << 9'd54;
        9'd55: real_a_after_shift = real_a_before_shift << 9'd55;
        9'd56: real_a_after_shift = real_a_before_shift << 9'd56;
        9'd57: real_a_after_shift = real_a_before_shift << 9'd57;
        9'd58: real_a_after_shift = real_a_before_shift << 9'd58;
        9'd59: real_a_after_shift = real_a_before_shift << 9'd59;
        9'd60: real_a_after_shift = real_a_before_shift << 9'd60;
        9'd61: real_a_after_shift = real_a_before_shift << 9'd61;
        9'd62: real_a_after_shift = real_a_before_shift << 9'd62;
        9'd63: real_a_after_shift = real_a_before_shift << 9'd63;
        9'd64: real_a_after_shift = real_a_before_shift << 9'd64;
        default:real_a_after_shift = real_a_before_shift;
    endcase
end

wire [`MAX_DIFF_WIDTH:0] int_result;
wire int_result_sign_flag;

situation_add_sub 
#(
    .b_len (first_montissa_len+second_montissa_len + 1 )
)
u_situation_add_sub(
	.a                (real_a_after_shift                ),
    .b                (real_b                ),
    .add_sub_flag     (add_sub     ),
    .a_sign_flag      (real_a_sign_flag      ),
    .b_sign_flag      (real_b_sign_flag      ),
    .int_result       (int_result       ),
    .result_sign_flag (int_result_sign_flag )
);

wire [result_montissa_len+8:0] pre_result;
customized_converter_with_frac 
#(
    .int_len      (`MAX_DIFF_WIDTH+1),
    .fra_len      (1      ),
    .montissa_len (result_montissa_len )
)
u_customized_converter_with_frac(
	.i_integer  (int_result  ),
    .i_fraction (1'b0 ),
    .sign_flag  (int_result_sign_flag  ),
    .ieee_val   (pre_result   )
);

assign result[result_montissa_len+8] = pre_result[result_montissa_len+8];
assign result[result_montissa_len+7:result_montissa_len] = pre_result[result_montissa_len+7:result_montissa_len] + exp_result_after_shift[7:0];
assign result[result_montissa_len-1:0] = pre_result[result_montissa_len-1:0];

endmodule

module situation_add_sub #
(
    parameter b_len
)(
    input [`MAX_DIFF_WIDTH:0] a,
    input [b_len-1:0] b,
    input add_sub_flag,
    input a_sign_flag,
    input b_sign_flag,
    output reg [`MAX_DIFF_WIDTH:0] int_result,
    output reg result_sign_flag
);

always @(*) begin
    case({add_sub_flag,a_sign_flag,b_sign_flag})
    3'd0:begin//+++
            result_sign_flag = 0;
            int_result = a + b;          
        end
    3'd1:begin//++-
            if(a>=b)begin
            result_sign_flag = 0;
            int_result = a - b;
            end
            else begin
            result_sign_flag = 1;
            int_result = b - a;
            end            
        end
    3'd2:begin//+-+
            if(a>=b)begin
            result_sign_flag = 1;
            int_result = a - b;
            end
            else begin
            result_sign_flag = 0;
            int_result = b - a;
            end            
        end
    3'd3:begin //+--
            result_sign_flag = 1'b1;
            int_result = a + b;        
        end
    3'd4:begin //-++
            if(a>=b)begin
            result_sign_flag = 0;
            int_result = a - b;
            end
            else begin
            result_sign_flag = 1;
            int_result = b - a;
            end         
        end
    3'd5:begin//-+-
            result_sign_flag = 0;
            int_result = a + b;           
        end
    3'd6:begin//--+
            result_sign_flag = 1'b1;
            int_result = a + b;         
        end
    3'd7:begin//---
            if(a>=b)begin
            result_sign_flag = 1;
            int_result = a - b;
            end
            else begin
            result_sign_flag = 0;
            int_result = b - a;
            end           
        end
    default: begin
            //result_sign_flag = 0;
            //int_result = a + b;
            end //nothing
    endcase
end

endmodule