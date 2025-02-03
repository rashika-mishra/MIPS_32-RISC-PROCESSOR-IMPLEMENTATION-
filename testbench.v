`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2025 11:02:37 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench;
 reg clk1,clk2;
 integer k;
 
 PIPE_mips32 mips_32(clk1,clk2);
 
 initial begin
    repeat(20)
    begin
        #5 clk1=1;
        #5 clk1=0;
        #5 clk2=1;
        #5 clk2=0;
    end
 end
 
 initial begin
    for(k=0;k<31;k=k+1)
        mips_32.REG[k]=k;
    mips_32.Mem[0] = 32'h2801000a; // ADDI R1,R0,10
    mips_32.Mem[1] = 32'h28020014; // ADDI R2,R0,20
    mips_32.Mem[2] = 32'h28030019; // ADDI R3,R0,25
    mips_32.Mem[3] = 32'h0ce77800; // OR R7,R7,R7 -- dummy instr.
    mips_32.Mem[4] = 32'h0ce77800; // OR R7,R7,R7 -- dummy instr.
    mips_32.Mem[5] = 32'h00222000; // ADD R4,R1,R2
    mips_32.Mem[6] = 32'h0ce77800; // OR R7,R7,R7 -- dummy instr.
    mips_32.Mem[7] = 32'h00832800; // ADD R5,R4,R3
    mips_32.Mem[8] = 32'hfc000000; // HLT
        
    mips_32.HALTED=0;
    mips_32.TAKEN_BRANCH=0;
    mips_32.PC=0;
    #280
    for(k=0;k<6;k=k+1)
        $display("R%1d - %2d",k,mips_32.REG[k]);
    
 end
 
 initial
  begin
    $dumpfile ("mips.vcd");
    $dumpvars (0, testbench);
    #300 $finish;
  end
endmodule
