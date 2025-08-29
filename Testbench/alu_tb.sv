`timescale 1ns/1ps
`include "microprocessor.sv"

module alu_tb;

    logic [7:0] SrcA, SrcB, ALUResult;
    logic [1:0] ALUControl;
    logic Zero;

    alu dut (SrcA, SrcB, ALUControl, ALUResult, Zero);

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        SrcA = 8'b00001001; SrcB = 8'b00001100; ALUControl = 2'b00; #20;
        ALUControl = 2'b01; #20;
        ALUControl = 2'b10; #20;
        ALUControl = 2'b11; #20;
    end

    initial begin
        $monitor("t=%3d, SrcA=%b, SrcB=%b, ALUControl=%b, ALUResult=%b, Zero=%b \n", $time, SrcA, SrcB, ALUControl, ALUResult, Zero);
    end

endmodule