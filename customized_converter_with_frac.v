`timescale 1ns / 1ps
//not necessary to customize (expend) exponent width, useless to improve precision
//exponent width is still 8 bits, in order to precision, recommand montissa width is no longer than 128 bits
module customized_converter_with_frac # 
(
    parameter int_len,
    parameter fra_len,
    //parameter exp_bit_len,
    parameter montissa_len
)(
    input [int_len-1:0]i_integer,
    input [fra_len-1:0]i_fraction,
    input sign_flag,
    output [montissa_len+8:0] ieee_val
);
wire [7:0] exp;
wire [montissa_len-1:0] montissa;
reg [7:0] counter_max[int_len+fra_len-1:0];
reg [int_len+fra_len-1:0] counter_max_flag;
wire [int_len+fra_len-1:0] flag_for_counter_max_flag;
assign flag_for_counter_max_flag[int_len+fra_len-1] = counter_max_flag[int_len+fra_len-1];

genvar m;
generate
    for (m=(int_len+fra_len-2); m>=0; m=m-1 ) begin: flag_for_counter_max_flag_assign
        assign flag_for_counter_max_flag[m] = flag_for_counter_max_flag[m+1] | counter_max_flag[m];
    end
endgenerate


genvar i;
generate
    for (i=(int_len+fra_len-1); i>=0; i=i-1 ) begin: counter_assign
        always @(*) begin
            if(i==int_len+fra_len-1) begin
               if(i_integer[int_len-1]) begin
                counter_max_flag[i] = 1'b1;
                counter_max[i] = 0;
                end
               else begin
                counter_max_flag[i] = 0;
                counter_max[i] = 1'b1;
                end
            end               
            else if(i>=fra_len) begin
                if(~(flag_for_counter_max_flag[i])) 
                    counter_max[i] = counter_max[i+1] + 1'b1;
                else 
                    counter_max[i] = counter_max[i+1];
                if(i_integer[i-fra_len] && (~(flag_for_counter_max_flag[i+1]) ) )
                counter_max_flag[i] = 1'b1;
               else 
                counter_max_flag[i] = 0;   
            end
            else begin
                if(~(flag_for_counter_max_flag[i])) 
                    counter_max[i] = counter_max[i+1] + 1'b1;
                else 
                    counter_max[i] = counter_max[i+1];
                if(i_fraction[i]&&(~(flag_for_counter_max_flag[i+1]) ) )
                counter_max_flag[i] = 1'b1;
               else 
                counter_max_flag[i] = 0;
            end

        end
    end
endgenerate

assign exp = int_len-counter_max[0] + 8'd126;

wire [int_len+fra_len-1:0] flag_for_montissa[montissa_len:0];
assign flag_for_montissa[montissa_len] = counter_max_flag;

genvar k;
generate
    for (k=montissa_len-1; k>=0; k=k-1 ) begin: flag_for_montissa_assign
        assign flag_for_montissa[k] = flag_for_montissa[k+1]>>1'b1;
    end
endgenerate

genvar j;
generate
    for (j=montissa_len-1; j >= 0 ;j=j-1) begin: mon_assign
         assign montissa[j] = |(flag_for_montissa[j] & {i_integer, i_fraction});
    end
endgenerate
assign ieee_val = ( (|i_fraction) | (|i_integer) )? {sign_flag,exp,montissa} : 0;
endmodule
