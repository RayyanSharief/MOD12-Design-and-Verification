class rd_cfg extends uvm_object;
`uvm_object_utils(rd_cfg)
	
	uvm_active_passive_enum is_active=UVM_ACTIVE;
	virtual mod_if vif;
		
	function new(string name="rd_cfg");
		super.new(name);
	endfunction
endclass
