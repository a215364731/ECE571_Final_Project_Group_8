// Read ONLY, no rd enable needed. Read will be combinational
module imem(
    input logic [31:0] addr,    // 32-bit input address
    output logic [31:0] data    // 32-bit output instruction data 
);

    // Instruction memory array (1024 locations, each 32-bit wide)
    logic [31:0] i_arr [0:1023];

    // Initialize memory from an external file
    initial begin
        $readmemh("imem_ini.mem", i_arr);
    end

    // Read instruction from memory (word-aligned address)
    assign data = i_arr[{addr[31:2],2'h0}];

endmodule

