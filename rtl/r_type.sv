module r_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [6:0]  funct7,
    input  logic [31:0] in1, in2, // Data of rs1 and rs2
    output logic [31:0] out // Data for rd
);

always_comb begin
        if (opcode == 7'b0110011) begin  // R-type opcode
            case ({funct7, funct3})
                10'b0000000000: out = in1 + in2;  // ADD
                10'b0100000000: out = in1 - in2;  // SUB
                10'b0000000001: out = in1 << in2[4:0];  // SLL (Logical Shift Left)
                10'b0000000010: out = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0;  // SLT (Set Less Than)
                10'b0000000011: out = (in1 < in2) ? 32'b1 : 32'b0;  // SLTU (Unsigned)
                10'b0000000100: out = in1 ^ in2;  // XOR
                10'b0000000101: out = in1 >> in2[4:0];  // SRL (Logical Shift Right)
                10'b0100000101: out = $signed(in1) >>> in2[4:0];  // SRA (Arithmetic Shift Right)
                10'b0000000110: out = in1 | in2;  // OR
                10'b0000000111: out = in1 & in2;  // AND
                default: out = 32'b0;  // Default case (NOP)
            endcase
        end else begin
            out = 32'b0;  // Invalid opcode
        end
    end

endmodule
