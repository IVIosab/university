module add (
		input [4:0] a, b,
		output [31:0] c
);
assign c = glob.r[a] + glob.r[b];
endmodule
