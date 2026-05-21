module mod12(input bit rst,clk,mode,load,input bit [3:0] data,output bit [3:0] out);
always @(posedge clk)
begin
if(rst)
	out<=4'b0000;

else if(!mode)
begin
	if(load)
		out<=data;
	else if(out!=4'b1011)
		out<=out+1'b1;
	else
		out<=4'b0000;
end
	
else if(mode)
begin
	if(load)
		out<=data;
	else if(out!=4'b0000)
		out<=out-1'b1;
	else
		out<=4'b1011;
end		


end
endmodule
