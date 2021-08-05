`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2021 12:31:58 PM
// Design Name: 
// Module Name: genel_fifo_arayuzu
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


module genel_fifo_arayuzu(
    input system_clk,system_rst,
    input [31:0] komut,
    input komut_gecerli,
   // input veri_hazir,
 //   input RX,
    output TX,
    output reg komut_hazir
  //  output [31:0] veri,
   // output veri_gecerli
    );
    reg data_en=0;
    reg change_baudrate=0;
    reg [1:0] baudrate=2'b00;
    wire data_sent;
    wire corrupted;
    UART_transmitter send(system_clk,system_rst,komut[31:24],data_en,change_baudrate,baudrate,TX,data_sent);
   // UART_receiver    receive(system_clk,system_rst,RX,change_baudrate,baudrate,,corrupted);
    reg mesgul_tr=0;
    reg mesgul_re=0;
    wire [3:0] bayt_sent=4'd0;
    
    reg [31:0] veri_r;
    always @(posedge system_clk)begin
        if(!system_rst)begin

            if(komut_gecerli==1 && komut[2:0]==3'b000&&mesgul_tr==0)begin //oku
                data_en<=1;
                mesgul_tr<=1;
            end
            else if(komut_gecerli==1 && komut[2:0]==3'b001&&mesgul_re==0)begin //yaz
          
                mesgul_re<=1;
            end
            else if(komut_gecerli==1 && komut[2:0]==3'b010&&mesgul_re==0&&mesgul_tr==0)begin
                change_baudrate<=1;
                baudrate<=komut[23:22];
            end
            
      
        end
        else begin
            
        end
    end
    
    always @(posedge system_clk)begin
        if(!system_rst)begin
            if(data_sent)begin
                mesgul_tr<=0;
                komut_hazir<=1;
                data_en<=0;
            end
            else if(data_sent==0&&mesgul_tr==0)begin
                komut_hazir<=0;
            end
        end
    end
    
endmodule
