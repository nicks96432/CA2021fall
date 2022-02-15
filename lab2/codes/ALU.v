`include "./defs.v"

module ALU
(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o
);

    parameter width = 32;

    input signed   [width - 1: 0]     data1_i;
    input signed   [width - 1: 0]     data2_i;
    input          [3: 0]             ALUCtrl_i;
    output         [width - 1: 0]     data_o;

    reg signed     [width - 1: 0]     data_o;

    always @ (data1_i, data2_i, ALUCtrl_i) begin
        case (ALUCtrl_i)
               `ADD: data_o <= data1_i  +  data2_i;
               `SUB: data_o <= data1_i  -  data2_i;
               `MUL: data_o <= data1_i  *  data2_i;
               `AND: data_o <= data1_i  &  data2_i;
               `XOR: data_o <= data1_i  ^  data2_i;
               `SLL: data_o <= data1_i  << data2_i;
               `SRA: data_o <= data1_i >>> (data2_i & 32'h1f);
        endcase
    end

endmodule
