module b_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [11:0] imm,
    input  logic [31:0] in1, in2, // Data of rs1 and rs2
    input  logic [31:0] pc,
    output logic [31:0] iaddr // next instruction addr: either branch imm or pc + 4
);

endmodule