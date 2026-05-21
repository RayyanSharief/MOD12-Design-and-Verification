class wr_mon extends uvm_monitor;
	`uvm_component_utils(wr_mon)
		wr_cfg wrcfgh;
		virtual mod_if.WRMON wvif;
		uvm_analysis_port #(wr_xtn) wr_mon_port;

		function new(string name="wr_mon",uvm_component parent);
			super.new(name,parent);
			wr_mon_port=new("wr_mon_port",this);			
		endfunction
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(wr_cfg)::get(this,"","wr_cfg",wrcfgh))
				`uvm_fatal(get_type_name(),"getting of wr_config failed in wr mon")
		endfunction
		
		function void connect_phase(uvm_phase phase);
			wvif=wrcfgh.vif;
		endfunction
		task run_phase(uvm_phase phase);
			forever
				collect_data();
		endtask
		task collect_data();
			wr_xtn rcvd;
			rcvd=wr_xtn::type_id::create("rcvd");
			//repeat(2)
				@(wvif.wr_mon_cb);
			rcvd.rst=wvif.wr_mon_cb.rst;
			rcvd.mode=wvif.wr_mon_cb.mode;
			rcvd.load=wvif.wr_mon_cb.load;
			rcvd.data=wvif.wr_mon_cb.data;
		//		@(wvif.wr_mon_cb);				
			`uvm_info("WR_MONITOR",$sformatf("The write monitor is receiving values:\n %s",rcvd.sprint()),UVM_LOW)			
			wr_mon_port.write(rcvd);				
		endtask

endclass
