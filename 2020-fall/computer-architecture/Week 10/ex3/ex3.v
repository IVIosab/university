module ex3(
	input [15:0] fir,
	input [15:0] sec,
	output [15:0] ot,
	output [1:0] bit
);

	wire [16:0] wr;
	wire [15:0] sm;

	assign wr[0]=1'b0;

	genvar i;
	generate 
		for(i=0;i<16;i=i+1)
			begin: add
				full fa
				(.x(fir[i]),.y(sec[i]),.in(wr[i]),.sum(sm[i]),.out(wr[i+1]));
			end
	endgenerate 
	assign bit = wr[16];
	assign ot = sm;
endmodule 