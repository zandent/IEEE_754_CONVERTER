module int_frac_converter(
    input [31:0] ieee_val,
    output reg [7:0] int,
    output reg [7:0] frac
);

wire [7:0]exp = ieee_val[30:23] - 8'd127;
always@(*) begin
  case(exp)
    8'd0:begin 
    int = {1'b1};
    frac = ieee_val[22:15];
    end
    8'd1:begin 
    int = {1'b1,ieee_val[22:22]};
    frac = ieee_val[21:14];
    end
    8'd2:begin 
    int = {1'b1,ieee_val[22:21]};
    frac = ieee_val[20:13];
    end
    8'd3:begin 
    int = {1'b1,ieee_val[22:20]};
    frac = ieee_val[19:12];
    end
    8'd4:begin 
    int = {1'b1,ieee_val[22:19]};
    frac = ieee_val[18:11];
    end
    8'd5:begin 
    int = {1'b1,ieee_val[22:18]};
    frac = ieee_val[17:10];
    end
    8'd6:begin 
    int = {1'b1,ieee_val[22:17]};
    frac = ieee_val[16:9];
    end
    8'd7:begin 
    int = {1'b1,ieee_val[22:16]};
    frac = ieee_val[15:8];
    end
    8'd8:begin 
    int = {1'b1,ieee_val[22:15]};
    frac = ieee_val[14:7];
    end
    8'd9:begin 
    int = {1'b1,ieee_val[22:14]};
    frac = ieee_val[13:6];
    end
    default:begin
    int = {1'b1};
    frac = ieee_val[22:15];
    end
  endcase
end

endmodule