module Equal32_2
(
    data1_i,
    data2_i,
    data_o,
);

    parameter width = 32;

    input   [width - 1: 0]     data1_i;
    input   [width - 1: 0]     data2_i;
    output                     data_o;

    assign data_o = (data1_i == data2_i) ? 1'b1 : 1'b0;

endmodule
