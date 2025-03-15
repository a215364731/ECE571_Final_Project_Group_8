
module imem(
    input logic [31:0] addr,    // 32-bit input address
    output logic [31:0] data    // 32-bit output instruction data 
);
    logic [31:0] i_arr [0:1023];

    initial begin
        $readmemh("imem_ini.mem", i_arr);
    end

    assign data = i_arr[{addr[31:2]}];

endmodule

