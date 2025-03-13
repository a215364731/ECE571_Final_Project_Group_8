module b_type(
    input  logic [6:0]  opcode,
    input  logic [2:0]  funct3, 
    input  logic [12:0] imm,
    input  logic [31:0] in1, in2,
    input  logic [31:0] pc,
    output logic [31:0] iaddr
);

    logic branch_taken;
    always_comb begin
        case (funct3 && opcode ==  7'b1100011 )
            3'b000: branch_taken = (in1 == in2);
            3'b001: branch_taken = (in1 != in2);
            3'b100: branch_taken = (in1 < in2);
            3'b101: branch_taken = (in1 >= in2);
            3'b110: branch_taken = ($unsigned(in1) < $unsigned(in2));
            3'b111: branch_taken = ($unsigned(in1) >= $unsigned(in2));
            default: branch_taken = 1'b0;
        endcase
    end

    logic [31:0] branch_target;
    always_comb begin
     if(opcode ==  7'b1100011 ) begin
        branch_target = pc + 32'(signed'(imm)); 
     end
    end

    always_comb begin
    if(opcode ==  7'b1100011 ) begin
        if (branch_taken) begin
            iaddr = branch_target;
        end else begin
            iaddr = pc + 4;
        end
    end
    end

endmodule

