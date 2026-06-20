`timescale 1ns/1ps

module tb_uart_fifo_top;

reg clk;
reg rst;
reg rx;

wire tx;


// DUT

uart_fifo_top DUT(

    .clk(clk),
    .rst(rst),

    .rx(rx),
    .tx(tx)

);


// Clock

always #5 clk = ~clk;


// UART Byte Sender

task send_byte;

input [7:0] data;

integer i;

begin

    // START BIT

    rx = 0;
    #(40);

    // DATA BITS

    for(i=0;i<8;i=i+1)
    begin

        rx = data[i];
        #(40);

    end

    // STOP BIT

    rx = 1;
    #(40);

end

endtask


// Test

initial
begin

    clk = 0;
    rst = 1;
    rx = 1;

    #50;

    rst = 0;

    #50;

    send_byte(8'h53);

    #100;

    send_byte(8'hA5);

    #100;

    send_byte(8'h11);

    #3000;

    $finish;

end

endmodule