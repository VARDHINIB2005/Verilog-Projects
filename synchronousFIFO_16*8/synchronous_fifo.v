module fifo_sync #(
    parameter DEPTH = 16,
    parameter DATA_WIDTH = 8,
    parameter PTR_SIZE = 5        // log2(DEPTH)+1
)(
    input  wire      clk,
    input  wire      reset,
    input  wire      write_en,
    input  wire        read_en,
    input  wire [DATA_WIDTH-1:0] data_in,
    output wire [DATA_WIDTH-1:0] data_out,
    output wire        empty,
    output wire         full
);

    // Memory
    reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

    // Pointers
    reg [PTR_SIZE-1:0] wr_ptr;
    reg [PTR_SIZE-1:0] rd_ptr;

    // Flags
    reg empty_reg;
    reg full_reg;

    // WRITE POINTER
    always @(posedge clk or posedge reset) begin
        if (reset)
            wr_ptr <= 0;
        else if (write_en && !full_reg)
            wr_ptr <= wr_ptr + 1;
    end

    // READ POINTER
    always @(posedge clk or posedge reset) begin
        if (reset)
            rd_ptr <= 0;
        else if (read_en && !empty_reg)
            rd_ptr <= rd_ptr + 1;
    end

    // EMPTY FLAG
    always @(posedge clk or posedge reset) begin
        if (reset)
            empty_reg <= 1'b1;
        else if (write_en && !full_reg)
            empty_reg <= 1'b0;
        else if (read_en && (wr_ptr == rd_ptr + 1))
            empty_reg <= 1'b1;
    end

    // FULL FLAG
    always @(posedge clk or posedge reset) begin
        if (reset)
            full_reg <= 1'b0;
        else if (write_en && (wr_ptr == rd_ptr))
            full_reg <= 1'b1;
        else if (read_en && !empty_reg)
            full_reg <= 1'b0;
    end

    // WRITE DATA
    always @(posedge clk) begin
        if (write_en && !full_reg)
            memory[wr_ptr[PTR_SIZE-2:0]] <= data_in;
    end

    // READ DATA
    assign data_out = empty_reg ? {DATA_WIDTH{1'bx}} :
                      memory[rd_ptr[PTR_SIZE-2:0]];

    assign empty = empty_reg;
    assign full  = full_reg;
endmodule
