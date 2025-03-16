module top_tb;

    logic clk, reset_n;

    riscv_core riscv_core_i(.*);

    initial begin
        clk = 0;
        forever # 5 clk = ~clk;
    end

    initial begin
        @(posedge clk) reset_n = 0;
        @(posedge clk) reset_n = 1;

        repeat(32) @(posedge clk);
        // Check register content
        $display("\n\nregister content:");
        for (int i = 0; i < 32; i ++) begin
            $display("x%01d: 0x%x",i,riscv_core_i.registers_i.regfile[i]);
            assert (riscv_core_i.registers_i.regfile[i] == i);
        end 

        repeat(32) @(posedge clk); // Register data being stored into dmem
        // Check register content
        $display("\n\ndmem content:");
        for (int i = 0; i < 128; i += 4) begin
            $display("0x%01d: 0x%x",i,{riscv_core_i.dmem_i.mem[i+3],riscv_core_i.dmem_i.mem[i+2],riscv_core_i.dmem_i.mem[i+1],riscv_core_i.dmem_i.mem[i]});
            assert ({riscv_core_i.dmem_i.mem[i+3],riscv_core_i.dmem_i.mem[i+2],riscv_core_i.dmem_i.mem[i+1],riscv_core_i.dmem_i.mem[i]} == i/4);
        end 
        repeat(7) @(posedge clk);

        // Check register content
        $display("\n\npost arithmatic register content:");
        for (int i = 16; i < 23; i++) begin
            $display("x%01d: 0x%x",i,riscv_core_i.registers_i.regfile[i]);
        end 
        assert (riscv_core_i.registers_i.regfile[16] == 3);
        assert (riscv_core_i.registers_i.regfile[17] == 2);
        assert (riscv_core_i.registers_i.regfile[18] == 0);
        assert (riscv_core_i.registers_i.regfile[19] == 7);
        assert (riscv_core_i.registers_i.regfile[20] == 1);
        assert (riscv_core_i.registers_i.regfile[21] == 4);
        assert (riscv_core_i.registers_i.regfile[22] == 2); 

        repeat(60) @(posedge clk);
        assert (riscv_core_i.registers_i.regfile[1] == 31);

        repeat(32) @(posedge clk);
        // Check register content
        $display("\n\npost load register content:");
        for (int i = 0; i < 32; i ++) begin
            $display("x%01d: 0x%x",i,riscv_core_i.registers_i.regfile[i]);
            assert (riscv_core_i.registers_i.regfile[i] == i);
        end 

        $finish;

    end
endmodule