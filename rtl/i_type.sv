`timescale 1ns / 1ps

module i_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [11:0] imm,
    input  logic [31:0] in1,
    output logic [31:0] out
);
    
    always_comb begin
        case(funct3 && opcode ==  7'b0010011)
            3'b000: out = in1 + {{20{imm[11]}}, imm};  
            3'b010: out = ($signed(in1) < $signed({{20{imm[11]}}, imm})) ? 32'b1 : 32'b0;
            3'b011: out = (in1 < {{20'b0}, imm}) ? 32'b1 : 32'b0;
            3'b100: out = in1 ^ {{20{imm[11]}}, imm};
            3'b110: out = in1 | {{20{imm[11]}}, imm};
            3'b111: out = in1 & {{20{imm[11]}}, imm};
            3'b001: out = in1 << imm[4:0];
            3'b101:
                if (imm[11])
                    out = $signed(in1) >>> imm[4:0];
                else
                    out = in1 >> imm[4:0];
            default: out = 32'b0;
        endcase
    end
endmodule

