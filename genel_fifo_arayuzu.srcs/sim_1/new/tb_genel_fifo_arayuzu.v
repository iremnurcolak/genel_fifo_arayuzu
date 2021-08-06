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
    reg veri_hazir;
    reg RX;
    wire TX;
    wire komut_hazir;
    wire  [31:0] veri;
    wire veri_gecerli;
    genel_fifo_arayuzu uut (system_clk,system_rst,komut,komut_gecerli,veri_hazir,RX,TX,komut_hazir,veri,veri_gecerli);
    always begin
        system_clk = ~system_clk; #5;
    end
    
    initial begin
        system_clk=1;
        system_rst=0;
    //    komut=32'b01110001010101010101010101010000; komut_gecerli=1; #250;
      // komut=32'b01010101101010101010101010101000; komut_gecerli=1;   #250;
        komut=32'b01010101011010101010101010101001; komut_gecerli=1;   #10;
        RX=0;#20;RX=1;#20;RX=0;#20;RX=1;#20;RX=0;#20;RX=1;#20;RX=0;#20;RX=1;#20;RX=0;#20; RX=0; #20; RX=1;
 #100;
        komut=32'b01010101101010101010101010101000; komut_gecerli=1;   #250;
    end 
endmodule
