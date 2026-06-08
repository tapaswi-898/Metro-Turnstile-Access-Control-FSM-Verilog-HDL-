`timescale 10ns/1ns
module testbench;
reg reset,clk=0,validate_code;
reg [3:0]access_code;
wire open_access_door;
wire [1:0]state_out;

parameter [1:0]idle=2'b00,
          check_code=2'b01,
          access_granted=2'b10;
          
metro_turn_stile DUT (reset,clk,access_code,validate_code,open_access_door,state_out);
initial
begin
forever #1 clk = ~clk;
end
initial
begin
$monitor($time,"reset=%b,clk=%b,access_code=%b,validate_code=%b,open_access_door=%b,state_out=%b",reset,clk,access_code,validate_code,open_access_door,state_out);
reset = 0;
#2.5 reset= 1;validate_code=0;access_code=0;
@(posedge clk);
validate_code=1; access_code=0;
@(posedge clk);
validate_code=1; access_code=0;
@(posedge clk);
validate_code=1; access_code=9;
@(posedge clk);
validate_code=0; access_code=9;
#40 $finish;
end
endmodule