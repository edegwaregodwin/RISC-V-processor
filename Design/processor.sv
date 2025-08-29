module alu(input logic [7:0] SrcA,
           input logic [7:0] SrcB, 
           input logic [1:0] ALUControl, 
           output logic [7:0] ALUResult, 
           output logic Zero);
    always_comb begin
        case(ALUControl)
            2'b00: ALUResult = SrcA & SrcB;
            2'b01: ALUResult = SrcA | SrcB;
            2'b10: ALUResult = SrcA + SrcB;
            2'b11: ALUResult = SrcA - SrcB;
            default: ALUResult = 8'bx;
        endcase

        if (ALUResult == 0) 
            Zero = 1;
        else 
            Zero = 0;
    end
endmodule

module reg_file(input logic [3:0] RA1, RA2, WA,
                input logic [7:0] ALUResult,
                input logic write_enable, CLK,
                output logic [7:0] RD1, RD2, cpu_out);
    logic [7:0] rf [0:15];
    initial begin
        rf[0] = 8'b0;
    end
    assign RD1 = rf[RA1];
    assign RD2 = rf[RA2];
    assign cpu_out = rf[15];
    always_ff @ (posedge CLK)
        if(write_enable && WA > 4'b0000) 
            rf[WA] <= ALUResult;
endmodule

module reg_file_alu(input logic [3:0] RA1, RA2, WA,
                    input logic [7:0] immediate,
                    input logic [1:0] ALUControl,
                    input logic write_enable, ALUSrc, CLK,
                    output logic [7:0] ALUResult, cpu_out,
                    output logic Zero);
    logic [7:0] RD1, RD2, SrcB;
    reg_file rf_inst(RA1, RA2, WA, ALUResult, write_enable, CLK, RD1, RD2, cpu_out);
    assign SrcB = (ALUSrc) ? immediate : RD2;
    alu alu_inst(RD1, SrcB, ALUControl, ALUResult, Zero);
endmodule

module instruction_memory(input logic [7:0] PC,
                          output logic [23:0] Instr);
    logic [23:0] data_rom [0:255];
    initial
        $readmemh("program.txt", data_rom);
    assign Instr = data_rom[PC];   
endmodule

module pc(input logic [7:0] immediate, 
          input logic PCSrc, CLK, reset,
          output logic [7:0] PC);
    always_ff @ (posedge CLK) begin
        if (reset) PC <= 8'b0;
        else PC <= (PCSrc) ? immediate : PC + 1;
    end
endmodule

module instruction_memory_pc(input logic [7:0] immediate,
                             input logic PCSrc, CLK, reset,
                             output logic [23:0] Instr);
    logic [7:0] PC;
    pc pc_inst(immediate, PCSrc, CLK, reset, PC);
    instruction_memory instr_inst(PC, Instr);
endmodule

module control_unit(input logic [3:0] opcode,
                    output logic [1:0] ALUControl,
                    output logic Branch, ALUSrc, RegWrite);
    always_comb begin
        case (opcode)
            4'b0000: {RegWrite, ALUSrc, ALUControl, Branch} = 5'b10000;
            4'b0001: {RegWrite, ALUSrc, ALUControl, Branch} = 5'b10010;
            4'b0010: {RegWrite, ALUSrc, ALUControl, Branch} = 5'b10100;
            4'b0011: {RegWrite, ALUSrc, ALUControl, Branch} = 5'b10110;
            4'b0100: {RegWrite, ALUSrc, ALUControl, Branch} = 5'b11000;
            4'b0101: {RegWrite, ALUSrc, ALUControl, Branch} = 5'b11010;
            4'b0110: {RegWrite, ALUSrc, ALUControl, Branch} = 5'b11100;
            4'b0111: {RegWrite, ALUSrc, ALUControl, Branch} = 5'b00111;
        endcase
    end
endmodule

module cpu(input CLK, reset,
           output [7:0] ALUResult, cpu_out);
    logic [23:0] Instr;
    logic [1:0] ALUControl;
    logic PCSrc, Branch, ALUSrc, RegWrite, Zero;

    instruction_memory_pc instr_inst2(Instr[7:0], PCSrc, CLK, reset, Instr);
    control_unit control_inst2(Instr[23:20], ALUControl, Branch, ALUSrc, RegWrite);
    reg_file_alu rf_inst2(Instr[15:12], Instr[11:8], Instr[19:16], Instr[7:0], ALUControl, RegWrite, ALUSrc, CLK, ALUResult, cpu_out, Zero);
    and(PCSrc, Branch, Zero);
endmodule
