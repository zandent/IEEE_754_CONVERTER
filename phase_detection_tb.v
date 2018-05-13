`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2018 11:54:48 PM
// Design Name: 
// Module Name: phase_detection_tb
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


module phase_detection_tb();

reg reset_n;
reg clk;
wire [17:0] square_out;

//integer file;

/*phase_detection DUT
(
    .clk            (clk),
    .reset_n        (reset_n),
    .TEST_SIG       (TEST_SIG),
    .REF_SINE       (REF_SINE),
    .test_out       (test_out),
    .valid          (valid)
);*/
/*
dds_compiler_2 reference(
   .aclk                (clk),
   .m_axis_data_tvalid  (),
   .m_axis_data_tdata   (REF_SINE)
   //.m_axis_data_tdata   (TEST_SIG),
   //.m_axis_phase_tdata   (),
   //.m_axis_phase_tvalid  ()
);

dds_compiler_1 test(
   .aclk                (clk),
   .s_axis_phase_tvalid (valid),
   .m_axis_data_tvalid  (),
   .m_axis_data_tdata   (TEST_SIG),
   //.m_axis_data_tdata   (REF_SINE),
   .s_axis_phase_tdata  (POFF     )
);*/


/*cordic_0 sqroot
(
    .aclk                       (clk),
    .s_axis_cartesian_tvalid    (valid),
    //.s_axis_cartesian_tdata     (mul_out),
    .s_axis_cartesian_tdata     (mul_test),
    .m_axis_dout_tdata          (square_out)
);

mult_gen_1 mul_two
(
    .CLK    (clk),
    .A      (divisor),
    .B      (filter_out),
    .P      (mul_out)
);*/

wire clk_100k;
/*filter_iir lowpass(
    .clk    (clk_100k),
    .x      (REF_SINE),
    .y      (filter_out)
);*/
reg [21:0]amp_in;
wire [21:0]amp_out;


op_amp opamp
(
    .clk            (clk),
    .reset_n        (reset_n),
    .non_inv        (amp_in),
    .square_out     (amp_out),
    .clk_100k       (clk_100k)
);


always begin
    #5 clk <= ~clk;
    
    
end

    

/*always @(posedge clk) begin
    POFF <= POFF + 16'd1820;
end*/

initial begin
clk <=1'b0;
reset_n <= 1'b0;

amp_in <= 22'd625;
//file = $fopen("phase_data2.csv","w+");
#30  reset_n <= ~reset_n;
//#1500  reset_n <= ~reset_n;
#400000
$stop();

end

/*integer j;
initial begin
    for(j=0; j <= 1910; j = j + 1)begin
        #500000 FREQ <= FREQ + 5;
    end
end*/
/*always @(posedge clk)begin
    $fwrite(file,"%d \n",refsine);
    //$fclose(file);
end*/

endmodule
