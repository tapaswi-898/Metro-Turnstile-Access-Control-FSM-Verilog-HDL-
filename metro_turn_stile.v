`timescale 10ns / 1ns
module metro_turn_stile(reset,clk,access_code,validate_code,open_access_door,state_out);
input reset,clk,validate_code;
input [3:0]access_code;
output reg open_access_door;
output [1:0]state_out ;

parameter [1:0]idle=2'b00,
          check_code=2'b01,
          access_granted= 2'b10;
reg [1:0]ps;
reg [1:0]ns;
reg [3:0]timer;

always @(*)
begin
ns= idle;
open_access_door=0;
case (ps)
   idle:begin
   if(validate_code)
   ns= check_code;
   end
   check_code:begin
   if((access_code>=4'd4)&&(access_code<=4'd11))
   ns= access_granted;
   end
   access_granted:begin
   open_access_door=1;
   if(timer==4'd15)
    ns= idle;
   else
   ns= access_granted;
   end
default:ns = idle;
endcase
end
 
always@(posedge clk or negedge reset)
begin
if(!reset)
ps<= idle;
else
ps<=ns;
end
assign state_out = ps;
always @ (posedge clk or negedge reset)
begin
if(!reset)
timer<=0;
else if (ps==access_granted)
timer<=timer+1;
else
timer<=0;
end
endmodule


 
 
  


