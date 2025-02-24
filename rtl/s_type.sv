module s_type(
    input  logic [6:0]  opcode,
    input  logic [11:0] imm,
    input  logic [31:0] in1, in2, // Data of rs1 and rs2
    output logic [3:0]  wr_en // Write enable signal to dmem, each bit enables 1 byte of dmem
);

endmodule