/* module s_type(
    input  logic [6:0]  opcode,
    input  logic [11:0] imm,
    input  logic [31:0] in1, in2, // Data of rs1 and rs2
    output logic [31:0] d_addr, // address where data should be stored in dmem
    output logic [31:0] d_data, // data going to dmem
    output logic [3:0]  wr_en // Write enable signal to dmem, each bit enables 1 byte of dmem
);

endmodule */

module s_type(
    input  logic [6:0]  opcode,
    input  logic [11:0] imm,
    input  logic [2:0] funct3,
    input  logic [31:0] in1, in2, // Data of rs1 and rs2
    output logic [31:0] d_addr, // Address where data should be stored in dmem
    output logic [31:0] d_data, // Data going to dmem
    output logic [3:0]  wr_en // Write enable signal to dmem, each bit enables 1 byte
);

    // Compute store address (rs1 + sign-extended immediate)
    assign d_addr = in1 + {{20{imm[11]}}, imm}; 

    // Default values
    always_comb begin
        d_data = in2;  // Data to be stored in memory
        wr_en = 4'b0000; // Default write enable signal

        case (opcode)
            7'b0100011: begin // Store operations
                case (funct3[2:0]) // Determining based on least significant bits of funct3
                    2'b00: wr_en = 4'b0001; // SB (Store Byte)
                    2'b01: wr_en = 4'b0011; // SH (Store Halfword)
                    2'b10: wr_en = 4'b1111; // SW (Store Word)
                    default: wr_en = 4'b0000; // Default case to prevent unintended writes
                endcase
            end
            default: wr_en = 4'b0000; // No write enable for non-store instructions
        endcase
    end

endmodule

