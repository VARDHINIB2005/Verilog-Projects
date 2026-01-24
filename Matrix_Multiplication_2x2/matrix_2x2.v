module matrix_mul_2x2 (
    input  clk,
    input  rst,
    input  start,

    input  signed [7:0] A [0:1][0:1],
    input  signed [7:0] B [0:1][0:1],

    output reg signed [15:0] C [0:1][0:1],
    output reg done
);

    integer i, j, k;
    reg signed [15:0] sum;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            done <= 0;
            sum  <= 0;
        end
        else if (start) begin
            done <= 0;

            for (i = 0; i < 2; i = i + 1) begin
                for (j = 0; j < 2; j = j + 1) begin
                    sum = 0;
                    for (k = 0; k < 2; k = k + 1) begin
                        sum = sum + A[i][k] * B[k][j];
                    end
                    C[i][j] <= sum;
                end
            end

            done <= 1;
        end
    end
endmodule
