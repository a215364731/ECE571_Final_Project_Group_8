// Read and write, read is combinational logic, write will be on a clock cycle depending on the write enable
module registers(
    input logic clk,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic reg_wr_en,
    input logic [31:0] rd_data,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);
logic [31:0] regfile [31:0];

    // Initialize registers (useful for simulation, may not synthesize in hardware)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            regfile[i] = 0;
    end

    // Combinational read: outputs are assigned directly from register array
    assign rs1_data = regfile[rs1];
    assign rs2_data = regfile[rs2];

    // Sequential write: happens on clock rising edge if write enable is high
    always_ff @(posedge clk) begin
        if (reg_wr_en && rd != 0) // Prevent writing to register x0
            regfile[rd] <= rd_data;
    end

endmodule
