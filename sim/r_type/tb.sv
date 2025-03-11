module r_type_tb;

    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [6:0] funct7;
    logic [31:0] in1, in2;
    logic [31:0] out;

    r_type r_type_i(.*);

    initial begin

        $monitor("opcode: 0b%b, funct3: 0x%x, funct7: 0x%x, in1: %d, in2: %d, out: %d", opcode, funct3, funct7, in1, in2, out);
        opcode = 7'b0110011;

        // add
        funct3 = 3'h0;
        funct7 = 7'h00;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (out == (in1 + in2));

        // sub
        funct3 = 3'h0;
        funct7 = 7'h20;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (out == (in1 - in2));

        // xor
        funct3 = 3'h4;
        funct7 = 7'h00;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (out == (in1 ^ in2));

        // or
        funct3 = 3'h6;
        funct7 = 7'h00;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (out == (in1 | in2));

        // and
        funct3 = 3'h7;
        funct7 = 7'h00;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (out == (in1 & in2));

        // sll
        funct3 = 3'h1;
        funct7 = 7'h00;
        in1 = $urandom();
        in2 = $urandom_range(2**5-1);
        #1 assert (out == (in1 << in2));

        // srl
        funct3 = 3'h5;
        funct7 = 7'h00;
        in1 = $urandom();
        in2 = $urandom_range(2**5 - 1);
        #1 assert (out == (in1 >> in2));

        // sra
        funct3 = 3'h5;
        funct7 = 7'h20;
        in1 = $urandom();
        in2 = $urandom_range(2**5 - 1);
        #1 assert (out == (in1 >>> in2));

        // slt
        funct3 = 3'h2;
        funct7 = 3'h00;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (out == (($signed(in1) < $signed(in2))?1:0));

        // sltu
        funct3 = 3'h3;
        funct7 = 3'h00;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (out == ((in1 < in2)?1:0));

        // Test a opcode that doesn't apply to this module
        opcode = 7'b0000000;
        #1 assert ($isunknown(out));

        $finish;

    end

endmodule