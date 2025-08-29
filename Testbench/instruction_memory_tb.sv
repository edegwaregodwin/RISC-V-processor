`timescale 1ps/1ps
`include "microprocessor.sv"

module instruction_memory_tb;
    logic [7:0] PC;
    logic [23:0] Instr;

    instruction_memory dut (PC, Instr);

    initial begin
        $dumpfile("instruction_memory_tb.vcd");
        $dumpvars(0, instruction_memory_tb);
        PC = 8'h00; 
        #20 PC = 8'h01;
        #20 PC = 8'h02;
        #20 PC = 8'h03;
        #20 PC = 8'h04;
        #20 PC = 8'h05;
        #20 PC = 8'h06;
        #20 PC = 8'h07;
        #20;

        $finish; 
    end

    initial begin 
        $monitor ("t = %3d, PC = %b, Instr = %b", $time, PC, Instr);
    end
endmodule