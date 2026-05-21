class env_cfg extends uvm_object;
`uvm_object_utils(env_cfg)
	bit has_wragt;
	bit has_rdagt;
	bit has_sb;
	wr_cfg wrcfgh;
	rd_cfg rdcfgh;
	
	function new(string name="env_cfg");
		super.new(name);
	endfunction
endclass
