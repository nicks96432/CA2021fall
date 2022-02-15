module MUX32
(
    data1_i,
    data2_i,
    select_i,
    data_o
);

    parameter width = 32;

    input  [width - 1: 0] data1_i;
    input  [width - 1: 0] data2_i;
    input  	              select_i;
    output [width - 1: 0] data_o;

    reg    [width - 1: 0] data_o;

    always @(data1_i or data2_i or select_i) begin
        data_o = select_i ? data2_i : data1_i; 
    end

endmodule