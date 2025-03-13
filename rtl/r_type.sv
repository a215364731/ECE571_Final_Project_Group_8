module r_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [6:0]  funct7,
    input  logic [31:0] in1, in2, 
    output logic [31:0] out
);

always_comb begin
        if (opcode == 7'b0110011) begin 
            case ({funct7, funct3})
                10'b0000000000: out = in1 + in2; 
                10'b0100000000: out = in1 - in2;  
                10'b0000000001: out = in1 << in2[4:0];
                10'b0000000010: out = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;
                10'b0000000011: out = (in1 < in2) ? 32'b1 : 32'b0;
                10'b0000000100: out = in1 ^ in2;
                10'b0000000101: out = in1 >> in2[4:0];
                10'b0100000101: out = $signed(in1) >>> in2[4:0];
                10'b0000000110: out = in1 | in2;
                10'b0000000111: out = in1 & in2;
                default: out = 32'bx;
            endcase
        end else begin
            out = 32'bx;
        end
    end

endmodule
