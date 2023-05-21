module control_unit(
	input [5:0] opcode, funct,
	output MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite,
 	output [2:0] ALUControl
);

	wire [1:0] ALUOp;

	main_decoder main_decoder(opcode, ALUOp, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite);
	alu_decoder alu_decoder(ALUOp, funct, ALUControl);

endmodule
