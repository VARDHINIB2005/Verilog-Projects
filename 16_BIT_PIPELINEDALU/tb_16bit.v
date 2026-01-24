

module tb_pipelined_alu();
    reg clk;
    reg reset;
    reg [15:0] A;
    reg [15:0] B;
    reg [3:0]  alu_op;
    wire [15:0] result;
    pipelined_alu aa(
        .clk(clk),
        .reset(reset),
        .A(A),
        .B(B),
        .alu_op(alu_op),
        .result(result) );
    always #5 clk = ~clk;
    initial begin
        $dumpfile("pipelined_alu.vcd");
         $dumpvars(0, tb_pipelined_alu);
        clk = 0;
        reset = 1;
        A = 0;
        B = 0;
        alu_op = 0;
        #12 reset = 0;
      
        #10 A = 16'd10; B = 16'd5; alu_op = 4'b0000; // ADD
        #10 A = 16'd20; B = 16'd3; alu_op = 4'b0001; // SUB
        #10 A = 16'd6;  B = 16'd2; alu_op = 4'b0010; // AND
        #10 A = 16'd8;  B = 16'd1; alu_op = 4'b0011; // OR
        #10 A = 16'd9;  B = 16'd4; alu_op = 4'b0100; // XOR

        #100 $finish;
    end

endmodule
