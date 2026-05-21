module mod_top;
	import uvm_pkg::*;
	import mod_pkg::*;
	`include "uvm_macros.svh"

	bit clk;
	always
		#5 clk=~clk;
	mod_if vif(clk);
	mod12 uut (.rst(vif.rst),.clk(clk),.mode(vif.mode),.load(vif.load),.data(vif.data),.out(vif.out));
	mod_sva svaa(vif);

	initial
		begin
		`ifdef VCS
        	 $fsdbDumpvars(0, mod_top);
        	`endif

			uvm_config_db #(virtual mod_if)::set(null,"*","wrvif",vif);
			uvm_config_db #(virtual mod_if)::set(null,"*","rdvif",vif);
			run_test();
		end
endmodule

