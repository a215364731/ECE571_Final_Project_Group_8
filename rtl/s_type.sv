module s_type(
    input  logic [6:0]  opcode,
    input  logic [11:0] imm,
    input  logic [2:0] funct3,
    input  logic [31:0] in1, in2, 
    output logic [31:0] d_addr, 
    output logic [31:0] d_data, 
    output logic [3:0]  wr_en 
);

    assign d_addr = in1 + {{20{imm[11]}}, imm}; 

    always_comb begin
        d_data = in2;  
        wr_en = 4'b0000; 

        case (opcode && opcode ==  7'b0100011)
            7'b0100011: begin 
                case (funct3[2:0]) 
                    2'b00: wr_en = 4'b0001; 
                    2'b01: wr_en = 4'b0011; 
                    2'b10: wr_en = 4'b1111; 
                    default: wr_en = 4'b0000; 
                endcase
            end
            default: wr_en = 4'b0000; 
        endcase
    end

endmodule

