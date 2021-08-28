`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Iremnur Colak
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
    input veri_hazir,
    input RX,
    output TX,
    output reg komut_hazir = 1,
    output [31:0] veri,
    output veri_gecerli 
    );
    reg data_en=0;
    reg change_baudrate=0;
    reg [1:0] baudrate=2'b00;
    reg [1:0] baudrate_onceki=2'b00;
    wire data_sent;
    wire corrupted;
    wire [7:0] RX_data;
    wire RX_data_en;
    wire changed_tr,changed_re;
    UART_transmitter send(system_clk,system_rst,komut[31:24],data_en,change_baudrate,baudrate,TX,data_sent,changed_tr);
    UART_receiver    receive(system_clk,system_rst,RX,change_baudrate,baudrate,RX_data,RX_data_en,corrupted,changed_re);
    reg mesgul_tr=0;
    reg mesgul_re=0;
    reg mesgul_br=0;
    
    assign veri[7:0]=RX_data;
    assign veri_gecerli=RX_data_en;

    always @(posedge system_clk)begin
        if(!system_rst)begin
            baudrate_onceki<=baudrate;
            if(komut_gecerli==1 && komut[2:0]==3'b000&&mesgul_tr==0)begin 
                data_en<=1;
                mesgul_tr<=1;
            end
            else if(komut_gecerli==1 && komut[2:0]==3'b001&&mesgul_re==0&&veri_hazir)begin 
                komut_hazir<=0;
                mesgul_re<=1;
            end
            else if(komut_gecerli==1 && komut[2:0]==3'b010&&(mesgul_re==0 || RX_data_en==1)&&mesgul_tr==0)begin
                change_baudrate<=1;
                baudrate<=komut[23:22];
                mesgul_br<=1;
            end
            if(data_sent)begin
                mesgul_tr<=0;
                komut_hazir<=1;
                data_en<=0;
            end
            
            if(changed_tr && changed_re)begin
                mesgul_br<=0;
                change_baudrate<=0;
            end
            
            if(mesgul_tr==1 || mesgul_re==1 ||mesgul_br==1)begin
                komut_hazir<=0;
            end
            
            
            if(RX_data_en)begin
                mesgul_re<=0;
                komut_hazir<=1;
            end
      
        end
        else begin
            data_en<=0;
            komut_hazir<=1;
            change_baudrate<=0;
            baudrate<=2'b00;
            mesgul_tr<=0;
            mesgul_re<=0;
            mesgul_br<=0;
        end
    end
    
endmodule