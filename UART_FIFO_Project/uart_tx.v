module uart_tx(

    input clk,
    input rst,

    input tx_start,
    input [7:0] data_in,

    output reg tx,
    output reg tx_done

);

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

// For simulation
parameter BAUD_TICK_COUNT = 4;

reg [1:0] state;

reg [7:0] shift_reg;
reg [2:0] bit_count;
reg [12:0] baud_count;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        state      <= IDLE;
        tx         <= 1'b1;
        tx_done    <= 1'b0;

        shift_reg  <= 8'd0;
        bit_count  <= 3'd0;
        baud_count <= 13'd0;
    end

    else
    begin

        case(state)

        //------------------------------------------------
        // IDLE
        //------------------------------------------------
        IDLE:
        begin

            tx <= 1'b1;
            tx_done <= 1'b0;

            bit_count <= 0;
            baud_count <= 0;

            if(tx_start)
            begin
                shift_reg <= data_in;
                state <= START;
            end

        end

        //------------------------------------------------
        // START BIT
        //------------------------------------------------
        START:
        begin

            tx <= 1'b0;

            if(baud_count == BAUD_TICK_COUNT-1)
            begin
                baud_count <= 0;
                state <= DATA;
            end
            else
            begin
                baud_count <= baud_count + 1;
            end

        end

        //------------------------------------------------
        // DATA BITS
        //------------------------------------------------
        DATA:
        begin

            tx <= shift_reg[0];

            if(baud_count == BAUD_TICK_COUNT-1)
            begin

                baud_count <= 0;

                shift_reg <= shift_reg >> 1;

                if(bit_count == 3'd7)
                begin
                    bit_count <= 0;
                    state <= STOP;
                end
                else
                begin
                    bit_count <= bit_count + 1;
                end

            end
            else
            begin
                baud_count <= baud_count + 1;
            end

        end

        //------------------------------------------------
        // STOP BIT
        //------------------------------------------------
        STOP:
        begin

            tx <= 1'b1;

            if(baud_count == BAUD_TICK_COUNT-1)
            begin

                baud_count <= 0;
                tx_done <= 1'b1;
                state <= IDLE;

            end
            else
            begin
                baud_count <= baud_count + 1;
            end

        end

        default:
            state <= IDLE;

        endcase

    end

end

endmodule