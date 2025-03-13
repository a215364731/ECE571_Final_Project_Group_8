module dmem(
    input logic clk,
    input logic [31:0] wr_addr,
    input logic [31:0] wr_data,
    input logic [3:0] wr_en,
    input logic [31:0] rd_addr,
    output logic [31:0] rd_data
);
logic [7:0] mem [0:65535];

    always_comb begin
        rd_data = {mem[rd_addr[31:2] * 4 + 3],  // MSB Byte
                   mem[rd_addr[31:2] * 4 + 2],  
                   mem[rd_addr[31:2] * 4 + 1],  
                   mem[rd_addr[31:2] * 4]};     // LSB Byte
    end

    always_ff @(posedge clk) begin
        if (wr_en[0]) mem[wr_addr[31:2] * 4]     <= wr_data[7:0];    // Byte 0
        if (wr_en[1]) mem[wr_addr[31:2] * 4 + 1] <= wr_data[15:8];   // Byte 1
        if (wr_en[2]) mem[wr_addr[31:2] * 4 + 2] <= wr_data[23:16];  // Byte 2
        if (wr_en[3]) mem[wr_addr[31:2] * 4 + 3] <= wr_data[31:24];  // Byte 3
    end

endmodule
