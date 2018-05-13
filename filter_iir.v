`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2017 05:33:19 PM
// Design Name: 
// Module Name: filter_iir
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


`define number_of_floating_points 16
`define number_of_integer 22
`define total_bits 77 //`number_of_floating_points + `number_of_integer + `number_of_floating_points  + `number_of_integer + 1



module filter_iir(
    input clk,
    input   wire  signed[`number_of_integer - 1 : 0] x,
    output  wire  signed[`number_of_integer - 1 : 0] y
    );
    wire [`total_bits - 1 : 0] temp_x;
    
    //assign temp_x [`total_bits - 1 : `number_of_floating_points + `number_of_integer] = 0; // bits to avoid overflow
    //assign temp_x [`number_of_floating_points + `number_of_integer - 1 : `number_of_floating_points] = x; // 12 bits interger intput
    //assign temp_x [`number_of_floating_points - 1:0] = 0; // set decimal parts to 0
    
    assign temp_x [`total_bits - 1 : `number_of_floating_points + `number_of_integer] = {`total_bits - (`number_of_floating_points + `number_of_integer){x[`number_of_integer - 1]}}; // bits to avoid overflow
    assign temp_x [`number_of_floating_points + `number_of_integer - 1 : `number_of_floating_points] = x ; // 15 bits interger intput
    assign temp_x [`number_of_floating_points - 1:0] = 0; // set floating parts to 0
    
    wire signed [`total_bits - 1 : 0] section_connector_1, 
                 out;
                 
    //assign testin1 = section_connector_1;
    //assign testin1 = temp_x;
    
                 
                 
                 
    wire signed [`total_bits - 1 : 0] coef_a_1,
                 coef_a_2;
    wire signed [`total_bits - 1 : 0] coef_b_1,
                 coef_b_2;
    wire signed [`total_bits - 1 : 0] coef_c_1,
                 coef_c_2;             
    wire signed [`total_bits - 1 : 0] coef_d_1,
                 coef_d_2;           
                 
//    assign coef_a_1 = `total_bits'd1;
//    assign coef_a_15 = `total_bits'd63;
//    assign coef_b_1 = -`total_bits'd8061;
//    assign coef_b_15 = -`total_bits'd3969;
//    assign coef_c_1 = `total_bits'd3969;
//    assign coef_c_15 = `total_bits'd0;
//    assign coef_d_1 = `total_bits'd8192;
//    assign coef_d_15 = `total_bits'd4096;
    //20k cut off             
    //assign coef_a_1 = `total_bits'd1;
    //assign coef_a_2 = `total_bits'd15;
    //100k cut off
    //assign coef_a_1 = `total_bits'd1;
    //assign coef_a_2 = `total_bits'd205;
    //50k cut off
    //assign coef_a_1 = `total_bits'd5;
    //assign coef_a_2 = `total_bits'd35;
    //20k cut off 10MHz Fs
    //assign coef_a_1 = `total_bits'd243;
    //assign coef_a_2 = `total_bits'd3879;
    //1Hz
    assign coef_a_1 = `total_bits'd2;
    
/*  assign coef_a_3 = `total_bits'd1;
    assign coef_a_4 = `total_bits'd1;
    assign coef_a_5 = `total_bits'd1;
    assign coef_a_6 = `total_bits'd1;
    assign coef_a_7 = `total_bits'd1;
    assign coef_a_8 = `total_bits'd1;
    assign coef_a_9 = `total_bits'd1;
    assign coef_a_10 = `total_bits'd1;
    assign coef_a_11 = `total_bits'd1;
    assign coef_a_12 = `total_bits'd1;
    assign coef_a_13 = `total_bits'd1;
    assign coef_a_14 = `total_bits'd1;
    assign coef_a_15 = `total_bits'd65;*/
    //20k cut off
    //assign coef_b_1 = - `total_bits'd122370;
    //assign coef_b_2 = - `total_bits'd57778;
    //100k cut off
    //assign coef_b_1 = - `total_bits'd130659;
    //assign coef_b_2 = - `total_bits'd65126;
    //50k cut off
    //assign coef_b_1 = - `total_bits'd422;
    //assign coef_b_2 = - `total_bits'd186;
    //100k cut off 10MHz Fs    
    //assign coef_b_1 = - `total_bits'd495;
    //assign coef_b_2 = - `total_bits'd240;
    //1Hz
    assign coef_b_1 = - `total_bits'd65532;
    
/*  assign coef_b_3 = -`total_bits'd8118;
    assign coef_b_4 = -`total_bits'd8091;
    assign coef_b_5 = -`total_bits'd8066;
    assign coef_b_6 = -`total_bits'd8043;
    assign coef_b_7 = -`total_bits'd8021;
    assign coef_b_8 = -`total_bits'd8001;
    assign coef_b_9 = -`total_bits'd7983;
    assign coef_b_10 = -`total_bits'd7968;
    assign coef_b_11 = -`total_bits'd7956;
    assign coef_b_12 = -`total_bits'd7946;
    assign coef_b_13 = -`total_bits'd7938;
    assign coef_b_14 = -`total_bits'd7934;
    assign coef_b_15 = -`total_bits'd3966;*/
    
    
    //20k cut off
    //assign coef_c_1 = `total_bits'd57807;
    //assign coef_c_2 = `total_bits'd0;
    //100k cut off
    //assign coef_c_1 = `total_bits'd65126;
    //assign coef_c_2 = `total_bits'd1;  
    //50k cut off
    //assign coef_c_1 = `total_bits'd187;
    //assign coef_c_2 = `total_bits'd1;  
    //100k cut off 10MHz Fs
    //assign coef_c_1 = `total_bits'd240;
    //assign coef_c_2 = `total_bits'd1;  
    //1Hz
    assign coef_c_1 = `total_bits'd65536;
/*    assign coef_c_3 = `total_bits'd4026;
    assign coef_c_4 = `total_bits'd4000;
    assign coef_c_5 = `total_bits'd3974;
    assign coef_c_6 = `total_bits'd3951;
    assign coef_c_7 = `total_bits'd3929;
    assign coef_c_8 = `total_bits'd3909;
    assign coef_c_9 = `total_bits'd3892;
    assign coef_c_10 = `total_bits'd3876;
    assign coef_c_11 = `total_bits'd3864;
    assign coef_c_12 = `total_bits'd3854;
    assign coef_c_13 = `total_bits'd3847;
    assign coef_c_14 = `total_bits'd3842;
    assign coef_c_15 = `total_bits'd1;*/
    
    assign coef_d_1 = `total_bits'd65536;
    //assign coef_d_2 = `total_bits'd65536;
/*    assign coef_d_3 = `total_bits'd8192;
    assign coef_d_4 = `total_bits'd8192;
    assign coef_d_5 = `total_bits'd8192;
    assign coef_d_6 = `total_bits'd8192;
    assign coef_d_7 = `total_bits'd8192;
    assign coef_d_8 = `total_bits'd8192;
    assign coef_d_9 = `total_bits'd8192;
    assign coef_d_10 = `total_bits'd8192;
    assign coef_d_11 = `total_bits'd8192;
    assign coef_d_12 = `total_bits'd8192;
    assign coef_d_13 = `total_bits'd8192;*/
    //assign coef_d_1 = `total_bits'd8192;
    //assign coef_d_2 = `total_bits'd4096;
    
    /*lowpass_section_sample section_1(
        .clk        (clk), 
        .x          (temp_x), 
        .coef_a     (coef_a_1), 
        .coef_b     (coef_b_1), 
        .coef_c     (coef_c_1), 
        .coef_d     (coef_d_1), 
        .y          (section_connector_1)
    );
    lowpass_section_sample sectino_2(
        .clk        (clk), 
        .x          (section_connector_1), 
        .coef_a     (coef_a_1), 
        .coef_b     (coef_b_1), 
        .coef_c     (coef_c_1), 
        .coef_d     (coef_d_1), 
        .y          (section_connector_2)
    );
    
    lowpass_section_sample sectino_3(
        .clk        (clk), 
        .x          (section_connector_2), 
        .coef_a     (coef_a_3), 
        .coef_b     (coef_b_3), 
        .coef_c     (coef_c_3), 
        .coef_d     (coef_d_3), 
        .y          (section_connector_3)
    );
    
    lowpass_section_sample sectino_4(
        .clk        (clk), 
        .x          (section_connector_3), 
        .coef_a     (coef_a_4), 
        .coef_b     (coef_b_4), 
        .coef_c     (coef_c_4), 
        .coef_d     (coef_d_4), 
        .y          (section_connector_4)
     );
    lowpass_section_sample sectino_5(
        .clk        (clk), 
        .x          (section_connector_4), 
        .coef_a     (coef_a_5), 
        .coef_b     (coef_b_5), 
        .coef_c     (coef_c_5), 
        .coef_d     (coef_d_5), 
        .y          (section_connector_5)
     );        
    lowpass_section_sample sectino_6(
        .clk        (clk), 
        .x          (section_connector_5), 
        .coef_a     (coef_a_6), 
        .coef_b     (coef_b_6), 
        .coef_c     (coef_c_6), 
        .coef_d     (coef_d_6), 
        .y          (section_connector_6)
     );
    lowpass_section_sample sectino_7(
        .clk        (clk), 
        .x          (section_connector_6), 
        .coef_a     (coef_a_7), 
        .coef_b     (coef_b_7), 
        .coef_c     (coef_c_7), 
        .coef_d     (coef_d_7), 
        .y          (section_connector_7)
     );
    lowpass_section_sample sectino_8(
        .clk        (clk), 
        .x          (section_connector_7), 
        .coef_a     (coef_a_8), 
        .coef_b     (coef_b_8), 
        .coef_c     (coef_c_8), 
        .coef_d     (coef_d_8), 
        .y          (section_connector_8)
    );
    lowpass_section_sample sectino_9(
        .clk        (clk), 
        .x          (section_connector_8), 
        .coef_a     (coef_a_9), 
        .coef_b     (coef_b_9), 
        .coef_c     (coef_c_9), 
        .coef_d     (coef_d_9), 
        .y          (section_connector_9)
    );
    lowpass_section_sample sectino_10(
        .clk        (clk), 
        .x          (section_connector_9), 
        .coef_a     (coef_a_10), 
        .coef_b     (coef_b_10), 
        .coef_c     (coef_c_10), 
        .coef_d     (coef_d_10), 
        .y          (section_connector_10)
    );
    lowpass_section_sample sectino_11(
        .clk        (clk), 
        .x          (section_connector_10), 
        .coef_a     (coef_a_11), 
        .coef_b     (coef_b_11), 
        .coef_c     (coef_c_11), 
        .coef_d     (coef_d_11), 
        .y          (section_connector_11)
    );
    lowpass_section_sample sectino_12(
        .clk        (clk), 
        .x          (section_connector_11), 
        .coef_a     (coef_a_12), 
        .coef_b     (coef_b_12), 
        .coef_c     (coef_c_12), 
        .coef_d     (coef_d_12), 
        .y          (section_connector_12)
    );
    lowpass_section_sample sectino_13(
        .clk        (clk), 
        .x          (section_connector_12), 
        .coef_a     (coef_a_12), 
        .coef_b     (coef_b_12), 
        .coef_c     (coef_c_12), 
        .coef_d     (coef_d_12), 
        .y          (section_connector_13)
    );
    lowpass_section_sample sectino_14(
        .clk        (clk), 
        .x          (section_connector_13), 
        .coef_a     (coef_a_14), 
        .coef_b     (coef_b_14), 
        .coef_c     (coef_c_14), 
        .coef_d     (coef_d_14), 
        .y          (section_connector_14)
     );  */             
     last_section last(
     .clk           (clk),
     .x             (temp_x),
     .coef_a        (coef_a_1),
     .coef_b        (coef_b_1),
     .y             (out)
     );           
    /*lowpass_section_sample sectino_1(temp_x, section_connector_1, coef_a_1, coef_b_1, coef_c_1, coef_d_1, clk);
    lowpass_section_sample sectino_2(section_connector_1, section_connector_2, coef_a_2, coef_b_2, coef_c_2, coef_d_2, clk);
    lowpass_section_sample sectino_3(section_connector_2, section_connector_3, coef_a_3, coef_b_3, coef_c_3, coef_d_3, clk);
    lowpass_section_sample sectino_4(section_connector_3, section_connector_4, coef_a_4, coef_b_4, coef_c_4, coef_d_4, clk);
    lowpass_section_sample sectino_5(section_connector_4, section_connector_5, coef_a_5, coef_b_5, coef_c_5, coef_d_5, clk);
    lowpass_section_sample sectino_6(section_connector_5, section_connector_6, coef_a_6, coef_b_6, coef_c_6, coef_d_6, clk);
    lowpass_section_sample sectino_7(section_connector_6, section_connector_7, coef_a_7, coef_b_7, coef_c_7, coef_d_7, clk);
    lowpass_section_sample sectino_8(section_connector_7, section_connector_8, coef_a_8, coef_b_8, coef_c_8, coef_d_8, clk);
    lowpass_section_sample sectino_9(section_connector_8, section_connector_9, coef_a_9, coef_b_9, coef_c_9, coef_d_9, clk);
    lowpass_section_sample sectino_10(section_connector_9, section_connector_10, coef_a_10, coef_b_10, coef_c_10, coef_d_10, clk);
    lowpass_section_sample sectino_11(section_connector_10, section_connector_11, coef_a_11, coef_b_11, coef_c_11, coef_d_11, clk);
    lowpass_section_sample sectino_12(section_connector_11, section_connector_12, coef_a_12, coef_b_12, coef_c_12, coef_d_12, clk);
    lowpass_section_sample sectino_13(section_connector_12, section_connector_13, coef_a_13, coef_b_13, coef_c_13, coef_d_13, clk);
    lowpass_section_sample sectino_14(section_connector_13, section_connector_14, coef_a_14, coef_b_14, coef_c_14, coef_d_14, clk);
    last_section last (section_connector_14, out, coef_a_15, coef_b_15, clk);*/

//    lowpass_section_sample sectino_1(temp_x, section_connector_1, coef_a_1, coef_b_1, coef_c_1, coef_d_1, clk);
//    last_section last (section_connector_1, out, coef_a_15, coef_b_15, clk);

    assign y = out [`number_of_floating_points + `number_of_integer - 1 : `number_of_floating_points];

endmodule
