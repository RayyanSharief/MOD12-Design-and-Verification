class rd_xtn extends uvm_sequence_item;
	`uvm_object_utils(rd_xtn)
		bit [3:0] out;
		function new(string name="rd_xtn");
			super.new(name);
		endfunction
		
		function void do_print(uvm_printer printer);
			super.do_print(printer);
			printer.print_field("Count(Output)",this.out,4,UVM_DEC);
		endfunction
endclass
