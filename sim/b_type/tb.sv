module b_type_tb;

    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [12:0] imm;
    logic [31:0] in1, in2;
    logic [31:0] pc;
    logic [31:0] iaddr;
    

    b_type b_type_i(.*);

    initial begin

        $monitor("opcode: 0b%b, funct3: 0x%x, imm: 0x%x, in1: %d, in2: %d, pc: 0x%x, iaddr: 0x%x", opcode, funct3, imm, in1, in2, pc, iaddr);
        opcode = 7'b1100011;

        // beq
        funct3 = 3'h0;
        in1 = 32'h1;
        in2 = 32'h1;
        pc = $urandom();
        #1 assert (iaddr == (pc + {{20{imm[11]}}, imm}));
        in2 = 32'h2;
        #1 assert (iaddr == (pc + 4));

        // bne
        funct3 = 3'h1;
        in1 = 32'h1;
        in2 = 32'h2;
        pc = $urandom();
        #1 assert (iaddr == (pc + {{20{imm[11]}}, imm}));
        in2 = 32'h1;
        #1 assert (iaddr == (pc + 4));


        // blt
        funct3 = 3'h4;
        in1 = 32'h1;
        in2 = 32'h4;
        pc = $urandom();
        #1 assert (iaddr == (pc + {{20{imm[11]}}, imm}));
        in2 = 32'h0;
        #1 assert (iaddr == (pc + 4));

        // bge
        funct3 = 3'h5;
        in1 = 32'h1;
        in2 = 32'h4;
        pc = $urandom();
        #1 assert (iaddr == (pc + {{20{imm[11]}}, imm}));
        in2 = 32'h0;
        #1 assert (iaddr == (pc + 4));


        // Test a opcode that doesn't apply to this module
        opcode = 7'b0000000;
        #1 assert (iaddr == (pc + 4));

        $finish;

    end

endmodule