module bitalu_16bit (
    input  signed [15:0] A,
    input  signed [15:0] B,
    input  [3:0] OP,
    output reg signed [15:0] RESULT,
    output reg CARRY,
    output reg OVERFLOW,
    output ZERO
);

always @(*) begin
    
    RESULT   = 16'sd0;
    CARRY    = 1'b0;
    OVERFLOW = 1'b0;

    case (OP)

        4'b0000: begin   
            {CARRY, RESULT} = A + B;
            OVERFLOW = (A[15] == B[15]) && (RESULT[15] != A[15]);
        end

        4'b0001: begin   
            {CARRY, RESULT} = A - B;
            OVERFLOW = (A[15] != B[15]) && (RESULT[15] != A[15]);
        end

        4'b0010: RESULT = A & B;  
        4'b0011: RESULT = A | B;  
        4'b0100: RESULT = A ^ B;   
        4'b0101: RESULT = ~A;      

        4'b0110: RESULT = A <<< 1; 
        4'b0111: RESULT = A >>> 1; 

        4'b1000: RESULT = A + 1;   
        4'b1001: RESULT = A - 1;   

        default: RESULT = 16'sd0;
    endcase
end


assign ZERO = (RESULT == 16'sd0);

endmodule
