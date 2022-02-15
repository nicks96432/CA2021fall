`include "./defs.v"

module Imm_Gen
(
    data_i,
    data_o
);

    parameter width = 32;

    input   [width - 1: 0]     data_i;
    output  [width - 1: 0]     data_o;

    reg     [width - 1: 0]     data_o;

    always @ (data_i) begin
        case (data_i[6: 0])
            `I_TYPE: begin
                case (data_i[14: 12])
                    3'b000: data_o <= {{20{data_i[31]}}, data_i[31: 20]};
                    3'b101: data_o <= {{27{data_i[24]}}, data_i[24: 20]};
                endcase
            end
            `LOAD:   data_o <= {{20{data_i[31]}}, data_i[31: 20]};
            `STORE:  data_o <= {{20{data_i[31]}}, data_i[31: 25], data_i[11: 7]};
            `BRANCH: data_o <= {{20{data_i[31]}}, data_i[31], data_i[7],
                                data_i[30: 25], data_i[11: 8]};
            default: data_o <= 32'b0;
        endcase
    end

endmodule
