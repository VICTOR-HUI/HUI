`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:16:51 07/10/2019 
// Design Name: 
// Module Name:    Mcode 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mcode(clk,rst,m,load);

input  clk,rst;
output  m,load;
reg    m_out;

reg  load;
reg  [14:0] shift; //15����λ�Ĵ�����������Ϊ2^15-1������

always @(posedge clk or negedge rst) 
	begin
		if(!rst) 
		begin//��ʼ��
			m_out<=1'b0;
			load<=1'b0;  
			shift <= 15'b0111_0111_0111_011; 
		end
		else  
		begin//��ʼ���������ź�
			if(clk)
			begin
				shift<={shift[13:0],shift[0]};
				shift[0]<=( shift[13]^shift[14]);//��Ӧ��ԭ����ʽF��x��=x^15+x^14+1
  				load<=1'b1;
			end
         else 
			begin
				load<=1'b0;            
         end	
         m_out<=shift[14];
		end
	end
	
assign m = m_out;  //��λ�Ĵ�
endmodule
