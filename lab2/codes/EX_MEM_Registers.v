module EX_MEM_Registers
(
    clk_i,
    reset_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i,
    ALU_Result_i,
    RS2data_i,
    instr_11_7_i,
    MemStall_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALU_Result_o,
    RS2data_o,
    instr_11_7_o
);

    parameter width = 32;

    input                      clk_i;
    input                      reset_i;
    input                      RegWrite_i;
    input                      MemtoReg_i;
    input                      MemRead_i;
    input                      MemWrite_i;
    input   [width - 1: 0]     ALU_Result_i;
    input   [width - 1: 0]     RS2data_i;
    input   [4: 0]             instr_11_7_i;
    input                      MemStall_i;

    output                     RegWrite_o;
    output                     MemtoReg_o;
    output                     MemRead_o;
    output                     MemWrite_o;
    output  [width - 1: 0]     ALU_Result_o;
    output  [width - 1: 0]     RS2data_o;
    output  [4: 0]             instr_11_7_o;

    reg                        RegWrite_o;
    reg                        MemtoReg_o;
    reg                        MemRead_o;
    reg                        MemWrite_o;
    reg     [width - 1: 0]     ALU_Result_o;
    reg     [width - 1: 0]     RS2data_o;
    reg     [4: 0]             instr_11_7_o;

    always @ (posedge reset_i) begin
        RegWrite_o   <= 1'b0;
        MemtoReg_o   <= 1'b0;
        MemRead_o    <= 1'b0;
        MemWrite_o   <= 1'b0;
        ALU_Result_o <= 32'b0;
        RS2data_o    <= 32'b0;
        instr_11_7_o <= 5'b0;
    end

    always @ (posedge clk_i) begin
        if (~MemStall_i) begin
            RegWrite_o   <= RegWrite_i;
            MemtoReg_o   <= MemtoReg_i;
            MemRead_o    <= MemRead_i;
            MemWrite_o   <= MemWrite_i;
            ALU_Result_o <= ALU_Result_i;
            RS2data_o    <= RS2data_i;
            instr_11_7_o <= instr_11_7_i;
        end
    end

endmodule
