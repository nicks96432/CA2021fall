module Hazard_Detection (
    instr_19_15_i,
    instr_24_20_i,
    ID_EX_Registers_MemRead_i,
    ID_EX_Registers_instr_11_7_i,
    PCWrite_o,
    Stall_o,
    NoOp_o
);

    input  [4: 0]         instr_19_15_i;
    input  [4: 0]         instr_24_20_i;
    input                 ID_EX_Registers_MemRead_i;
    input  [4: 0]         ID_EX_Registers_instr_11_7_i;

    output                PCWrite_o;
    output                Stall_o;
    output                NoOp_o;

    reg                   PCWrite_o;
    reg                   Stall_o;
    reg                   NoOp_o;

    always @ (ID_EX_Registers_MemRead_i, ID_EX_Registers_instr_11_7_i,
              instr_19_15_i, instr_24_20_i) begin
        if (ID_EX_Registers_MemRead_i &&
                (ID_EX_Registers_instr_11_7_i == instr_19_15_i ||
                ID_EX_Registers_instr_11_7_i == instr_24_20_i)) begin
            PCWrite_o <= 1'b0;
            Stall_o   <= 1'b1;
            NoOp_o    <= 1'b1;
        end
        else begin
            PCWrite_o <= 1'b1;
            Stall_o   <= 1'b0;
            NoOp_o    <= 1'b0;
        end
    end

endmodule