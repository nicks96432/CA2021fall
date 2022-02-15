module CPU
(
    clk_i,
    rst_i,
    start_i
);

    parameter width = 32;

    input                      clk_i;
    input                      rst_i;
    input                      start_i;

    wire    [width - 1: 0]     PC_Instruction_Memory;
    wire    [width - 1: 0]     Add_PC_Four_MUX_PCSrc;
    wire    [width - 1: 0]     MUX_PCSrc_PC;
    wire    [width - 1: 0]     four;

    wire    [width - 1: 0]     Instruction_Memory_IF_ID_Registers;
    wire    [width - 1: 0]     IF_ID_Registers_Registers;
    wire    [width - 1: 0]     IF_ID_Registers_Add_PC_Branch_PC;
    wire    [width - 1: 0]     SL1_Branch_Add_PC_Branch;
    wire    [width - 1: 0]     Add_PC_Branch_MUX_PCSrc;


    wire                       Hazard_Detection_Control_NoOp;
    wire                       Hazard_Detection_IF_ID_Registers_Stall;
    wire                       Hazard_Detection_PC_PCWrite;
    wire                       Control_ID_EX_Registers_RegWrite;
    wire                       Control_ID_EX_Registers_MemtoReg;
    wire                       Control_ID_EX_Registers_MemRead;
    wire                       Control_ID_EX_Registers_MemWrite;
    wire    [1: 0]             Control_ID_EX_Registers_ALUOp;
    wire                       Control_ID_EX_Registers_ALUSrc;
    wire                       Control_Branch_AND_Equal_Branch;
    wire                       Equal_RS1addr_RS2addr_Branch_AND_Equal;
    wire                       Branch_AND_Equal_IF_ID_Registers_Flush;
    wire    [width - 1: 0]     Registers_ID_EX_Registers_RS1data;
    wire    [width - 1: 0]     Registers_ID_EX_Registers_RS2data;
    wire    [width - 1: 0]     Imm_Gen_ID_EX_Registers;

    wire                       ID_EX_Registers_EX_MEM_Registers_RegWrite;
    wire                       ID_EX_Registers_EX_MEM_Registers_MemtoReg;
    wire                       ID_EX_Registers_EX_MEM_Registers_MemRead;
    wire                       ID_EX_Registers_EX_MEM_Registers_MemWrite;
    wire    [1: 0]             ID_EX_Registers_ALU_Control_ALUOp;
    wire                       ID_EX_Registers_MUX_ALUSrc_ALUSrc;
    wire    [width - 1: 0]     ID_EX_Registers_MUX_Forward_A_RS1data;
    wire    [width - 1: 0]     ID_EX_Registers_MUX_Forward_B_RS2data;
    wire    [width - 1: 0]     ID_EX_Registers_MUX_ALUSrc_Imm_Gen;
    wire    [9: 0]             ID_EX_Registers_ALU_Control_instr_31_25_14_12;
    wire    [4: 0]             ID_EX_Registers_EX_MEM_Registers_instr_11_7;
    wire    [4: 0]             ID_EX_Registers_Forwarding_instr_19_15;
    wire    [4: 0]             ID_EX_Registers_Forwarding_instr_24_20;

    wire    [width - 1: 0]     MUX_Forward_A_ALU;
    wire    [width - 1: 0]     MUX_Forward_B_MUX_ALUSrc;
    wire    [width - 1: 0]     MUX_ALUSrc_ALU;
    wire    [3: 0]             ALU_Control_ALU_ALUCtrl;
    wire    [1: 0]             Forwarding_MUX_Forward_A_select;
    wire    [1: 0]             Forwarding_MUX_Forward_B_select;

    wire    [width - 1: 0]     ALU_EX_MEM_Registers_ALU_Result;
    wire                       EX_MEM_Registers_MEM_WB_Registers_RegWrite;
    wire                       EX_MEM_Registers_MEM_WB_Registers_MemtoReg;
    wire                       EX_MEM_Registers_Data_Memory_MemRead;
    wire                       EX_MEM_Registers_Data_Memory_MemRrite;
    wire    [width - 1: 0]     EX_MEM_Registers_Data_Memory_ALU_Result;
    wire    [width - 1: 0]     EX_MEM_Registers_Data_Memory_RS2data;
    wire    [4: 0]             EX_MEM_Registers_MEM_WB_Registers_instr_11_7;
    wire    [width - 1: 0]     Data_Memory_MEM_WB_Registers_Read_Data;

    wire                       MEM_WB_Registers_Registers_RegWrite;
    wire                       MEM_WB_Registers_MUX_RegSrc_MemtoReg;
    wire    [width - 1: 0]     MEM_WB_Registers_MUX_RegSrc_ALU_Result;
    wire    [width - 1: 0]     MEM_WB_Registers_MUX_RegSrc_Read_Data;
    wire    [4: 0]             MEM_WB_Registers_Registers_instr_11_7;
    wire    [width - 1: 0]     MUX_RegSrc_Registers;

    wire                       Flush;

    assign four = 32'd4;
    assign Flush = Branch_AND_Equal_IF_ID_Registers_Flush;

    Add32_2 Add_PC_Four(
        .data1_i                      (PC_Instruction_Memory),
        .data2_i                      (four),
        .data_o                       (Add_PC_Four_MUX_PCSrc)
    );

    MUX32_2 MUX_PCSrc(
        .data1_i                      (Add_PC_Four_MUX_PCSrc),
        .data2_i                      (Add_PC_Branch_MUX_PCSrc),
        .select_i                     (Branch_AND_Equal_IF_ID_Registers_Flush),
        .data_o                       (MUX_PCSrc_PC)
    );

    PC PC(
        .clk_i                        (clk_i),
        .rst_i                        (rst_i),
        .start_i                      (start_i),
        .PCWrite_i                    (Hazard_Detection_PC_PCWrite),
        .pc_i                         (MUX_PCSrc_PC),
        .pc_o                         (PC_Instruction_Memory)
    );

    Instruction_Memory Instruction_Memory(
        .addr_i                       (PC_Instruction_Memory),
        .instr_o                      (Instruction_Memory_IF_ID_Registers)
    );

    IF_ID_Registers IF_ID_Registers(
        .clk_i                        (clk_i),
        .reset_i                      (rst_i),
        .Flush_i                      (Branch_AND_Equal_IF_ID_Registers_Flush),
        .Stall_i                      (Hazard_Detection_IF_ID_Registers_Stall),
        .instr_i                      (Instruction_Memory_IF_ID_Registers),
        .pc_i                         (PC_Instruction_Memory),
        .instr_o                      (IF_ID_Registers_Registers),
        .pc_o                         (IF_ID_Registers_Add_PC_Branch_PC)
    );

    SL1_32 SL1_Branch(
        .data_i                       (Imm_Gen_ID_EX_Registers),
        .data_o                       (SL1_Branch_Add_PC_Branch)
    );

    Add32_2 Add_PC_Branch(
        .data1_i                      (SL1_Branch_Add_PC_Branch),
        .data2_i                      (IF_ID_Registers_Add_PC_Branch_PC),
        .data_o                       (Add_PC_Branch_MUX_PCSrc)
    );

    Hazard_Detection Hazard_Detection(
        .instr_19_15_i                (IF_ID_Registers_Registers[19: 15]),
        .instr_24_20_i                (IF_ID_Registers_Registers[24: 20]),
        .ID_EX_Registers_MemRead_i    (ID_EX_Registers_EX_MEM_Registers_MemRead),
        .ID_EX_Registers_instr_11_7_i (ID_EX_Registers_EX_MEM_Registers_instr_11_7),
        .PCWrite_o                    (Hazard_Detection_PC_PCWrite),
        .Stall_o                      (Hazard_Detection_IF_ID_Registers_Stall),
        .NoOp_o                       (Hazard_Detection_Control_NoOp)
    );

    Control Control(
        .Op_i                         (IF_ID_Registers_Registers[6: 0]),
        .NoOp_i                       (Hazard_Detection_Control_NoOp),
        .RegWrite_o                   (Control_ID_EX_Registers_RegWrite),
        .MemtoReg_o                   (Control_ID_EX_Registers_MemtoReg),
        .MemRead_o                    (Control_ID_EX_Registers_MemRead),
        .MemWrite_o                   (Control_ID_EX_Registers_MemWrite),
        .ALUOp_o                      (Control_ID_EX_Registers_ALUOp),
        .ALUSrc_o                     (Control_ID_EX_Registers_ALUSrc),
        .Branch_o                     (Control_Branch_AND_Equal_Branch)
    );

    assign Branch_AND_Equal_IF_ID_Registers_Flush = 
        Control_Branch_AND_Equal_Branch & 
        Equal_RS1addr_RS2addr_Branch_AND_Equal;

    Registers Registers(
        .clk_i                        (clk_i),
        .RS1addr_i                    (IF_ID_Registers_Registers[19: 15]),
        .RS2addr_i                    (IF_ID_Registers_Registers[24: 20]),
        .RDaddr_i                     (MEM_WB_Registers_Registers_instr_11_7),
        .RDdata_i                     (MUX_RegSrc_Registers),
        .RegWrite_i                   (MEM_WB_Registers_Registers_RegWrite),
        .RS1data_o                    (Registers_ID_EX_Registers_RS1data),
        .RS2data_o                    (Registers_ID_EX_Registers_RS2data)
    );

    Equal32_2 Equal_RS1addr_RS2addr(
        .data1_i                      (Registers_ID_EX_Registers_RS1data),
        .data2_i                      (Registers_ID_EX_Registers_RS2data),
        .data_o                       (Equal_RS1addr_RS2addr_Branch_AND_Equal)
    );

    Imm_Gen Imm_Gen(
        .data_i                       (IF_ID_Registers_Registers),
        .data_o                       (Imm_Gen_ID_EX_Registers)
    );

    ID_EX_Registers ID_EX_Registers(
        .clk_i                        (clk_i),
        .reset_i                      (rst_i),
        .RegWrite_i                   (Control_ID_EX_Registers_RegWrite),
        .MemtoReg_i                   (Control_ID_EX_Registers_MemtoReg),
        .MemRead_i                    (Control_ID_EX_Registers_MemRead),
        .MemWrite_i                   (Control_ID_EX_Registers_MemWrite),
        .ALUOp_i                      (Control_ID_EX_Registers_ALUOp),
        .ALUSrc_i                     (Control_ID_EX_Registers_ALUSrc),
        .RS1data_i                    (Registers_ID_EX_Registers_RS1data),
        .RS2data_i                    (Registers_ID_EX_Registers_RS2data),
        .Imm_Gen_i                    (Imm_Gen_ID_EX_Registers),
        .instr_31_25_14_12_i          ({IF_ID_Registers_Registers[31: 25],
                                       IF_ID_Registers_Registers[14: 12]}),
        .instr_19_15_i                (IF_ID_Registers_Registers[19: 15]),
        .instr_24_20_i                (IF_ID_Registers_Registers[24: 20]),
        .instr_11_7_i                 (IF_ID_Registers_Registers[11: 7]),
        .RegWrite_o                   (ID_EX_Registers_EX_MEM_Registers_RegWrite),
        .MemtoReg_o                   (ID_EX_Registers_EX_MEM_Registers_MemtoReg),
        .MemRead_o                    (ID_EX_Registers_EX_MEM_Registers_MemRead),
        .MemWrite_o                   (ID_EX_Registers_EX_MEM_Registers_MemWrite),
        .ALUOp_o                      (ID_EX_Registers_ALU_Control_ALUOp),
        .ALUSrc_o                     (ID_EX_Registers_MUX_ALUSrc_ALUSrc),
        .RS1data_o                    (ID_EX_Registers_MUX_Forward_A_RS1data),
        .RS2data_o                    (ID_EX_Registers_MUX_Forward_B_RS2data),
        .Imm_Gen_o                    (ID_EX_Registers_MUX_ALUSrc_Imm_Gen),
        .instr_31_25_14_12_o          (ID_EX_Registers_ALU_Control_instr_31_25_14_12),
        .instr_19_15_o                (ID_EX_Registers_Forwarding_instr_19_15),
        .instr_24_20_o                (ID_EX_Registers_Forwarding_instr_24_20),
        .instr_11_7_o                 (ID_EX_Registers_EX_MEM_Registers_instr_11_7)
    );

    MUX32_4 MUX_Forward_A(
        .data1_i                      (ID_EX_Registers_MUX_Forward_A_RS1data),
        .data2_i                      (MUX_RegSrc_Registers),
        .data3_i                      (EX_MEM_Registers_Data_Memory_ALU_Result),
        .data4_i                      (),
        .select_i                     (Forwarding_MUX_Forward_A_select),
        .data_o                       (MUX_Forward_A_ALU)
    );

    MUX32_4 MUX_Forward_B(
        .data1_i                      (ID_EX_Registers_MUX_Forward_B_RS2data),
        .data2_i                      (MUX_RegSrc_Registers),
        .data3_i                      (EX_MEM_Registers_Data_Memory_ALU_Result),
        .data4_i                      (),
        .select_i                     (Forwarding_MUX_Forward_B_select),
        .data_o                       (MUX_Forward_B_MUX_ALUSrc)
    );

    MUX32_2 MUX_ALUSrc(
        .data1_i                      (MUX_Forward_B_MUX_ALUSrc),
        .data2_i                      (ID_EX_Registers_MUX_ALUSrc_Imm_Gen),
        .select_i                     (ID_EX_Registers_MUX_ALUSrc_ALUSrc),
        .data_o                       (MUX_ALUSrc_ALU)
    );

    ALU ALU(
        .data1_i                      (MUX_Forward_A_ALU),
        .data2_i                      (MUX_ALUSrc_ALU),
        .ALUCtrl_i                    (ALU_Control_ALU_ALUCtrl),
        .data_o                       (ALU_EX_MEM_Registers_ALU_Result)
    );

    ALU_Control ALU_Control(
        .funct_i                      (ID_EX_Registers_ALU_Control_instr_31_25_14_12),
        .ALUOp_i                      (ID_EX_Registers_ALU_Control_ALUOp),
        .ALUCtrl_o                    (ALU_Control_ALU_ALUCtrl)
    );

    Forwarding Forwarding(
        .ID_EX_RS1_i                  (ID_EX_Registers_Forwarding_instr_19_15),
        .ID_EX_RS2_i                  (ID_EX_Registers_Forwarding_instr_24_20),
        .EX_MEM_Rd_i                  (EX_MEM_Registers_MEM_WB_Registers_instr_11_7),
        .EX_MEM_RegWrite_i            (EX_MEM_Registers_MEM_WB_Registers_RegWrite),
        .MEM_WB_Rd_i                  (MEM_WB_Registers_Registers_instr_11_7),
        .MEM_WB_RegWrite_i            (MEM_WB_Registers_Registers_RegWrite),
        .Forward_A_o                  (Forwarding_MUX_Forward_A_select),
        .Forward_B_o                  (Forwarding_MUX_Forward_B_select)

    );

    EX_MEM_Registers EX_MEM_Registers(
        .clk_i                        (clk_i),
        .reset_i                      (rst_i),
        .RegWrite_i                   (ID_EX_Registers_EX_MEM_Registers_RegWrite),
        .MemtoReg_i                   (ID_EX_Registers_EX_MEM_Registers_MemtoReg),
        .MemRead_i                    (ID_EX_Registers_EX_MEM_Registers_MemRead),
        .MemWrite_i                   (ID_EX_Registers_EX_MEM_Registers_MemWrite),
        .ALU_Result_i                 (ALU_EX_MEM_Registers_ALU_Result),
        .RS2data_i                    (MUX_Forward_B_MUX_ALUSrc),
        .instr_11_7_i                 (ID_EX_Registers_EX_MEM_Registers_instr_11_7),
        .RegWrite_o                   (EX_MEM_Registers_MEM_WB_Registers_RegWrite),
        .MemtoReg_o                   (EX_MEM_Registers_MEM_WB_Registers_MemtoReg),
        .MemRead_o                    (EX_MEM_Registers_Data_Memory_MemRead),
        .MemWrite_o                   (EX_MEM_Registers_Data_Memory_MemRrite),
        .ALU_Result_o                 (EX_MEM_Registers_Data_Memory_ALU_Result),
        .RS2data_o                    (EX_MEM_Registers_Data_Memory_RS2data),
        .instr_11_7_o                 (EX_MEM_Registers_MEM_WB_Registers_instr_11_7)
    );

    Data_Memory Data_Memory(
        .clk_i                        (clk_i),
        .addr_i                       (EX_MEM_Registers_Data_Memory_ALU_Result),
        .MemRead_i                    (EX_MEM_Registers_Data_Memory_MemRead),
        .MemWrite_i                   (EX_MEM_Registers_Data_Memory_MemRrite),
        .data_i                       (EX_MEM_Registers_Data_Memory_RS2data),
        .data_o                       (Data_Memory_MEM_WB_Registers_Read_Data)
    );

    MEM_WB_Registers MEM_WB_Registers(
        .clk_i                        (clk_i),
        .reset_i                      (rst_i),
        .RegWrite_i                   (EX_MEM_Registers_MEM_WB_Registers_RegWrite),
        .MemtoReg_i                   (EX_MEM_Registers_MEM_WB_Registers_MemtoReg),
        .ALU_Result_i                 (EX_MEM_Registers_Data_Memory_ALU_Result),
        .Read_Data_i                  (Data_Memory_MEM_WB_Registers_Read_Data),
        .instr_11_7_i                 (EX_MEM_Registers_MEM_WB_Registers_instr_11_7),
        .RegWrite_o                   (MEM_WB_Registers_Registers_RegWrite),
        .MemtoReg_o                   (MEM_WB_Registers_MUX_RegSrc_MemtoReg),
        .ALU_Result_o                 (MEM_WB_Registers_MUX_RegSrc_ALU_Result),
        .Read_Data_o                  (MEM_WB_Registers_MUX_RegSrc_Read_Data),
        .instr_11_7_o                 (MEM_WB_Registers_Registers_instr_11_7)
    );

    MUX32_2 MUX_RegData(
        .data1_i                      (MEM_WB_Registers_MUX_RegSrc_ALU_Result),
        .data2_i                      (MEM_WB_Registers_MUX_RegSrc_Read_Data),
        .select_i                     (MEM_WB_Registers_MUX_RegSrc_MemtoReg),
        .data_o                       (MUX_RegSrc_Registers)
    );

endmodule
