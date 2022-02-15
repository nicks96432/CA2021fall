module ALU
(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o,
    Zero_o
);

    parameter width = 32;

    input  [width - 1: 0]  data1_i;
    input  [width - 1: 0]  data2_i;
    input  [2:0]           ALUCtrl_i;
    output [width - 1: 0]  data_o;
    output                 Zero_o;

    reg    [width - 1: 0]  data_o;

    assign Zero_o = 0;

    always @(data1_i or data2_i or ALUCtrl_i) begin
        case (ALUCtrl_i)
               `ADD: data_o = data1_i  +  data2_i;
               `SUB: data_o = data1_i  -  data2_i;
               `MUL: data_o = data1_i  *  data2_i;
               `AND: data_o = data1_i  &  data2_i;
               `XOR: data_o = data1_i  ^  data2_i;
               `SLL: data_o = data1_i  << data2_i;
               `SRA: data_o = data1_i >>> (data2_i & 32'b11111);
        endcase
    end
endmodule