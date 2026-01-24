//====================================================
// 3-Stage 16-bit Pipelined ALU
// Stage-1 : Operand Fetch
// Stage-2 : Execute
// Stage-3 : Write Back
//====================================================

module pipelined_alu (
    input  wire        clk,
    input  wire        reset,      // Active-HIGH async reset
    input  wire [15:0] A,
    input  wire [15:0] B,
    input  wire [3:0]  alu_op,
    output reg  [15:0] result
);
    reg [15:0] A1, B1;
    reg [3:0]  OP1;
    reg [15:0] ALU_OUT2;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A1  <= 16'd0;
            B1  <= 16'd0;
            OP1 <= 4'd0;
        end else begin
            A1  <= A;
            B1  <= B;
            OP1 <= alu_op;
        end
    end
    always @(posedge clk or posedge reset) 
      begin
        if (reset) begin
            ALU_OUT2 <= 16'd0;
        end else begin
            case (OP1)
                4'b0000: ALU_OUT2 <= A1 + B1; // ADD
                4'b0001: ALU_OUT2 <= A1 - B1; // SUB
                4'b0010: ALU_OUT2 <= A1 & B1; // AND
                4'b0011: ALU_OUT2 <= A1 | B1; // OR
                4'b0100: ALU_OUT2 <= A1 ^ B1; // XOR
                default: ALU_OUT2 <= 16'd0;
            endcase
        end
    end
    always @(posedge clk or posedge reset)
      begin
        if (reset)
            result <= 16'd0;
        else
            result <= ALU_OUT2;
    end

endmodule

