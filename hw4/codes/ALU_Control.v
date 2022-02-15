`define ADD 3'b000
`define SUB 3'b001
`define MUL 3'b010
`define AND 3'b011
`define XOR 3'b100
`define SLL 3'b101
`define SRA 3'b110

module ALU_Control (
	funct_i,
    ALUOp_i,
    ALUCtrl_o
);

	input  [9: 0] funct_i;
	input  [1: 0] ALUOp_i;
	output [2: 0] ALUCtrl_o;

	reg    [2: 0] ALUCtrl_o;

	always @(funct_i or ALUOp_i) begin
		if (ALUOp_i == 2'b10) begin
			if (funct_i[9: 3] == 7'b0) begin
				case (funct_i[2: 0])
					3'b111:  ALUCtrl_o <= `AND;
					3'b100:  ALUCtrl_o <= `XOR;
					3'b001:  ALUCtrl_o <= `SLL;
					3'b000:  ALUCtrl_o <= `ADD;
				endcase
			end
			else if (funct_i[2: 0] == 3'b0) begin
				case (funct_i[9: 3])
					7'b0100000: ALUCtrl_o <= `SUB;
					7'b0000001: ALUCtrl_o <= `MUL;
				endcase
			end
		end
		else if (ALUOp_i == 2'b00) begin
			if (funct_i[2:0] == 3'b0) begin
				ALUCtrl_o <= `ADD;
			end
			else if (funct_i == 10'b0100000_101) begin
				ALUCtrl_o <= `SRA;
			end
		end
	end
endmodule