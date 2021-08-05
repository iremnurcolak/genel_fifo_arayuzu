`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2021 06:53:29 PM
// Design Name: 
// Module Name: tb_tr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_tr(

    );
    
       reg system_clk; reg system_rst;
    reg [7:0] data; reg data_en;
    reg change_baudrate;reg [1:0]  baudrate ;
    wire TX; wire bitti;
    
    UART_transmitter uut(system_clk,system_rst,data,data_en,change_baudrate,baudrate,TX,bitti);
    
    always begin
        system_clk=~system_clk; #5;
    end
    initial begin
        system_clk=1;system_rst=0;
        data=8'b11111111; data_en=1; change_baudrate=0;baudrate=2'b00;
    
    end
endmodule
