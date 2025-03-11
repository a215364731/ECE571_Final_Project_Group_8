module l_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [11:0] imm,
    input  logic [31:0] in1, // Data of rs1, holds the address of data memory to be accessed (+ imm)
    output logic [31:0] d_addr,
    input  logic [31:0] d_data,
    output logic [31:0] out // Data for rd
);
always_comb begin
        if (opcode == 7'b0000011) begin  // L-type opcode
            d_addr = in1 + {{20{imm[11]}}, imm};  // Sign-extended immediate added to rs1

            case (funct3)
                3'b000: out = {{24{d_data[7]}}, d_data[7:0]};   // LB (Load Byte, sign-extended)
                3'b001: out = {{16{d_data[15]}}, d_data[15:0]}; // LH (Load Halfword, sign-extended)
                3'b010: out = d_data;                           // LW (Load Word)
                3'b100: out = {24'b0, d_data[7:0]};             // LBU (Load Byte, zero-extended)
                3'b101: out = {16'b0, d_data[15:0]};            // LHU (Load Halfword, zero-extended)
                default: out = 32'b0;                           // Invalid instruction case
            endcase
        end else begin
            d_addr = 32'b0;
            out = 32'b0;  // Default case for invalid opcode
        end
    end
endmodule
