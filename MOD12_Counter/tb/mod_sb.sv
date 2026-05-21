class mod_sb extends uvm_scoreboard;
`uvm_component_utils(mod_sb)

	wr_xtn cov_sent,sent;
	rd_xtn cov_received,received;
	int xtn_count;
	bit [3:0] res;	
	env_cfg cfgh;
	uvm_tlm_analysis_fifo #(wr_xtn) fifoh_w;
	uvm_tlm_analysis_fifo #(rd_xtn) fifoh_r;

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(env_cfg)::get(this,"","env_cfg",cfgh))
			`uvm_fatal(get_type_name(),"getting of config failed in scoreboard")
		if(cfgh.has_wragt)
			fifoh_w=new("fifoh_w",this);
		if(cfgh.has_rdagt)
			fifoh_r=new("fifoh_r",this);
		sent=wr_xtn::type_id::create("sent");
		received=rd_xtn::type_id::create("received");
	endfunction

	covergroup wr_cov;
		option.per_instance=1; 
		// .per_instance helps us see the coverage % at each coverpoint of the covergroup(by default [0] merges each instances as one ).
		// .auto_bin_max helps in setting a fixed amount of bins for each coverpoint (by default it is 64 )	
		W_RST: coverpoint cov_sent.rst{bins rst_bin[]={0,1};}
		W_MODE: coverpoint cov_sent.mode{bins mode_bin[]={0,1};}
		W_LOAD: coverpoint cov_sent.load{bins load_bin[]={0,1};}
		W_DATA: coverpoint cov_sent.data{bins data_bin[]={[0:11]};}
		W_CROSS: cross W_RST,W_MODE,W_LOAD;
	endgroup
		
	covergroup rd_cov;
		option.per_instance=1; 
		R_OUT: coverpoint cov_received.out{bins out_bin[]={[0:11]};}
	endgroup

	function new(string name="mod_sb",uvm_component parent);
		super.new(name,parent);
		wr_cov=new();
		rd_cov=new();
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
		begin
			fork
				begin
					fifoh_w.get(sent);
					sent.print();
					cov_sent=sent;
					wr_cov.sample();
				end
				begin
					fifoh_r.get(received);
					received.print();
					cov_received=received;
					rd_cov.sample();
				end			
			join
			compares(sent,received);
		end
	endtask

	function void compares(wr_xtn sen,rd_xtn rec);
	//	xtn_count++;

	//	always @(posedge sen.clk)
	//	begin
		if(sen.rst)
			res<=4'b0000;

		else if(!sen.mode)
		begin
			if(sen.load)
				res<=sen.data;
			else if(res!=4'b1011)
				res<=res+1'b1;
			else
				res<=4'b0000;
		end
	
		else if(sen.mode)
		begin
			if(sen.load)
				res<=sen.data;
			else if(res!=4'b0000)
				res<=res-1'b1;
			else
				res<=4'b1011;
		end
	//	end
		
		if(res==rec.out)
			`uvm_info(get_type_name(),"comparison result is equal",UVM_LOW)
		else
			`uvm_info(get_type_name(),"comparison result is NOT equal",UVM_LOW)

		xtn_count++;
	endfunction

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(),$sformatf("Simulation report from Scoreboard \n no of transactions = %0d",xtn_count),UVM_LOW)
	endfunction
endclass
