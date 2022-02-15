module Adder
(
	data1_in,
	data2_in,
	data_o
);

	parameter width = 32;

	input  [width - 1: 0] data1_in;
	input  [width - 1: 0] data2_in;
	output [width - 1: 0] data_o;

	reg    [width - 1: 0] data_o;

	always @(data1_in or data2_in) begin
		data_o <= data1_in + data2_in;
	end
	
endmodule