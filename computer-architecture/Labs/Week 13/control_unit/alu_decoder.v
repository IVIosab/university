module alu_decoder (
	input [1:0] ALUOp,
	input [5:0] funct,
	output reg [2:0] ALUControl
);

always@(*) begin
		case(ALUOp)
			2'b00: ALUControl = 3'b010;
			2'b01: ALUControl = 3'b110;
			2'b10: begin 
				case(funct)
					6'h20: ALUControl = 3'b010;
					6'h22: ALUControl = 3'b110;
					6'h24: ALUControl = 3'b000;
					6'h25: ALUControl = 3'b001;
					6'h2A: ALUControl = 3'b111;
				endcase
			end
		endcase
	end
endmodule 
