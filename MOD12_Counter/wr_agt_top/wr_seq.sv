class wr_seq extends uvm_sequence#(wr_xtn);
	`uvm_object_utils(wr_seq)
		function new(string name="wr_seq");
			super.new(name);
		endfunction
endclass
class up_seq extends wr_seq;
	`uvm_object_utils(up_seq)
		function new(string name="up_seq");
			super.new(name);
		endfunction
		task body;
				req=wr_xtn::type_id::create("req");
				start_item(req);
				assert(req.randomize() with{mode==0;});
				//req.print();
				finish_item(req);
		endtask
endclass
class down_seq extends wr_seq;
	`uvm_object_utils(down_seq)
		function new(string name="down_seq");
			super.new(name);
		endfunction
		task body;
				req=wr_xtn::type_id::create("req");
				start_item(req);
				assert(req.randomize() with{mode==1;});
				//req.print();
				finish_item(req);
		endtask
endclass
