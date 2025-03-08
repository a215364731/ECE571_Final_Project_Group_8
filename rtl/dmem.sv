// Read and write, read is combinational logic, write will be on a clock cycle depending on the write enable
module dmem(
    input logic clk,
    input logic [31:0] wr_addr,
    input logic [31:0] wr_data,
    input logic [3:0] wr_en,
    input logic [31:0] rd_addr,
    output logic [31:0] rd_data
);

endmodule