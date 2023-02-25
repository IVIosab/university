module mux(
		input [31:0] a, b, c,
		input [5:0]  d,
		output [4:0] rd
);
	
always@(*) begin
	case(d)
		6'b100000: begin
			 glob.r[rd] = a;
		end
		6'b100010: begin
			 glob.r[rd] = b;
		end
		6'b000010: begin
			glob.r[rd] = c;
		end
	endcase
end
endmodule
