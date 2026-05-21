module mod_sva(mod_if vif);
	property ress;
		@(posedge vif.clk) vif.rst |=> vif.out==4'b0000;
	endproperty

	property down_roll;
		@(posedge vif.clk) disable iff(vif.rst||vif.load) 
			((vif.mode==1)&&(vif.out==4'b0000)) |=> vif.out==4'b1011;
	endproperty

	property up_roll;
		@(posedge vif.clk) disable iff(vif.rst||vif.load) 
			((vif.mode==0)&&(vif.out==4'b1011)) |=> vif.out==4'b0000;
	endproperty

	RESS: assert property(ress);
        /*        $info("reset is working here");
	     else
		$error("reset is not working");
*/
	DOWN_RO: assert property(down_roll);
        /*        $info("down rollback is working here");
	     else
		$error("down rollback is not working");
*/
	UP_RO: assert property(up_roll);
        /*        $info("up rollback is working here");
	     else
		$error("up rollback is not working");
*/

	CP_RESS: cover property(ress);
	CP_DOWN_RO: cover property(down_roll);
	CP_UP_RO: cover property(up_roll);

endmodule

