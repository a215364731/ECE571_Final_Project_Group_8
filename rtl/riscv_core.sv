module riscv_core(
    input clk, reset_n
);

typedef struct packed {
    logic [6:0] funct7; //MSB
    logic [4:0] rs2;
    logic [4:0] rs1;
    logic [2:0] funct3;
    logic [4:0] rd;
    logic [6:0] opcode; //LSB
} r_instr;

typedef struct packed {
    logic [11:0] imm;
    logic [4:0] rs1;
    logic [2:0] funct3;
    logic [4:0] rd;
    logic [6:0] opcode;
} i_instr; // l type is just i type

typedef struct packed {
    logic [6:0] imm7; //imm[11:5]
    logic [4:0] rs2;
    logic [4:0] rs1;
    logic [2:0] funct3;
    logic [4:0] imm5; //imm[4:0]
    logic [6:0] opcode;
} s_instr;

typedef struct packed {
    logic [6:0] imm7; //imm[12|10:5]
    logic [4:0] rs2;
    logic [4:0] rs1;
    logic [2:0] funct3;
    logic [4:0] imm5; //imm[4:1|11]
    logic [6:0] opcode;
} b_instr;

typedef union packed {
    logic [31:0] flat;
    r_instr r;
    i_instr i;
    s_instr s;
    b_instr b;
} instr;

logic [31:0] pc, pc_next;
logic [31:0] d_wr_addr, d_rd_addr;
logic [31:0] d_wr_data, d_rd_data;
instr instruction;
logic reg_wr_en;
logic [3:0] dmem_wr_en;
logic [4:0] rs1, rs2, rd;
logic [31:0] rs1_data, rs2_data, rd_data;
logic [31:0] i_rd_data, r_rd_data, l_rd_data;

always_ff @(posedge clk) begin
    if(~reset_n) pc <= '0;
    else begin
        pc <= pc_next;
    end
end

always_comb begin
    reg_wr_en = 1'b0;
    rs1 = 5'h0;
    rs2 = 5'h0;
    rd = 5'h0;
    rd_data = 32'h0;
    case(instruction.flat[6:0])
        //r type
        7'b0110011: begin
            reg_wr_en = 1'b1;
            rs1 = instruction.r.rs1;
            rs2 = instruction.r.rs2;
            rd = instruction.r.rd;
            rd_data = r_rd_data;
        end
        //i type
        7'b0010011: begin
            reg_wr_en = 1'b1;
            rs1 = instruction.i.rs1;
            rd = instruction.i.rd;
            rd_data = i_rd_data;
        end
        //s type
        7'b0100011: begin
            reg_wr_en = 1'b0;
            rs1 = instruction.s.rs1;
            rs2 = instruction.s.rs2;
        end
        //l type
        7'b0000011: begin
            reg_wr_en = 1'b1;
            rs1 = instruction.i.rs1;
            rd = instruction.i.rd;
            rd_data = l_rd_data;
        end
        //b type
        7'b1100011: begin
            reg_wr_en = 1'b0;
            rs1 = instruction.b.rs1;
            rs2 = instruction.b.rs2;
        end
    endcase
end

imem imem_i(
    .addr(pc),
    .data(instruction.flat)
);

dmem dmem_i(
    .clk(clk),
    .wr_addr(wr_addr)
);

registers registers_i(
    .clk(clk),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .reg_wr_en(reg_wr_en),
    .rd_data(rd_data),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

r_type r_type_i(
    .opcode(instruction.r.opcode),
    .funct3(instruction.r.funct3),
    .funct7(instruction.r.funct7),
    .in1(rs1_data),
    .in2(rs2_data),
    .out(r_rd_data)
);

i_type i_type_i(
    .opcode(instruction.i.opcode),
    .funct3(instruction.i.funct3),
    .imm(instruction.i.imm),
    .in1(rs1_data),
    .out(i_rd_data)
);

s_type s_type_i(
    .opcode(instruction.s.opcode),
    .imm({instruction.s.imm7,instruction.s.imm5}),
    .in1(rs1_data),
    .in2(rs2_data),
    .d_addr(d_wr_addr),
    .d_data(d_wr_data),
    .wr_en(dmem_wr_en)
);

l_type l_type_i(
    .opcode(instruction.i.opcode),
    .funct3(instruction.i.funct3),
    .imm(instruction.i.imm),
    .in1(rs1_data),
    .d_addr(d_rd_addr),
    .d_data(d_rd_data),
    .out(l_rd_data)
);

b_type b_type_i(
    .opcode(instruction.b.opcode),
    .funct3(instruction.b.funct3),
    .imm({instruction.b.imm7[6],instruction.b.imm5[0],instruction.b.imm7[5:0],instruction.b.imm5[4:1]}),
    .in1(rs1_data),
    .in2(rs2_data),
    .pc(pc),
    .pc_next(pc_next)
);


endmodule