module Add32_2
(
    data1_i,
    data2_i,
    data_o
);

    parameter width = 32;

    input   [width - 1: 0]     data1_i;
    input   [width - 1: 0]     data2_i;
    output  [width - 1: 0]     data_o;

	assign data_o = data1_i + data2_i;

endmodule
