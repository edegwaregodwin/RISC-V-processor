`timescale 1ps/1ps
`include "microprocessor.sv"

module reg_file_tb;
    logic [3:0] RA1, RA2, WA;
    logic [7:0] ALUResult, cpu_out, RD1, RD2;
    logic CLK, write_enable;

    reg_file dut (RA1, RA2, WA, ALUResult, write_enable, CLK, RD1, RD2, cpu_out);

    initial begin 
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    initial begin
        $dumpfile("reg_file_tb.vcd");
        $dumpvars(0, reg_file_tb);
        RA1 = 1; RA2 = 2; WA = 0; ALUResult = 5; write_enable = 0;
        #10 RA1 = 6; RA2 = 4; WA = 5; ALUResult = 20; write_enable = 0;
        #10 RA1 = 10; RA2 = 3; WA = 0; ALUResult = 32; write_enable = 1;
        #15 RA1 = 7; RA2 = 7; WA = 0; ALUResult = 59; write_enable = 0;
        #20 RA1 = 9; RA2 = 9; WA = 7; ALUResult = 73; write_enable = 0;
        #20 RA1 = 15; RA2 = 11; WA = 9; ALUResult = 35; write_enable = 1;
        #20 RA1 = 4; RA2 = 0; WA = 0; ALUResult = 15; write_enable = 0;
        #20 RA1 = 6; RA2 = 8; WA = 12; ALUResult = 0; write_enable = 1;
        #20 RA1 = 12; RA2 = 0; WA = 6; ALUResult = 75; write_enable = 1;
        #15;
        $finish; 
    end

    initial begin 
        $monitor ("t = %3d, CLK = %b, RA1 = %b RA2 = %b, \
        WA = %b, ALUResult = %b, write_enable = %b, RD1 = %b, \
        RD2 = %b, cpu_out = %b", $time, CLK, RA1, RA2, WA, ALUResult, write_enable, RD1, RD2, cpu_out);
    end
endmodule