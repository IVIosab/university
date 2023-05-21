module srl (
		input [4:0] a,
		input [4:0] shamt,
		output [31:0] c
);
assign c = glob.r[a] >> shamt;
endmodule
