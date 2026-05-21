class wr_agt_top extends uvm_env;
	`uvm_component_utils(wr_agt_top)
		wr_agt wragth;
		env_cfg cfgh;
		function new(string name="wr_agt_top",uvm_component parent);
			super.new(name,parent);
		endfunction
		function void build_phase(uvm_phase phase);
			if(!uvm_config_db #(env_cfg)::get(this,"","env_cfg",cfgh))
				`uvm_fatal(get_type_name(),"getting of config failed in wr_agt_top")
			uvm_config_db #(wr_cfg)::set(this,"*","wr_cfg",cfgh.wrcfgh);
			wragth=wr_agt::type_id::create("wragth",this);
			super.build_phase(phase);
		endfunction

endclass
