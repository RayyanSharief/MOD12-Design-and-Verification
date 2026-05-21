class wr_xtn extends uvm_sequence_item;
`uvm_object_utils(wr_xtn)
	rand bit rst;
	rand bit mode;
	rand bit load;
	rand bit [3:0] data;
//	bit [3:0] out;
	constraint RST{rst dist{0:=11,1:=1};}
	constraint LOAD{load dist{0:=12,1:=3};}
	constraint DATA{data inside{[0:11]};}	
	function new(string name="wr_xtn");
		super.new(name);
	endfunction
	function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("Reset",this.rst,1,UVM_DEC);
		printer.print_field("Mode",this.mode,1,UVM_DEC);
		printer.print_field("Load",this.load,1,UVM_DEC);
		printer.print_field("Data",this.data,4,UVM_DEC);
//		printer.print_field("Count(output)",this.out,4,UVM_DEC);		
	endfunction
endclass
