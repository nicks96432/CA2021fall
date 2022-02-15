#! /bin/sh

echo "diff ALU.v"
diff ./codes/ALU.v ../b08902001_lab1/codes/ALU.v

echo "diff ALU_Control.v"
diff ./codes/ALU_Control.v ../b08902001_lab1/codes/ALU_Control.v

echo "diff Control.v"
diff ./codes/Control.v ../b08902001_lab1/codes/Control.v

echo "diff CPU.v"
diff ./codes/CPU.v ../b08902001_lab1/codes/CPU.v

echo "diff Data_Memory.v"
diff ./codes/Data_Memory.v ../b08902001_lab1/codes/Data_Memory.v

echo "diff defs.v"
diff ./codes/defs.v ../b08902001_lab1/codes/defs.v

echo "diff Forwarding.v"
diff ./codes/Forwarding.v ../b08902001_lab1/codes/Forwarding.v

echo "diff Hazard_Detection.v"
diff ./codes/Hazard_Detection.v ../b08902001_lab1/codes/Hazard_Detection.v

echo "diff Imm_Gen.v"
diff ./codes/Imm_Gen.v ../b08902001_lab1/codes/Imm_Gen.v

echo "diff Instruction_Memory.v"
diff ./codes/Instruction_Memory.v ../b08902001_lab1/codes/Instruction_Memory.v

echo "diff PC.v"
diff ./codes/PC.v ../b08902001_lab1/codes/PC.v

echo "diff EX_MEM_Registers.v"
diff ./codes/pipeline_registers/EX_MEM_Registers.v ../b08902001_lab1/codes/pipeline_registers/EX_MEM_Registers.v

echo "diff ID_EX_Registers.v"
diff ./codes/pipeline_registers/ID_EX_Registers.v ../b08902001_lab1/codes/pipeline_registers/ID_EX_Registers.v

echo "diff IF_ID_Registers.v"
diff ./codes/pipeline_registers/IF_ID_Registers.v ../b08902001_lab1/codes/pipeline_registers/IF_ID_Registers.v

echo "diff MEM_WB_Registers.v"
diff ./codes/pipeline_registers/MEM_WB_Registers.v ../b08902001_lab1/codes/pipeline_registers/MEM_WB_Registers.v

echo "diff Registers.v"
diff ./codes/Registers.v ../b08902001_lab1/codes/Registers.v

echo "diff testbench.v"
diff ./codes/testbench.v ../b08902001_lab1/codes/testbench.v

echo "diff Add32_2.v"
diff ./codes/utils/Add32_2.v ../b08902001_lab1/codes/utils/Add32_2.v

echo "diff Equal32_2.v"
diff ./codes/utils/Equal32_2.v ../b08902001_lab1/codes/utils/Equal32_2.v

echo "diff MUX32_2.v"
diff ./codes/utils/MUX32_2.v ../b08902001_lab1/codes/utils/MUX32_2.v

echo "diff MUX32_4.v"
diff ./codes/utils/MUX32_4.v ../b08902001_lab1/codes/utils/MUX32_4.v

echo "diff SL1_32.v"
diff ./codes/utils/SL1_32.v ../b08902001_lab1/codes/utils/SL1_32.v
