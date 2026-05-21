class rd_agt extends uvm_agent;
	`uvm_component_utils(rd_agt)
		rd_mon rdmonh;
		rd_seqr rdseqrh;
		rd_drv rddrvh;
		rd_cfg rdcfgh;
		function new(string name="rd_agt",uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(rd_cfg)::get(this,"","rd_cfg",rdcfgh))
				`uvm_fatal(get_type_name(),"getting of rd_config failed in rd_agt")

			rdmonh=rd_mon::type_id::create("rdmonh",this);
			if(rdcfgh.is_active==UVM_ACTIVE)
			begin
			rdseqrh=rd_seqr::type_id::create("rdseqrh",this);
			rddrvh=rd_drv::type_id::create("rddrvh",this);
			end
		endfunction
		function void connect_phase(uvm_phase phase);
			if(rdcfgh.is_active==UVM_ACTIVE)
				rddrvh.seq_item_port.connect(rdseqrh.seq_item_export);
		endfunction


endclass

