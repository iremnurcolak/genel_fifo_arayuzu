`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2021 10:23:04 AM
// Design Name: 
// Module Name: UART_receiver
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


module UART_receiver(
    input           system_clk      ,
    input           system_rst      ,
    input           RX              ,
    input           change_baudrate ,
    input [1:0]     baudrate        ,
    
    output  reg [7:0]   data        ,
    output  reg     data_en=0,
    output  reg     corrupted
    );
    reg [20:0]bit_basina_cevrim_next=2;
     reg[20:0] bit_basina_cevrim =2;
    reg [3:0] index=4'b0;
    integer num_of_cycles=0;
    reg mesgul=0;
    reg parity_bit=0;
    reg stop_bit=0;
  /*  
    always @(posedge system_clk) begin
        if( !system_rst ) begin
            if(change_baudrate)begin
                    
                    if(baudrate==2'b00) bit_basina_cevrim_next<=2;
                    else if (baudrate==2'b01)bit_basina_cevrim_simdiki<=4;
                end
                bit_basina_cevrim <=bit_basina_cevrim_next;
         end
    end*/
    always @*begin
         if(change_baudrate && !system_rst&& baudrate==2'b01)begin          
                       bit_basina_cevrim_next=4;
         end
         else if(system_rst ||(change_baudrate && baudrate==2'b00 &&!system_rst))begin
            bit_basina_cevrim_next=2;
         end
    
    end
    always @(posedge system_clk) begin
    $display("%d",bit_basina_cevrim_next);
        bit_basina_cevrim <=bit_basina_cevrim_next;
        if( !system_rst ) begin
            if(!mesgul)data_en<=0;
            if(!mesgul && RX==0&& num_of_cycles ==(bit_basina_cevrim-1)/2)begin
                data_en<=0;
                mesgul <=1;
                num_of_cycles <=  num_of_cycles+1;
                
            end
            else if(mesgul&& num_of_cycles ==(bit_basina_cevrim-1)/2 ) begin
                           
                if(index <8) begin     
                    data[index] <= RX;
                    index <= index+1;
                end
                if(index==8)begin
                    index <= index+1;
                    parity_bit <= RX;
                end
                if(index==9) begin
                    index <= 0;

                        if(parity_bit==(data[7]^data[6]^data[5]^data[4]^data[3]^data[2]^data[1]^data[0]))begin
                            corrupted <=0;
                        end
                        else begin 
                            corrupted <=1;
                        end
                        mesgul<=0;
                        data_en<=1;

                    stop_bit <= RX;
                end
                
            end
        end
        
        
        if (!system_rst && num_of_cycles<bit_basina_cevrim-1) begin
             num_of_cycles <=  num_of_cycles+1;

        end
       else if (!system_rst) begin
            num_of_cycles <=0;
        end
    end
endmodule