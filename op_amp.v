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

module op_amp
#(
    parameter C_WIDTH = 16
)

(
    input clk,
    input reset_n,
    input signed [C_WIDTH + 5 : 0] non_inv,
    output wire signed [C_WIDTH + 5 : 0] square_out,
    output reg clk_100k
);

/*reg signed [C_WIDTH + 5 : 0] mul_out;
reg signed [C_WIDTH - 1 : 0] sum;
reg [C_WIDTH - 1 : 0] square;
wire signed [C_WIDTH + 5 : 0] filter_out;*/

reg signed [21 : 0] mul_out;
reg signed [21 : 0] sum;
reg signed [44 : 0] square;


wire signed [C_WIDTH + 5 : 0] filter_out;

reg signed [100:0] test;
wire [12:0] const;
wire [12:0] const2;

wire [21:0] filter_unsigned;
wire [21:0] mul_unsigned;
assign const = 13'd625;
assign const2 = 13'd650;

filter_iir lowpass
(
    .clk    (clk_100k),
    .x      (mul_out),
    .y      (filter_out)
);
 
assign square_out = filter_out;
//assign mul_unsigned = 22'b1000000000000000000000 + mul_out;
//assign filter_out = filter_unsigned - 22'b1000000000000000000000;
//assign square_out = mul_out; 

always @ (posedge clk_100k or negedge reset_n)begin
    if(!reset_n)begin
        mul_out <= 1;   
        sum <= 0; 
        square <= 0;
        test <= 0;
    end  
    /*else begin
        if((sum*100) >= (2**(C_WIDTH+6)))begin
            mul_out <= (2**(C_WIDTH+6)) - 1;
            //square = mul_out * mul_out;
            square = filter_out * filter_out;
            sum = non_inv - square;
        end
        if((non_inv - square) >= 2**C_WIDTH)begin
            mul_out <= sum * 100;
            //square = mul_out * mul_out;
            square = filter_out * filter_out;
            sum <= (2**C_WIDTH) - 1; 
        end
        if ((mul_out * mul_out) >= 2**C_WIDTH )begin
            mul_out <= sum * 100;
            square <= (2**C_WIDTH) - 1;
            sum = non_inv - square;
        end
        else begin
            mul_out <= sum * 100;
            //square = mul_out * mul_out;
            square = filter_out * filter_out;
            sum = non_inv - square;
        end
    end*/
    else begin
        /*if(mul_out <= 0)begin
            mul_out <= sum * 100;
            //square = mul_out * mul_out;
            square <= filter_out * filter_out;
            square[44] = 1'b1;
            sum <= non_inv - square;
            test <= 0;
        end*/
        //else begin
            mul_out <= sum * 100;
            //square = mul_out * mul_out;
            square <= filter_out * filter_out;
            sum <= non_inv - square;
            test <= const - const2;   
        //end
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
