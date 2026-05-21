class mod_env extends uvm_env;
	`uvm_component_utils(mod_env)
		wr_agt_top wr_toph;
		rd_agt_top rd_toph;
		mod_sb sbh;
		env_cfg cfgh;

		function new(string name="mod_env",uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(env_cfg)::get(this,"","env_cfg",cfgh))
				`uvm_fatal(get_type_name(),"getting of config failed in env")

			if(cfgh.has_wragt==1)
				wr_toph=wr_agt_top::type_id::create("wr_toph",this);
			if(cfgh.has_rdagt==1)
				rd_toph=rd_agt_top::type_id::create("rd_toph",this);
			if(cfgh.has_sb==1)
				sbh=mod_sb::type_id::create("sbh",this);
			super.build_phase(phase);

		endfunction
		function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			if(cfgh.has_sb)
			begin
				wr_toph.wragth.wrmonh.wr_mon_port.connect(sbh.fifoh_w.analysis_export);
				rd_toph.rdagth.rdmonh.rd_mon_port.connect(sbh.fifoh_r.analysis_export);
			end
		endfunction

endclass
