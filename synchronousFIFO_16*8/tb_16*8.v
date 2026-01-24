
module tb_fifo_sync();

    reg clk;
    reg reset;
    reg write_en;
    reg read_en;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire empty, full;

    fifo_sync DUT (
        .clk(clk),
        .reset(reset),
        .write_en(write_en),
        .read_en(read_en),
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty),
        .full(full)
    );

    // CLOCK 10ns
    initial clk = 0;
    always #5 clk = ~clk;

    // DUMP
    initial begin
        $dumpfile("fifo_perfect.vcd");
        $dumpvars(0, tb_fifo_sync);
    end

    initial begin
        //--------------------
        // RESET → EMPTY
        //--------------------
        reset = 1;
        write_en = 0;
        read_en  = 0;
        data_in  = 0;
        #20;
        reset = 0;
        #10;

        //--------------------
        // WRITE till FULL
        //--------------------
        write_en = 1;
        repeat (16) begin
            data_in = data_in + 1;
            #10;
        end
        write_en = 0;
        #10;

        //--------------------
        // READ till EMPTY
        //--------------------
        read_en = 1;
        repeat (16) begin
            #10;
        end
        read_en = 0;
        #10;

        //--------------------
        // READ when EMPTY
        //--------------------
        read_en = 1;
        #20;
        read_en = 0;

        //--------------------
        // WRITE when FULL (check protection)
        //--------------------
        write_en = 1;
        data_in = 8'hAA;
        #20;
        write_en = 0;

        #20 $finish;
    end

endmodule
