module IF_ID_Registers
(
    clk_i,
    reset_i,
    Stall_i,
    Flush_i,
    instr_i,
    pc_i,
    MemStall_i,
    instr_o,
    pc_o
);

    parameter width = 32;

    input                      clk_i;
    input                      reset_i;
    input                      Stall_i;
    input                      Flush_i;
    input   [width - 1: 0]     instr_i;
    input   [width - 1: 0]     pc_i;
    input                      MemStall_i;
    output  [width - 1: 0]     instr_o;
    output  [width - 1: 0]     pc_o;

    reg     [width - 1: 0]     instr_o;
    reg     [width - 1: 0]     pc_o;

    always @ (posedge reset_i) begin
        pc_o    <= 32'b0;
        instr_o <= 32'b0;
    end

    always @ (posedge clk_i) begin
        if (Flush_i) begin
            pc_o    <= 32'b0;
            instr_o <= 32'b0;
        end
        else if (~Stall_i && ~MemStall_i) begin
            pc_o    <= pc_i;
            instr_o <= instr_i;
        end
    end

endmodule
