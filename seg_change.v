/*Name: seg_change
Compiler: Quartus Prime Lite Edition 17.0.0
Coded by: Jianyu Chen
Place: Nanpin, China
Function: change the selected tube to show number on all 6 tubes
Time: 11th,Aug,2017 
*/

module led_seg(input [7:0]second_in,
			input [7:0]minute_in,
			input [7:0]hour_in,
			input rst_n,
			input clk,
			output [3:0]num_out,
			output [5:0]seg_sel);

reg[10:0] cnt;            
reg[5:0] bit;
reg[3:0] rnum_out;
reg[5:0] rseg_sel;

assign num_out=rnum_out;
assign seg_sel=rseg_sel;

parameter bit0=6'b111110,bit1=6'b111101,bit2=6'b111011,
				bit3=6'b110111,bit4=6'b101111,bit5=6'b011111,bit_no=6'b111111;

always@(negedge rst_n or posedge clk)begin
	if(!rst_n)begin
		cnt<=11'd0;
		bit<=bit0;
	end
	else begin
		if(cnt==6'd1250)begin
			cnt<=11'd0;
			case(bit)
			
			bit0:begin
				rnum_out[3:0]<=second_in[3:0];
				rseg_sel<=bit;
				bit<=bit1;
			end
			
			bit1:begin
				rnum_out[3:0]<=second_in[7:4];
				rseg_sel<=bit;
				bit<=bit2;
			end
			
			bit2:begin
				rnum_out[3:0]<=minute_in[3:0];
				rseg_sel<=bit;
				bit<=bit3;
			end
			
			bit3:begin
				rnum_out[3:0]<=minute_in[7:4];
				rseg_sel<=bit;
				bit<=bit4;
			end
			
			bit4:begin
				rnum_out[3:0]<=hour_in[3:0];
				rseg_sel<=bit;
				bit<=bit5;
			end
			
			bit5:begin
				rnum_out[0]<=hour_in[4];
				rnum_out[3:1]<=3'b0;
				rseg_sel<=bit;
				bit<=bit0;
			end
			
			default:bit<=bit0;
			
			endcase
		end
		else
			cnt<=cnt+11'd1;
	end
end
endmodule 