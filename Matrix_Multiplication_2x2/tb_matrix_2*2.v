module tb_matrix_mul_2x2;
    reg clk;
    reg rst;
    reg start;
    reg signed [7:0] A [0:1][0:1];
    reg signed [7:0] B [0:1][0:1];
    wire signed [15:0] C [0:1][0:1];
    wire done;
    matrix_mul_2x2 aa (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .C(C),
        .done(done)
    );
  
    always #5 clk = ~clk;
    initial 
      begin
        $dumpfile("matrix_mul.vcd");
        $dumpvars(0, tb_matrix_mul_2x2);
        clk   = 0;
        rst   = 1;
        start = 0;
        #10 rst = 0;
        A[0][0] = 1;  A[0][1] = 2;
        A[1][0] = 3;  A[1][1] = 4;
        B[0][0] = 5;  B[0][1] = 6;
        B[1][0] = 7;  B[1][1] = 8;
        #10 start = 1;
        #10 start = 0;
        #20;
        $display("C00 = %0d", C[0][0]);
        $display("C01 = %0d", C[0][1]);
        $display("C10 = %0d", C[1][0]);
        $display("C11 = %0d", C[1][1]);

        #10 $finish;
    end
endmodule
