`define R_TYPE 7'b0110011
`define I_TYPE 7'b0010011

module Control (
    Op_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o
);

	input  [6:0] Op_i;
	output [1:0] ALUOp_o;
	output       ALUSrc_o;
	output       RegWrite_o;

	reg [1:0]    ALUOp_o;
	reg          ALUSrc_o;
	reg          RegWrite_o;

	always @(Op_i) begin
		if (Op_i == `R_TYPE) begin
			ALUOp_o <= 2'b10;
			ALUSrc_o <= 1'b0;
		end
		else if (Op_i == `I_TYPE) begin
			ALUOp_o <= 2'b00;
			ALUSrc_o <= 1'b1;
		end
		
		RegWrite_o <= 1'b1;
	end

endmodule