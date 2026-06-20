module uart_rx(

    input clk,
    input rst,
    input rx,

    output reg [7:0] data_out,
    output reg rx_done

);

parameter BAUD_TICK_COUNT = 4;

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

reg [1:0] state;

reg [12:0] baud_count;
reg [2:0] bit_count;

reg [7:0] shift_reg;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        state <= IDLE;

        baud_count <= 0;
        bit_count <= 0;

        shift_reg <= 0;

        data_out <= 0;
        rx_done <= 0;

    end

    else
    begin

        case(state)

        IDLE:
        begin

            rx_done <= 0;

            if(rx == 0)
            begin
                baud_count <= 0;
                state <= START;
            end

        end

        START:
        begin

            if(baud_count < (BAUD_TICK_COUNT/2)-1)
            begin
                baud_count <= baud_count + 1;
            end

            else
            begin

                baud_count <= 0;

                if(rx == 0)
                begin
                    bit_count <= 0;
                    state <= DATA;
                end

                else
                begin
                    state <= IDLE;
                end

            end

        end

        DATA:
        begin

            if(baud_count < BAUD_TICK_COUNT-1)
            begin
                baud_count <= baud_count + 1;
            end

            else
            begin

                baud_count <= 0;

                shift_reg[bit_count] <= rx;

                if(bit_count == 3'd7)
                begin
                    state <= STOP;
                end

                else
                begin
                    bit_count <= bit_count + 1;
                end

            end

        end

        STOP:
        begin

            if(baud_count < BAUD_TICK_COUNT-1)
            begin
                baud_count <= baud_count + 1;
            end

            else
            begin

                baud_count <= 0;

                if(rx == 1)
                begin
                    data_out <= shift_reg;
                    rx_done <= 1;
                end

                state <= IDLE;

            end

        end

        default:
            state <= IDLE;

        endcase

    end

end

endmodule