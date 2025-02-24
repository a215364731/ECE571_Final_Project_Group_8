module r_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [6:0]  funct7,
    input  logic [31:0] in1, in2, // Data of rs1 and rs2
    output logic [31:0] out // Data for rd
);

endmodule