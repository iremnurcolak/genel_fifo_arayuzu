`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2021 12:52:20 PM
// Design Name: 
// Module Name: tb_genel_fifo_arayuzu
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


module tb_genel_fifo_arayuzu(

    );
    reg system_clk,system_rst;
    reg [31:0] komut;
    reg komut_gecerli;
    wire TX;
    wire komut_hazir;
    
    genel_fifo_arayuzu uut (system_clk,system_rst,komut,komut_gecerli,TX,komut_hazir);
    always begin
        system_clk = ~system_clk; #5;
    end
    
    initial begin
        system_clk=1;
        system_rst=0;
        komut=32'b01010101010101010101010101010101; komut_gecerli=1;
    
    end 
endmodule
