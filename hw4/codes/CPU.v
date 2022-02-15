module CPU
(
    clk_i, 
    rst_i,
    start_i
);

    // Ports
    input clk_i;
    input rst_i;
    input start_i;

    parameter width = 32;

    wire [width - 1: 0] PC_Instruction_Memory;
    wire [width - 1: 0] Instruction_Memory_Register;
    wire [width - 1: 0] Sign_Extend_MUX32;
    wire [width - 1: 0] Register_ALU;
    wire [width - 1: 0] Register_MUX32;
    wire [width - 1: 0] MUX32_ALU;
    wire [width - 1: 0] ALU_Register;
    wire [1: 0]         ALUOp;
    wire [2: 0]         ALUCtrl;
    wire                ALUSrc;
    wire                RegWrite;
    wire [width - 1: 0] Add_PC_PC;
    wire                Zero;
    wire [width - 1: 0] four;

    assign four = 32'd4;

    Control Control(
        .Op_i       (Instruction_Memory_Register[6:0]),
        .ALUOp_o    (ALUOp),
        .ALUSrc_o   (ALUSrc),
        .RegWrite_o (RegWrite)
    );



    Adder Add_PC(
        .data1_in   (PC_Instruction_Memory),
        .data2_in   (four),
        .data_o     (Add_PC_PC)
    );


    PC PC(
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .start_i    (start_i),
        .pc_i       (Add_PC_PC),
        .pc_o       (PC_Instruction_Memory)
    );

    Instruction_Memory Instruction_Memory(
        .addr_i     (PC_Instruction_Memory), 
        .instr_o    (Instruction_Memory_Register)
    );

    Registers Registers(
        .clk_i      (clk_i),
        .RS1addr_i  (Instruction_Memory_Register[19:15]),
        .RS2addr_i  (Instruction_Memory_Register[24:20]),
        .RDaddr_i   (Instruction_Memory_Register[11:7]), 
        .RDdata_i   (ALU_Register),
        .RegWrite_i (RegWrite), 
        .RS1data_o  (Register_ALU), 
        .RS2data_o  (Register_MUX32) 
    );


    MUX32 MUX_ALUSrc(
        .data1_i    (Register_MUX32),
        .data2_i    (Sign_Extend_MUX32),
        .select_i   (ALUSrc),
        .data_o     (MUX32_ALU)
    );



    Sign_Extend Sign_Extend(
        .data_i     (Instruction_Memory_Register[31:20]),
        .data_o     (Sign_Extend_MUX32)
    );

    

    ALU ALU(
        .data1_i    (Register_ALU),
        .data2_i    (MUX32_ALU),
        .ALUCtrl_i  (ALUCtrl),
        .data_o     (ALU_Register),
        .Zero_o     (Zero)
    );



    ALU_Control ALU_Control(
        .funct_i    ({Instruction_Memory_Register[31:25], Instruction_Memory_Register[14:12]}),
        .ALUOp_i    (ALUOp),
        .ALUCtrl_o  (ALUCtrl)
    );

endmodule
