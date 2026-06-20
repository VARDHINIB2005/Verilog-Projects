module sync_fifo(

    input clk,
    input rst,

    input wr_en,
    input rd_en,

    input [7:0] data_in,

    output reg [7:0] data_out,

    output full,
    output empty

);

reg [7:0] fifo_mem [0:7];

reg [2:0] write_ptr;
reg [2:0] read_ptr;

reg [3:0] count;

// EMPTY & FULL FLAGS

assign empty = (count == 0);
assign full  = (count == 8);

// MAIN LOGIC

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        write_ptr <= 0;
        read_ptr  <= 0;

        count <= 0;

        data_out <= 0;

    end

    else
    begin

        // WRITE

        if(wr_en && !full)
        begin

            fifo_mem[write_ptr] <= data_in;

            write_ptr <= write_ptr + 1;

            count <= count + 1;

        end

        // READ

        if(rd_en && !empty)
        begin

            data_out <= fifo_mem[read_ptr];

            read_ptr <= read_ptr + 1;

            count <= count - 1;

        end

    end

end

endmodule