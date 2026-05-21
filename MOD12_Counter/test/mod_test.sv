class mod_test extends uvm_test;
	`uvm_component_utils(mod_test)
		mod_env envh;
		env_cfg cfgh;
		wr_cfg wrcfgh;
		rd_cfg rdcfgh;

		bit has_wragt=1;
		bit has_rdagt=1;
		bit has_sb=1;
		int no_of_trans=20;

		function new(string name="mod_test",uvm_component parent);
			super.new(name,parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			cfgh=env_cfg::type_id::create("cfgh");
						
			if(has_wragt==1)
			begin
				wrcfgh=wr_cfg::type_id::create("wrcfgh");
				cfgh.has_wragt=has_wragt;
				if(!uvm_config_db #(virtual mod_if)::get(this,"","wrvif",wrcfgh.vif))
					`uvm_fatal(get_type_name(),"getting of interface failed in wrconfig")
				wrcfgh.is_active=UVM_ACTIVE;
				cfgh.wrcfgh=wrcfgh;

			end
			if(has_rdagt==1)
			begin
				rdcfgh=rd_cfg::type_id::create("rdcfgh");
				cfgh.has_rdagt=has_rdagt;
				if(!uvm_config_db #(virtual mod_if)::get(this,"","rdvif",rdcfgh.vif))
					`uvm_fatal(get_type_name(),"getting of interface failed in rdconfig")
				rdcfgh.is_active=UVM_PASSIVE;
				cfgh.rdcfgh=rdcfgh;
			end
			cfgh.has_sb=has_sb;
			uvm_config_db #(env_cfg)::set(this,"*","env_cfg",cfgh);
			envh=mod_env::type_id::create("envh",this);

		endfunction
		function void end_of_elaboration_phase(uvm_phase phase);
			uvm_top.print_topology;
		endfunction
		
endclass

class up_test extends mod_test;
	`uvm_component_utils(up_test)
		up_seq useqh;
		//rd_seq rseqh;

		function new(string name="up_test",uvm_component parent);
			super.new(name,parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
		endfunction

		task run_phase(uvm_phase phase);
			phase.raise_objection(this);
			useqh=up_seq::type_id::create("useqh");
			//rseqh=rd_seq::type_id::create("rseqh");
			fork
				repeat(no_of_trans)
				begin
				useqh.start(envh.wr_toph.wragth.wrseqrh);
				//rseqh.start(envh.rd_toph.rdagth.rdseqrh);
				end
			join
			#100;
			phase.drop_objection(this);
		endtask
		
endclass

class down_test extends mod_test;
	`uvm_component_utils(down_test)
		down_seq dseqh;
		//rd_seq rseqh;

		function new(string name="down_test",uvm_component parent);
			super.new(name,parent);
		endfunction
		
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
		endfunction

		task run_phase(uvm_phase phase);
			phase.raise_objection(this);
			dseqh=down_seq::type_id::create("dseqh");
			//rseqh=rd_seq::type_id::create("rseqh");
			fork
				repeat(no_of_trans)
				begin
				dseqh.start(envh.wr_toph.wragth.wrseqrh);
				//rseqh.start(envh.rd_toph.rdagth.rdseqrh);
				end
			join
			#100;
			phase.drop_objection(this);
		endtask
		
endclass
