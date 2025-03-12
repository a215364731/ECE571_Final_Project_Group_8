// Read ONLY, no rd enable needed. Read will be combinational
module imem(
    input logic [31:0] addr,    // 32-bit input address
    output logic [31:0] data    // 32-bit output instruction data 
);

    // Instruction memory array (32 locations, each 32-bit wide)
    logic [31:0] i_arr [0:31];

    // Initialize memory from an external file
    initial begin
        $readmemh("imem1_ini.mem", i_arr);
    end

    // Read instruction from memory (word-aligned address)
    assign data = i_arr[addr[31:2]];

endmodule

