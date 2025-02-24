module l_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [11:0] imm,
    input  logic [31:0] in1, // Data of rs1, holds the address of data memory to be accessed (+ imm)
    output logic [31:0] d_addr,
    input  logic [31:0] d_data,
    output logic [31:0] out // Data for rd
);

endmodule