class rd_drv extends uvm_driver#(rd_xtn);
	`uvm_component_utils(rd_drv)
		function new(string name="rd_drv",uvm_component parent);
			super.new(name,parent);
		endfunction
endclass
