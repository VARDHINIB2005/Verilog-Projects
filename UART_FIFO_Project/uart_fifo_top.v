module uart_fifo_top(

    input clk,
    input rst,

    input rx,
    output tx

);

wire [7:0] rx_data;
wire rx_done;

wire [7:0] fifo_data;

wire fifo_full;
wire fifo_empty;

reg fifo_rd_en;

reg tx_start;
wire tx_done;

reg [1:0] state;

localparam IDLE      = 2'd0;
localparam READ_FIFO = 2'd1;
localparam LOAD_TX   = 2'd2;
localparam WAIT_TX   = 2'd3;


// UART RX

uart_rx RX(

    .clk(clk),
    .rst(rst),
    .rx(rx),

    .data_out(rx_data),
    .rx_done(rx_done)

);


// FIFO

sync_fifo FIFO(

    .clk(clk),
    .rst(rst),

    .wr_en(rx_done),
    .rd_en(fifo_rd_en),

    .data_in(rx_data),

    .data_out(fifo_data),

    .full(fifo_full),
    .empty(fifo_empty)

);


// UART TX

uart_tx TX(

    .clk(clk),
    .rst(rst),

    .tx_start(tx_start),

    .data_in(fifo_data),

    .tx(tx),
    .tx_done(tx_done)

);


// Controller FSM

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        state <= IDLE;

        fifo_rd_en <= 0;
        tx_start <= 0;

    end

    else
    begin

        case(state)

        IDLE:
        begin

            fifo_rd_en <= 0;
            tx_start <= 0;

            if(!fifo_empty)
                state <= READ_FIFO;

        end

        READ_FIFO:
        begin

            fifo_rd_en <= 1;
            state <= LOAD_TX;

        end

        LOAD_TX:
        begin

            fifo_rd_en <= 0;

            tx_start <= 1;

            state <= WAIT_TX;

        end

        WAIT_TX:
        begin

            tx_start <= 0;

            if(tx_done)
            begin

                if(fifo_empty)
                    state <= IDLE;
                else
                    state <= READ_FIFO;

            end

        end

        default:
            state <= IDLE;

        endcase

    end

end

endmodule