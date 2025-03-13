`timescale 1ns / 1ps

// Module for I-Type immediate instructions
module i_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [11:0] imm,
    input  logic [31:0] in1, // Data of rs1
    output logic [31:0] out // Data for rd
);
    
    always_comb begin
        case(funct3 && opcode ==  7'b0010011)
            3'b000: out = in1 + {{20{imm[11]}}, imm};  // ADDI (sign-extended immediate)
            3'b010: out = ($signed(in1) < $signed({{20{imm[11]}}, imm})) ? 32'b1 : 32'b0; // SLTI
            3'b011: out = (in1 < {{20'b0}, imm}) ? 32'b1 : 32'b0; // SLTIU (zero-extended immediate)
            3'b100: out = in1 ^ {{20{imm[11]}}, imm}; // XORI
            3'b110: out = in1 | {{20{imm[11]}}, imm}; // ORI
            3'b111: out = in1 & {{20{imm[11]}}, imm}; // ANDI
            3'b001: out = in1 << imm[4:0]; // SLLI (Logical shift left)
            3'b101:
                if (imm[11]) // Checking MSB of immediate for SRAI
                    out = $signed(in1) >>> imm[4:0]; // SRAI (Arithmetic shift right)
                else
                    out = in1 >> imm[4:0]; // SRLI (Logical shift right)
            default: out = 32'b0; // Default case to prevent latches
        endcase
    end
endmodule

