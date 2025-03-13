module dmem_tb;

    logic clk;
    logic [31:0] wr_addr;
    logic [31:0] wr_data;
    logic [3:0] wr_en;
    logic [31:0] rd_addr;
    logic [31:0] rd_data;

    dmem dmem_i(.*);

    initial begin
        clk = 0;
        forever # 5 clk = ~clk;
    end

    task initialize_mem;
        for(int i = 0; i < 16384; i++) begin
            @(posedge clk);
            wr_addr = i*4;
            wr_data = i*4;
            wr_en = 4'b1111;
        end
        @(posedge clk);
        wr_en = 0;
    endtask

    int data_addr;
    initial begin
        $monitor("rd_addr: 0x%x, rd_data: 0x%x", rd_addr, rd_data);
        // Deposit data that matches the address
        initialize_mem();
        @(posedge clk);
        
        
        for(int i = 0; i < 100; i++) begin
            data_addr = $urandom_range(16383) * 4;
            rd_addr = data_addr;
            @(posedge clk);
            assert (rd_data == data_addr);
        end

        $finish;

    end

endmodule