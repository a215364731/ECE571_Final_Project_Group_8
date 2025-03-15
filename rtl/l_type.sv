module l_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3,
    input  logic [11:0] imm,
    input  logic [31:0] in1, 
    output logic [31:0] d_addr,
    input  logic [31:0] d_data,
    output logic [31:0] out
);
always_comb begin
        if (opcode == 7'b0000011) begin
            d_addr = in1 + {{20{imm[11]}}, imm};

            case (funct3)
                3'b000: out = {24'h0, d_data[7:0]};
                3'b001: out = {16'h0, d_data[15:0]};
                3'b010: out = d_data; 
                3'b100: begin
                    d_addr = in1 + imm;
                    out = {24'b0, d_data[7:0]}; 
                end
                3'b101: begin
                    d_addr = in1 + imm;
                    out = {16'b0, d_data[15:0]};
                end
                default: out = 32'bx;
            endcase
        end else begin
            d_addr = 32'b0;
            out = 32'bx;
        end
    end
endmodule
