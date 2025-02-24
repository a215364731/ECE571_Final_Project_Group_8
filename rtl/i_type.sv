module i_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [11:0] imm,
    input  logic [31:0] in1, // Data of rs1
    output logic [31:0] out // Data for rd
);

endmodule