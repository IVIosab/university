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

module exercise5 (
	input clk ,
	input d,
	output q,
	output q_n
);
wire n1;

exercise4 master (
	.clk ( ~ clk ),
	.d ( d ),
	.q ( n1 )
);

exercise4 slave (
	.clk ( clk ),
	.d ( n1 ),
	.q ( q ),
	.q_n ( q_n )
);
endmodule