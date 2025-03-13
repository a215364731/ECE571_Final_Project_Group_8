module imem_tb;

    logic [31:0] addr;
    logic [31:0] data;

    imem imem_i(.*);

    logic [31:0] mem [0:1023];

    int test_addr;

    initial begin
        $monitor("addr: 0x%x, data: 0x%x", addr, data);

        $readmemh("imem_ini.mem", mem);
        for(int i = 0; i < 100; i++) begin
            test_addr = $urandom_range(255) * 4;
            addr = test_addr;
            #1;
            assert (data == mem[addr]);
        end
        

        $finish;
    end

endmodule