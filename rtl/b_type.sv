module b_type(
    input  logic [6:0]  opcode,      // opcode of the instruction
    input  logic [2:0]  funct3,      // funct3 field of the instruction
    input  logic [12:0] imm,         // 13-bit immediate for branch offset
    input  logic [31:0] in1, in2,    // Data from registers rs1 and rs2
    input  logic [31:0] pc,          // Current PC (Program Counter)
    output logic [31:0] iaddr       // next instruction address: branch or pc+4
);

    // Decode the branch condition based on funct3
    logic branch_taken;
    always_comb begin
        case (funct3 && opcode ==  7'b1100011 )
            3'b000: branch_taken = (in1 == in2);        // BEQ: Branch if equal
            3'b001: branch_taken = (in1 != in2);        // BNE: Branch if not equal
            3'b100: branch_taken = (in1 < in2);         // BLT: Branch if less than (signed)
            3'b101: branch_taken = (in1 >= in2);        // BGE: Branch if greater or equal (signed)
            3'b110: branch_taken = ($unsigned(in1) < $unsigned(in2)); // BLTU: Branch if less than (unsigned)
            3'b111: branch_taken = ($unsigned(in1) >= $unsigned(in2)); // BGEU: Branch if greater or equal (unsigned)
            default: branch_taken = 1'b0;               // Default: Do not branch
        endcase
    end

    // Calculate the branch target address
    logic [31:0] branch_target;
    always_comb begin
     if(opcode ==  7'b1100011 ) begin
        // The imm field represents a 12-bit signed immediate
        // We need to sign-extend it and shift it left by 1 (because it's a byte offset)
        branch_target = pc + 32'(signed'(imm)); // imm is 12-bit, so we shift it left by 1 bit
     end
    end

    // Output the next instruction address
    always_comb begin
    if(opcode ==  7'b1100011 ) begin
        if (branch_taken) begin
            iaddr = branch_target; // Branch taken: use the calculated branch target
        end else begin
            iaddr = pc + 4;         // Branch not taken: use PC + 4 (next sequential instruction)
        end
    end
    end

endmodule

