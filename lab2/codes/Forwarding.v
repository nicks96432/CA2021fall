module Forwarding (
    ID_EX_RS1_i,
    ID_EX_RS2_i,
    EX_MEM_Rd_i,
    EX_MEM_RegWrite_i,
    MEM_WB_Rd_i,
    MEM_WB_RegWrite_i,
    Forward_A_o,
    Forward_B_o,
);

    input   [4: 0]             ID_EX_RS1_i;
    input   [4: 0]             ID_EX_RS2_i;
    input   [4: 0]             EX_MEM_Rd_i;
    input                      EX_MEM_RegWrite_i;
    input   [4: 0]             MEM_WB_Rd_i;
    input                      MEM_WB_RegWrite_i;
    output  [1: 0]             Forward_A_o;
    output  [1: 0]             Forward_B_o;

    reg     [1: 0]             Forward_A_o;
    reg     [1: 0]             Forward_B_o;

    always @ (*) begin
        if (EX_MEM_RegWrite_i && EX_MEM_Rd_i != 5'b0 && EX_MEM_Rd_i == ID_EX_RS1_i) begin
            Forward_A_o <= 2'b10;
        end
        else if (MEM_WB_RegWrite_i && MEM_WB_Rd_i != 5'b0 && MEM_WB_Rd_i == ID_EX_RS1_i) begin
            Forward_A_o <= 2'b01;
        end
        else begin
            Forward_A_o <= 2'b00;
        end

        if (EX_MEM_RegWrite_i && EX_MEM_Rd_i != 5'b0 && EX_MEM_Rd_i == ID_EX_RS2_i) begin
            Forward_B_o <= 2'b10;
        end
        else if (MEM_WB_RegWrite_i && MEM_WB_Rd_i != 5'b0 && MEM_WB_Rd_i == ID_EX_RS2_i) begin
            Forward_B_o <= 2'b01;
        end
        else begin
            Forward_B_o <= 2'b00;
        end
    end

endmodule