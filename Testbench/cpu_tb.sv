`timescale 1ps/1ps
`include "microprocessor.sv"

module cpu_tb;
    logic [7:0] ALUResult, cpu_out;
    logic CLK, reset;

    cpu dut (CLK, reset, ALUResult, cpu_out);

    initial begin 
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);
        reset = 1;
        #15 reset = 0;
        #495
        $finish; 
    end

    initial begin 
        $monitor ("t=%3d, CLK=%b, reset=%b, ALUResult=%b, cpu_out=%b", $time, CLK, reset, ALUResult, cpu_out);
    end
endmodule