class rd_seq extends uvm_sequence#(rd_xtn);
	`uvm_object_utils(rd_seq)
		function new(string name="rd_seq");
			super.new(name);
		endfunction
endclass
