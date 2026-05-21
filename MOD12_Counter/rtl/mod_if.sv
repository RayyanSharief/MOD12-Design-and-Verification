interface mod_if(input bit clk);
	bit rst;
	bit mode;
	bit load;
	bit [3:0] data;
	bit [3:0] out;
	
	clocking wr_drv_cb @(posedge clk);
		default input#1 output#1;
		output rst;
		output mode;
		output load;
		output data;
	endclocking
	clocking wr_mon_cb @(posedge clk);
		default input#1 output#1;
		input rst;
		input mode;
		input load;
		input data;
	endclocking
	clocking rd_mon_cb @(posedge clk);
		default input#1 output#1;
		input out;
	endclocking
	modport WRDRV (clocking wr_drv_cb);
	modport WRMON (clocking wr_mon_cb);
	modport RDMON (clocking rd_mon_cb);

	property ress;
		@(posedge clk) rst |=> out==4'b0000;
	endproperty

	property down_roll;
		@(posedge clk) disable iff(rst||load) 
			((mode==1)&&(out==4'b0000)) |=> out==4'b1011;
	endproperty

	property up_roll;
		@(posedge clk) disable iff(rst||load) 
			((mode==0)&&(out==4'b1011)) |=> out==4'b0000;
	endproperty

	RESS: assert property(ress);
	DOWN_RO: assert property(down_roll);
	UP_RO: assert property(up_roll);

	CP_RESS: cover property(ress);
	CP_DOWN_RO: cover property(down_roll);
	CP_UP_RO: cover property(up_roll);

endinterface
