module MUX32_4
(
    data1_i,
    data2_i,
    data3_i,
    data4_i,
    select_i,
    data_o
);

    parameter width = 32;

    input   [width - 1: 0]     data1_i;
    input   [width - 1: 0]     data2_i;
    input   [width - 1: 0]     data3_i;
    input   [width - 1: 0]     data4_i;
    input   [1: 0]             select_i;
    output  [width - 1: 0]     data_o;

    wire    [width - 1: 0]     wire_A;
    wire    [width - 1: 0]     wire_B;

    MUX32_2 MUX_A(
        .data1_i               (data1_i),
        .data2_i               (data2_i),
        .select_i              (select_i[0]),
        .data_o                (wire_A)
    );

    MUX32_2 MUX_B(
        .data1_i               (data3_i),
        .data2_i               (data4_i),
        .select_i              (select_i[0]),
        .data_o                (wire_B)
    );

    MUX32_2 MUX_C(
        .data1_i               (wire_A),
        .data2_i               (wire_B),
        .select_i              (select_i[1]),
        .data_o                (data_o)
    );

endmodule
