`timescale 1ps/1ps
`include "microprocessor.sv"

module pc_tb;
    logic [7:0] PC, immediate;
    logic PCSrc, CLK, reset;

    pc dut (immediate, PCSrc, CLK, reset, PC);

    initial begin 
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    initial begin
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);
        immediate = 0; PCSrc = 0; reset = 1;
        #10 immediate = 22; PCSrc = 0; reset = 0;
        #10 immediate = 0; PCSrc = 0; reset = 0;
        #15 immediate = 53; PCSrc = 1; reset = 0;
        #20 immediate = 15; PCSrc = 1; reset = 0;
        #20 immediate = 0; PCSrc = 0; reset = 0;
        #20 immediate = 0; PCSrc = 0; reset = 1;
        #20 immediate = 17; PCSrc = 1; reset = 0;
        #20 immediate = 0; PCSrc = 0; reset = 0;
        #20 immediate = 0; PCSrc = 1; reset = 0;
        #15;
        $finish; 
    end

    initial begin 
        $monitor ("t=%3d, CLK=%b, immediate=%b, PCSrc=%b, reset=%b, PC=%b", $time, CLK, immediate, PCSrc, reset, PC);
    end
endmodule