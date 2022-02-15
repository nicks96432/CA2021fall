module MEM_WB_Registers
(
    clk_i,
    reset_i,
    RegWrite_i,
    MemtoReg_i,
    ALU_Result_i,
    Read_Data_i,
    instr_11_7_i,
    MemStall_i,
    RegWrite_o,
    MemtoReg_o,
    ALU_Result_o,
    Read_Data_o,
    instr_11_7_o
);

    parameter width = 32;

    input                      clk_i;
    input                      reset_i;
    input                      RegWrite_i;
    input                      MemtoReg_i;
    input   [width - 1: 0]     ALU_Result_i;
    input   [width - 1: 0]     Read_Data_i;
    input   [4: 0]             instr_11_7_i;
    input                      MemStall_i;

    output                     RegWrite_o;
    output                     MemtoReg_o;
    output  [width - 1: 0]     ALU_Result_o;
    output  [width - 1: 0]     Read_Data_o;
    output  [4: 0]             instr_11_7_o;

    reg                        RegWrite_o;
    reg                        MemtoReg_o;
    reg     [width - 1: 0]     ALU_Result_o;
    reg     [width - 1: 0]     Read_Data_o;
    reg     [4: 0]             instr_11_7_o;

    always @ (posedge reset_i) begin
        RegWrite_o   <= 1'b0;
        MemtoReg_o   <= 1'b0;
        ALU_Result_o <= 32'b0;
        Read_Data_o  <= 32'b0;
        instr_11_7_o <= 5'b0;
    end

    always @ (posedge clk_i) begin
        if (~MemStall_i) begin
            RegWrite_o   <= RegWrite_i;
            MemtoReg_o   <= MemtoReg_i;
            ALU_Result_o <= ALU_Result_i;
            Read_Data_o  <= Read_Data_i;
            instr_11_7_o <= instr_11_7_i;
        end
    end

endmodule
