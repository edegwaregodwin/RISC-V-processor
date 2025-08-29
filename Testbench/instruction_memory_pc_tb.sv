`timescale 1ps/1ps
`include "microprocessor.sv"

module instruction_memory_pc_tb;
    logic [7:0] immediate;
    logic [23:0] Instr;
    logic PCSrc, CLK, reset;

    instruction_memory_pc dut (immediate, PCSrc, CLK, reset, Instr);

    initial begin 
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    initial begin
        $dumpfile("instruction_memory_pc_tb.vcd");
        $dumpvars(0, instruction_memory_pc_tb);
        immediate = 0; PCSrc = 0; reset = 1;
        #15 immediate = 0; PCSrc = 0; reset = 0;
        #15 immediate = 0; PCSrc = 0; reset = 0;
        #15 immediate = 0; PCSrc = 0; reset = 0;
        #20 immediate = 0; PCSrc = 0; reset = 0;
        #20 immediate = 0; PCSrc = 0; reset = 0;
        #20 immediate = 0; PCSrc = 0; reset = 0;
        #20 immediate = 0; PCSrc = 0; reset = 0;
        #20 immediate = 0; PCSrc = 0; reset = 0;
        #20 immediate = 5; PCSrc = 1; reset = 0;
        #15;
        $finish; 
    end

    initial begin 
        $monitor ("t=%3d, CLK=%b, immediate=%b, PCSrc=%b, reset=%b, Instr=%b", $time, CLK, immediate, PCSrc, reset, Instr);
    end
endmodule