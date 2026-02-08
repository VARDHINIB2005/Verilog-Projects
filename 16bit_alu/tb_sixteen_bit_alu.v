module tb_16bit_alu();
reg signed [15:0] A, B;
reg [3:0] OP;
wire signed [15:0] RESULT;
wire CARRY, OVERFLOW, ZERO;
bitalu_16bit aa (
    .A(A),.B(B),.OP(OP),.RESULT(RESULT),.CARRY(CARRY),.OVERFLOW(OVERFLOW),.ZERO(ZERO));
initial
  begin    
  $dumpfile("bitalu_16bit.vcd");
  $dumpvars(0, tb_16bit_alu);    
    A = 16'sd10; 
    B = 16'sd5;

    OP = 4'b0000; #10; // ADD
    OP = 4'b0001; #10; // SUB
    OP = 4'b0010; #10; // AND
    OP = 4'b0011; #10; // OR
    OP = 4'b0100; #10; // XOR
    OP = 4'b0101; #10; // NOT
    OP = 4'b0110; #10; // SHL
    OP = 4'b0111; #10; // SHR
    OP = 4'b1000; #10; // INC
    OP = 4'b1001; #10; // DEC    
   // Overflow test for ADD
A = 16'sd32767; B = 16'sd1; OP = 4'b0000; #10;

// Overflow test for SUB
A = 16'sd32767; B = -16'sd1; OP = 4'b0001; #10;
 #10  $finish;
end
endmodule

