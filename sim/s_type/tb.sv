module s_type_tb;

    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [11:0] imm;
    logic [31:0] in1, in2;
    logic [31:0] d_addr;
    logic [31:0] d_data;
    logic [3:0]  wr_en;

    s_type s_type_i(.*);

    initial begin

        $monitor("opcode: 0b%b, funct3: 0x%x, imm: 0x%x, in1: %d, in2: %d, d_addr: 0x%x, d_data: 0x%x, wr_en: 0b%b", opcode, funct3, imm, in1, in2, d_addr, d_data, wr_en);
        opcode = 7'b0100011;

        // sb
        funct3 = 3'h0;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (d_addr == (in1 + {{20{imm[11]}}, imm}));
        assert (d_data == in2);
        assert (wr_en == 4'b0001);

        // sh
        funct3 = 3'h1;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (d_addr == (in1 + {{20{imm[11]}}, imm}));
        assert (d_data == in2);
        assert (wr_en == 4'b0011);

        // sw
        funct3 = 3'h2;
        in1 = $urandom();
        in2 = $urandom();
        #1 assert (d_addr == (in1 + {{20{imm[11]}}, imm}));
        assert (d_data == in2);
        assert (wr_en == 4'b1111);


        // Test a opcode that doesn't apply to this module
        opcode = 7'b0000000;
        #1 assert (wr_en == 4'h0);

        $finish;

    end

endmodule