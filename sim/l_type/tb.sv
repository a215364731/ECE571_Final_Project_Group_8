module l_type_tb;

    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [11:0] imm;
    logic [31:0] in1;
    logic [31:0] d_addr;
    logic [31:0] d_data;
    logic [31:0] out;

    l_type l_type_i(.*);

    initial begin

        $monitor("opcode: 0b%b, funct3: 0x%x, imm: %d, in1: %d, d_addr: 0x%x, d_data: 0x%x, out: %d", opcode, funct3, imm, in1, d_addr, d_data, out);
        opcode = 7'b0000011;

        // lb
        funct3 = 3'h0;
        d_data = $urandom();
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == {24'h0,d_data[7:0]});
        assert (d_addr == (in1 + {{20{imm[11]}}, imm}));

        // lh
        funct3 = 3'h1;
        d_data = $urandom();
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == {16'h0,d_data[15:0]});
        assert (d_addr == (in1 + {{20{imm[11]}}, imm}));

        // lb
        funct3 = 3'h2;
        d_data = $urandom();
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == d_data);
        assert (d_addr == (in1 + {{20{imm[11]}}, imm}));

        // lbu
        funct3 = 3'h4;
        d_data = $urandom();
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == {24'h0,d_data[7:0]});
        assert (d_addr == (in1 + imm));

        // lhu
        funct3 = 3'h5;
        d_data = $urandom();
        imm = $urandom_range(2**12 - 1);
        in1 = $urandom();
        #1 assert (out == {16'h0,d_data[15:0]});
        assert (d_addr == (in1 + imm));

        // Test a opcode that doesn't apply to this module
        opcode = 7'b0000000;
        #1 assert ($isunknown(out));

        $finish;

    end

endmodule