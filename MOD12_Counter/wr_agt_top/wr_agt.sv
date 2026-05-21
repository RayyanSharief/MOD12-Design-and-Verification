class wr_agt extends uvm_agent;
	`uvm_component_utils(wr_agt)
		wr_mon wrmonh;
		wr_seqr wrseqrh;
		wr_drv wrdrvh;
		wr_cfg wrcfgh;
		function new(string name="wr_agt",uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(wr_cfg)::get(this,"","wr_cfg",wrcfgh))
				`uvm_fatal(get_type_name(),"getting of wr_config failed in wr_agt")

			wrmonh=wr_mon::type_id::create("wrmonh",this);
			if(wrcfgh.is_active==UVM_ACTIVE)
			begin
			wrseqrh=wr_seqr::type_id::create("wrseqrh",this);
			wrdrvh=wr_drv::type_id::create("wrdrvh",this);
			end
		endfunction
		function void connect_phase(uvm_phase phase);
			if(wrcfgh.is_active==UVM_ACTIVE)
				wrdrvh.seq_item_port.connect(wrseqrh.seq_item_export);
		endfunction


endclass
