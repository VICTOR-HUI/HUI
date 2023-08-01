`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:56:12 07/02/2019 
// Design Name: 
// Module Name:    top 
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
module top(
input  clk,
input  rst,
input  [2:0] key,
output [9:0] out_da_data,//DA����
output out_da_clk,//DAģ������ź�
output out_da_wr//DAģ������ź�
);

wire [11:0]phase;
wire [1:0] FreqC2;
wire lod;
wire m1;
/*��ַ����DDS������*/
PhaseAdder u1(
.mode_m(m1),
.clk (clk),
.rst (rst),
.FreqCtrl (FreqC2),
.key  (key),
.phase (phase),
.load(lod)
);
/***ROM�˵���**/
wire [9:0]bx;
DDSROM u2
(
  .clka(clk),    // input clka
  .addra(phase), // input [11 : 0] addra
  .douta(bx)     // output [9 : 0] douta
);
/*��Ƶ*/
 fp u3(
 .clk(clk),
 .rst(rst),
 .clk4096(fpp)
 );
 /*m���в���*/
Mcode u4(
  .clk(fpp),
  .rst(rst),
  .m(m1),
  .load(lod)
 );
	/*���ֲ���ֵѡ��*/ 
ASK_set u7(
    .mode_M(m1),
	 .clk(clk),
	 .key(key),
	 .FreqC(FreqC2)
     ); 
/*DA����ģ�����*/
DA_I  u8(	
         .clk(clk),
         .out_data(bx),

			.out_da_data(out_da_data),
			.out_da_clk(out_da_clk),
			.out_da_wr(out_da_wr)
			);

endmodule
