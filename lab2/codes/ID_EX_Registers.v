module ID_EX_Registers
(
    clk_i,
    reset_i,
    RegWrite_i,
    MemtoReg_i,
    MemRead_i,
    MemWrite_i,
    ALUOp_i,
    ALUSrc_i,
    RS1data_i,
    RS2data_i,
    Imm_Gen_i,
    instr_31_25_14_12_i,
    instr_19_15_i,
    instr_24_20_i,
    instr_11_7_i,
    MemStall_i,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    ALUOp_o,
    ALUSrc_o,
    RS1data_o,
    RS2data_o,
    Imm_Gen_o,
    instr_31_25_14_12_o,
    instr_19_15_o,
    instr_24_20_o,
    instr_11_7_o
);
    parameter width = 32;

    input                      clk_i;
    input                      reset_i;
    input                      RegWrite_i;
    input                      MemtoReg_i;
    input                      MemRead_i;
    input                      MemWrite_i;
    input   [1: 0]             ALUOp_i;
    input                      ALUSrc_i;
    input   [width - 1: 0]     RS1data_i;
    input   [width - 1: 0]     RS2data_i;
    input   [width - 1: 0]     Imm_Gen_i;
    input   [9: 0]             instr_31_25_14_12_i;
    input   [4: 0]             instr_19_15_i;
    input   [4: 0]             instr_24_20_i;
    input   [4: 0]             instr_11_7_i;
    input                      MemStall_i;
    
    output                     RegWrite_o;
    output                     MemtoReg_o;
    output                     MemRead_o;
    output                     MemWrite_o;
    output  [1: 0]             ALUOp_o;
    output                     ALUSrc_o;
    output  [width - 1: 0]     RS1data_o;
    output  [width - 1: 0]     RS2data_o;
    output  [width - 1: 0]     Imm_Gen_o;
    output  [9: 0]             instr_31_25_14_12_o;
    output  [4: 0]             instr_19_15_o;
    output  [4: 0]             instr_24_20_o;
    output  [4: 0]             instr_11_7_o;

    reg                        RegWrite_o;
    reg                        MemtoReg_o;
    reg                        MemRead_o;
    reg                        MemWrite_o;
    reg     [1: 0]             ALUOp_o;
    reg                        ALUSrc_o;
    reg     [width - 1: 0]     RS1data_o;
    reg     [width - 1: 0]     RS2data_o;
    reg     [width - 1: 0]     Imm_Gen_o;
    reg     [9: 0]             instr_31_25_14_12_o;
    reg     [4: 0]             instr_19_15_o;
    reg     [4: 0]             instr_24_20_o;
    reg     [4: 0]             instr_11_7_o;

    always @ (posedge reset_i) begin
        RegWrite_o          <= 1'b0;
        MemtoReg_o          <= 1'b0;
        MemRead_o           <= 1'b0;
        MemWrite_o          <= 1'b0;
        ALUOp_o             <= 2'b0;
        ALUSrc_o            <= 1'b0;
        RS1data_o           <= 32'b0;
        RS2data_o           <= 32'b0;
        Imm_Gen_o           <= 32'b0;
        instr_31_25_14_12_o <= 10'b0;
        instr_19_15_o       <= 5'b0;
        instr_24_20_o       <= 5'b0;
        instr_11_7_o        <= 5'b0;
    end

    always @ (posedge clk_i) begin
        if (~MemStall_i) begin
            RegWrite_o          <= RegWrite_i;
            MemtoReg_o          <= MemtoReg_i;
            MemRead_o           <= MemRead_i;
            MemWrite_o          <= MemWrite_i;
            ALUOp_o             <= ALUOp_i;
            ALUSrc_o            <= ALUSrc_i;
            RS1data_o           <= RS1data_i;
            RS2data_o           <= RS2data_i;
            Imm_Gen_o           <= Imm_Gen_i;
            instr_31_25_14_12_o <= instr_31_25_14_12_i;
            instr_19_15_o       <= instr_19_15_i;
            instr_24_20_o       <= instr_24_20_i;
            instr_11_7_o        <= instr_11_7_i;
        end
    end

endmodule
