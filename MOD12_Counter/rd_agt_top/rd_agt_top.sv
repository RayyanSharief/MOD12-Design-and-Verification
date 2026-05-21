class rd_agt_top extends uvm_env;
	`uvm_component_utils(rd_agt_top)
		rd_agt rdagth;
		env_cfg cfgh;
		function new(string name="rd_agt_top",uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(env_cfg)::get(this,"","env_cfg",cfgh))
				`uvm_fatal(get_type_name(),"getting of config failed in rd_agt_top")
			uvm_config_db #(rd_cfg)::set(this,"*","rd_cfg",cfgh.rdcfgh);
			rdagth=rd_agt::type_id::create("rdagth",this);
			super.build_phase(phase);
		endfunction

endclass

