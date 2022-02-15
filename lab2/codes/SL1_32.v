module SL1_32
(
    data_i,
    data_o
);

    parameter width = 32;

    input   [width - 1: 0]     data_i;
    output  [width - 1: 0]     data_o;

    assign data_o = data_i << 1;

endmodule
