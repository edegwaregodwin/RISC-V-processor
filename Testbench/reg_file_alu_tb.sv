`timescale 1ps/1ps
`include "microprocessor.sv"

module reg_file_alu_tb;
    logic [3:0] RA1, RA2, WA;
    logic [7:0] ALUResult, cpu_out, immediate;
    logic [1:0] ALUControl;
    logic CLK, Zero, write_enable, ALUSrc;

    reg_file_alu dut (RA1, RA2, WA, immediate, ALUControl, write_enable, ALUSrc, CLK, ALUResult, cpu_out, Zero);

    initial begin 
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    initial begin
        $dumpfile("reg_file_alu_tb.vcd");
        $dumpvars(0, reg_file_alu_tb);
        RA1 = 1; RA2 = 5; WA = 0; immediate = 16; write_enable = 0; ALUSrc = 1; ALUControl = 0;
        #10 RA1 = 0; RA2 = 2; WA = 4; immediate = 16; write_enable = 1; ALUSrc = 1; ALUControl = 2;
        #10 RA1 = 8; RA2 = 4; WA = 12; immediate = 5; write_enable = 1; ALUSrc = 1; ALUControl = 0;
        #15 RA1 = 4; RA2 = 0; WA = 2; immediate = 0; write_enable = 1; ALUSrc = 0; ALUControl = 1;
        #20 RA1 = 2; RA2 = 12; WA = 9; immediate = 20; write_enable = 1; ALUSrc = 1; ALUControl = 0;
        #20 RA1 = 12; RA2 = 2; WA = 0; immediate = 4; write_enable = 0; ALUSrc = 0; ALUControl = 3;
        #20 RA1 = 2; RA2 = 9; WA = 15; immediate = 80; write_enable = 1; ALUSrc = 1; ALUControl = 0;
        #20 RA1 = 1; RA2 = 15; WA = 0; immediate = 0; write_enable = 0; ALUSrc = 0; ALUControl = 1;
        #20 RA1 = 5; RA2 = 16; WA = 0; immediate = 0; write_enable = 0; ALUSrc = 0; ALUControl = 2;
        #15;
        $finish; 
    end

    initial begin 
        $monitor ("t = %3d, CLK = %b, RA1 = %b RA2 = %b, \
        WA = %b, immediate = %b, write_enable = %b, ALUSrc = %b, \
        ALUControl = %b, ALUResult = %b, cpu_out = %b, Zero = %b", $time, CLK, RA1, RA2, WA, immediate, write_enable, ALUSrc, ALUControl, ALUResult, cpu_out, Zero);
    end
endmodule