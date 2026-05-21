class rd_mon extends uvm_monitor;
	`uvm_component_utils(rd_mon)
		rd_cfg rdcfgh;
		virtual mod_if.RDMON rvif;
		uvm_analysis_port #(rd_xtn) rd_mon_port;

		function new(string name="rd_mon",uvm_component parent);
			super.new(name,parent);
			rd_mon_port=new("rd_mon_port",this);
		endfunction
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(rd_cfg)::get(this,"","rd_cfg",rdcfgh))
				`uvm_fatal(get_type_name(),"getting of rd_config failed in rd mon")
		endfunction
		
		function void connect_phase(uvm_phase phase);
			rvif=rdcfgh.vif;
		endfunction
		task run_phase(uvm_phase phase);
			forever
				collect_data();
		endtask
		task collect_data();
			rd_xtn rdcvd;
			rdcvd=rd_xtn::type_id::create("rdcvd");
				@(rvif.rd_mon_cb);
			rdcvd.out=rvif.rd_mon_cb.out;
		//		@(rvif.rd_mon_cb);
			`uvm_info("RD_MONITOR",$sformatf("The read monitor is receiving values:\n %s",rdcvd.sprint()),UVM_LOW)
			rd_mon_port.write(rdcvd);
		endtask
endclass
