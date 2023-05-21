module exercise3
(
	input s,
	input r,
	output q,
	output q_n
);
	assign q = ~ ( r | q_n );
	assign q_n = ~ ( s | q );
endmodule

module exercise4
(
	input clk ,
	input d,
	output q,
	output q_n
);
	wire r = ~d & clk;
	wire s = d & clk ;

	exercise3 exercise3 (s, r, q, q_n);
endmodule