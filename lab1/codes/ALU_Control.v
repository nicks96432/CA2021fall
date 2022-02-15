`include "./defs.v"

module ALU_Control
(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

    input   [9: 0]             funct_i;
    input   [1: 0]             ALUOp_i;
    output  [3: 0]             ALUCtrl_o;

    reg     [3: 0]             ALUCtrl_o;

    always @ (funct_i, ALUOp_i) begin
        case (ALUOp_i)
            2'b10: begin
                if (funct_i[9: 3] == 7'b0) begin
                    case (funct_i[2: 0])
                        3'b000:  ALUCtrl_o <= `ADD;
                        3'b001:  ALUCtrl_o <= `SLL;
                        3'b111:  ALUCtrl_o <= `AND;
                        3'b100:  ALUCtrl_o <= `XOR;
                    endcase
                end
                else if (funct_i[2: 0] == 3'b0) begin
                    case (funct_i[9: 3])
                        7'b0100000: ALUCtrl_o <= `SUB;
                        7'b0000001: ALUCtrl_o <= `MUL;
                    endcase
                end
            end
            2'b00: begin
                case (funct_i[2: 0])
                    3'b000: ALUCtrl_o <= `ADD;
                    3'b010: ALUCtrl_o <= `ADD;
                    3'b101: begin
                        if (funct_i[9: 3] == 7'b0100000) ALUCtrl_o <= `SRA;
                    end
                endcase
            end
            2'b01: ALUCtrl_o <= `SUB;
        endcase
    end
endmodule
