class wr_cfg extends uvm_object;
`uvm_object_utils(wr_cfg)
	
	uvm_active_passive_enum is_active=UVM_ACTIVE;
	virtual mod_if vif;
		
	function new(string name="wr_cfg");
		super.new(name);
	endfunction
endclass
