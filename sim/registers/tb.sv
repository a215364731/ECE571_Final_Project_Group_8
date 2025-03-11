module registers_tb;


    logic clk;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;
    logic reg_wr_en;
    logic [31:0] rd_data;
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;

    registers registers_i(.*);

    initial begin
        clk = 0;
        forever # 5 clk = ~clk;
    end

    task initialize_mem;
        for(int i = 0; i < 32; i++) begin
            @(posedge clk);
            rd = i;
            rd_data = i;
            reg_wr_en = 1;
        end
        @(posedge clk);
        reg_wr_en = 0;
    endtask

    int data_addr;
    initial begin
        $monitor("rs1: 0x%x, rs2: 0x%x, rs1_data: 0x%x, rs2_data: 0x%x", rs1, rs2, rs1_data, rs2_data);
        // Deposit data that matches the address
        initialize_mem();
        @(posedge clk);
        
        
        for(int i = 0; i < 16; i++) begin
            @(posedge clk);
            data_addr = $urandom_range(31);
            rs1 = data_addr;
            assert (rs1_data == data_addr);
        end

        for(int i = 0; i < 16; i++) begin
            @(posedge clk);
            data_addr = $urandom_range(31);
            rs2 = data_addr;
            assert (rs2_data == data_addr);
        end

        $finish;

    end

endmodule