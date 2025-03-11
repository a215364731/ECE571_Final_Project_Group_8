module i_type_tb;

    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [11:0] imm;
    logic [31:0] in1;
    logic [31:0] out;

    i_type i_type_i(.*);

    initial begin

        $monitor("opcode: 0b%b, funct3: 0x%x, imm: %d, in1: %d, out: %d", opcode, funct3, imm, in1, out);
        opcode = 7'b0010011;

        // addi
        funct3 = 3'h0;
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == (imm + in1));

        // xori
        funct3 = 3'h4;
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == (imm ^ in1));

        // ori
        funct3 = 3'h6;
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == (imm | in1));

        // andi
        funct3 = 3'h7;
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == (imm & in1));

        // slli
        funct3 = 3'h1;
        imm[11:5] = '0;
        imm[4:0] = $urandom_range(2**5 - 1);
        in1 = $urandom();
        #1 assert (out == (in1 << imm[4:0]));

        // srli
        funct3 = 3'h5;
        imm[11:5] = '0;
        imm[4:0] = $urandom_range(2**5 - 1);
        in1 = $urandom();
        #1 assert (out == (in1 >> imm[4:0]));

        // srai
        funct3 = 3'h5;
        imm[11:5] = 7'h20;
        imm[4:0] = $urandom_range(2**5 - 1);
        in1 = $urandom();
        #1 assert (out == (in1 >>> imm[4:0]));

        // slti
        funct3 = 3'h2;
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == (($signed(in1) < $signed(imm))?1:0));

        // sltiu
        funct3 = 3'h3;
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == ((in1 < imm)?1:0));

        // Test a opcode that doesn't apply to this module
        opcode = 7'b0000000;
        #1 assert ($isunknown(out));

        $finish;

    end

endmodule