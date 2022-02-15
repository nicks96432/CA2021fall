`include "./defs.v"

module Control
(
    Op_i,
    NoOp_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUOp_o,
    ALUSrc_o,
    Branch_o
);

    input   [6: 0]             Op_i;
    input                      NoOp_i;
    output                     RegWrite_o;
    output                     MemtoReg_o;
    output                     MemRead_o;
    output                     MemWrite_o;
    output  [1: 0]             ALUOp_o;
    output                     ALUSrc_o;
    output                     Branch_o;

    reg                        RegWrite_o;
    reg                        MemtoReg_o;
    reg                        MemRead_o;
    reg                        MemWrite_o;
    reg     [1: 0]             ALUOp_o;
    reg                        ALUSrc_o;
    reg                        Branch_o;

    always @ (Op_i, NoOp_i) begin
        if (NoOp_i || Op_i == 7'b0) begin
                RegWrite_o <= 1'b0;
                MemtoReg_o <= 1'b0;
                ALUOp_o    <= 2'b00;
                ALUSrc_o   <= 1'b0;
                MemRead_o  <= 1'b0;
                MemWrite_o <= 1'b0;
                Branch_o   <= 1'b0;
        end
        else begin
            case (Op_i)
                `R_TYPE: begin
                    RegWrite_o <= 1'b1;
                    MemtoReg_o <= 1'b0;
                    ALUOp_o    <= 2'b10;
                    ALUSrc_o   <= 1'b0;
                    MemRead_o  <= 1'b0;
                    MemWrite_o <= 1'b0;
                    Branch_o   <= 1'b0;
                end
                `I_TYPE: begin
                    RegWrite_o <= 1'b1;
                    MemtoReg_o <= 1'b0;
                    ALUOp_o    <= 2'b00;
                    ALUSrc_o   <= 1'b1;
                    MemRead_o  <= 1'b0;
                    MemWrite_o <= 1'b0;
                    Branch_o   <= 1'b0;
                end
                `LOAD: begin
                    RegWrite_o <= 1'b1;
                    MemtoReg_o <= 1'b1;
                    ALUOp_o    <= 2'b00;
                    ALUSrc_o   <= 1'b1;
                    MemRead_o  <= 1'b1;
                    MemWrite_o <= 1'b0;
                    Branch_o   <= 1'b0;
                end
                `STORE: begin
                    RegWrite_o <= 1'b0;
                    MemtoReg_o <= 1'bX;
                    ALUOp_o    <= 2'b00;
                    ALUSrc_o   <= 1'b1;
                    MemRead_o  <= 1'b0;
                    MemWrite_o <= 1'b1;
                    Branch_o   <= 1'b0;
                end
                `BRANCH: begin
                    RegWrite_o <= 1'b0;
                    MemtoReg_o <= 1'bX;
                    ALUOp_o    <= 2'b01;
                    ALUSrc_o   <= 1'b0;
                    MemRead_o  <= 1'b0;
                    MemWrite_o <= 1'b0;
                    Branch_o   <= 1'b1;
                end
            endcase
        end
    end

endmodule