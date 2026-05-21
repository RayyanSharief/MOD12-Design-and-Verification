class wr_drv extends uvm_driver#(wr_xtn);
	`uvm_component_utils(wr_drv)
		wr_cfg wrcfgh;
		virtual mod_if.WRDRV wvif;
		function new(string name="wr_drv",uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(wr_cfg)::get(this,"","wr_cfg",wrcfgh))
				`uvm_fatal(get_type_name(),"getting of wr_config failed in wr drv")
		endfunction
		
		function void connect_phase(uvm_phase phase);
			wvif=wrcfgh.vif;
		endfunction
		task run_phase(uvm_phase phase);
			forever
			begin
				seq_item_port.get_next_item(req);
				send_to_dut(req);
				seq_item_port.item_done();
			end
		endtask
		task send_to_dut(wr_xtn sent);
			@(wvif.wr_drv_cb);
			wvif.wr_drv_cb.rst<=sent.rst;
			wvif.wr_drv_cb.mode<=sent.mode;
			wvif.wr_drv_cb.load<=sent.load;
			wvif.wr_drv_cb.data<=sent.data;
		//	@(wvif.wr_drv_cb);
			`uvm_info("WR_DRIVER",$sformatf("The write driver is sending values:\n %s ",sent.sprint()),UVM_LOW)			
		endtask
endclass
