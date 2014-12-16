// File name:   gpu_packlut.sv
// Created:     12/15/2014
// Author:      Manik Singhal Jake Stevens Erik Swan
// Lab Section: 337-04
// Version:     1.0  ECE337 Final Project Version
// Description: LUT for packing address generated from lookuptableforpacking.py 

`include "source/gpu_definitions.vh"
module gpu_packlut
(
	input wire [`HEIGHT_BITS - 1:0] addressy,
	output wire [`HEIGHT_BITS + `WIDTH_BITS - 1:0] rtpaddy
	);
	reg [`HEIGHT_BITS + `WIDTH_BITS - 1:0] reg_rtpaddy;
	assign rtpaddy = reg_rtpaddy;
	always @ (addressy)
	begin
		case (addressy)
			`HEIGHT_BITS'd0: reg_rtpaddy = `SUM_BITS'd0;
			`HEIGHT_BITS'd1: reg_rtpaddy = `SUM_BITS'd320;
			`HEIGHT_BITS'd2: reg_rtpaddy = `SUM_BITS'd640;
			`HEIGHT_BITS'd3: reg_rtpaddy = `SUM_BITS'd960;
			`HEIGHT_BITS'd4: reg_rtpaddy = `SUM_BITS'd1280;
			`HEIGHT_BITS'd5: reg_rtpaddy = `SUM_BITS'd1600;
			`HEIGHT_BITS'd6: reg_rtpaddy = `SUM_BITS'd1920;
			`HEIGHT_BITS'd7: reg_rtpaddy = `SUM_BITS'd2240;
			`HEIGHT_BITS'd8: reg_rtpaddy = `SUM_BITS'd2560;
			`HEIGHT_BITS'd9: reg_rtpaddy = `SUM_BITS'd2880;
			`HEIGHT_BITS'd10: reg_rtpaddy = `SUM_BITS'd3200;
			`HEIGHT_BITS'd11: reg_rtpaddy = `SUM_BITS'd3520;
			`HEIGHT_BITS'd12: reg_rtpaddy = `SUM_BITS'd3840;
			`HEIGHT_BITS'd13: reg_rtpaddy = `SUM_BITS'd4160;
			`HEIGHT_BITS'd14: reg_rtpaddy = `SUM_BITS'd4480;
			`HEIGHT_BITS'd15: reg_rtpaddy = `SUM_BITS'd4800;
			`HEIGHT_BITS'd16: reg_rtpaddy = `SUM_BITS'd5120;
			`HEIGHT_BITS'd17: reg_rtpaddy = `SUM_BITS'd5440;
			`HEIGHT_BITS'd18: reg_rtpaddy = `SUM_BITS'd5760;
			`HEIGHT_BITS'd19: reg_rtpaddy = `SUM_BITS'd6080;
			`HEIGHT_BITS'd20: reg_rtpaddy = `SUM_BITS'd6400;
			`HEIGHT_BITS'd21: reg_rtpaddy = `SUM_BITS'd6720;
			`HEIGHT_BITS'd22: reg_rtpaddy = `SUM_BITS'd7040;
			`HEIGHT_BITS'd23: reg_rtpaddy = `SUM_BITS'd7360;
			`HEIGHT_BITS'd24: reg_rtpaddy = `SUM_BITS'd7680;
			`HEIGHT_BITS'd25: reg_rtpaddy = `SUM_BITS'd8000;
			`HEIGHT_BITS'd26: reg_rtpaddy = `SUM_BITS'd8320;
			`HEIGHT_BITS'd27: reg_rtpaddy = `SUM_BITS'd8640;
			`HEIGHT_BITS'd28: reg_rtpaddy = `SUM_BITS'd8960;
			`HEIGHT_BITS'd29: reg_rtpaddy = `SUM_BITS'd9280;
			`HEIGHT_BITS'd30: reg_rtpaddy = `SUM_BITS'd9600;
			`HEIGHT_BITS'd31: reg_rtpaddy = `SUM_BITS'd9920;
			`HEIGHT_BITS'd32: reg_rtpaddy = `SUM_BITS'd10240;
			`HEIGHT_BITS'd33: reg_rtpaddy = `SUM_BITS'd10560;
			`HEIGHT_BITS'd34: reg_rtpaddy = `SUM_BITS'd10880;
			`HEIGHT_BITS'd35: reg_rtpaddy = `SUM_BITS'd11200;
			`HEIGHT_BITS'd36: reg_rtpaddy = `SUM_BITS'd11520;
			`HEIGHT_BITS'd37: reg_rtpaddy = `SUM_BITS'd11840;
			`HEIGHT_BITS'd38: reg_rtpaddy = `SUM_BITS'd12160;
			`HEIGHT_BITS'd39: reg_rtpaddy = `SUM_BITS'd12480;
			`HEIGHT_BITS'd40: reg_rtpaddy = `SUM_BITS'd12800;
			`HEIGHT_BITS'd41: reg_rtpaddy = `SUM_BITS'd13120;
			`HEIGHT_BITS'd42: reg_rtpaddy = `SUM_BITS'd13440;
			`HEIGHT_BITS'd43: reg_rtpaddy = `SUM_BITS'd13760;
			`HEIGHT_BITS'd44: reg_rtpaddy = `SUM_BITS'd14080;
			`HEIGHT_BITS'd45: reg_rtpaddy = `SUM_BITS'd14400;
			`HEIGHT_BITS'd46: reg_rtpaddy = `SUM_BITS'd14720;
			`HEIGHT_BITS'd47: reg_rtpaddy = `SUM_BITS'd15040;
			`HEIGHT_BITS'd48: reg_rtpaddy = `SUM_BITS'd15360;
			`HEIGHT_BITS'd49: reg_rtpaddy = `SUM_BITS'd15680;
			`HEIGHT_BITS'd50: reg_rtpaddy = `SUM_BITS'd16000;
			`HEIGHT_BITS'd51: reg_rtpaddy = `SUM_BITS'd16320;
			`HEIGHT_BITS'd52: reg_rtpaddy = `SUM_BITS'd16640;
			`HEIGHT_BITS'd53: reg_rtpaddy = `SUM_BITS'd16960;
			`HEIGHT_BITS'd54: reg_rtpaddy = `SUM_BITS'd17280;
			`HEIGHT_BITS'd55: reg_rtpaddy = `SUM_BITS'd17600;
			`HEIGHT_BITS'd56: reg_rtpaddy = `SUM_BITS'd17920;
			`HEIGHT_BITS'd57: reg_rtpaddy = `SUM_BITS'd18240;
			`HEIGHT_BITS'd58: reg_rtpaddy = `SUM_BITS'd18560;
			`HEIGHT_BITS'd59: reg_rtpaddy = `SUM_BITS'd18880;
			`HEIGHT_BITS'd60: reg_rtpaddy = `SUM_BITS'd19200;
			`HEIGHT_BITS'd61: reg_rtpaddy = `SUM_BITS'd19520;
			`HEIGHT_BITS'd62: reg_rtpaddy = `SUM_BITS'd19840;
			`HEIGHT_BITS'd63: reg_rtpaddy = `SUM_BITS'd20160;
			`HEIGHT_BITS'd64: reg_rtpaddy = `SUM_BITS'd20480;
			`HEIGHT_BITS'd65: reg_rtpaddy = `SUM_BITS'd20800;
			`HEIGHT_BITS'd66: reg_rtpaddy = `SUM_BITS'd21120;
			`HEIGHT_BITS'd67: reg_rtpaddy = `SUM_BITS'd21440;
			`HEIGHT_BITS'd68: reg_rtpaddy = `SUM_BITS'd21760;
			`HEIGHT_BITS'd69: reg_rtpaddy = `SUM_BITS'd22080;
			`HEIGHT_BITS'd70: reg_rtpaddy = `SUM_BITS'd22400;
			`HEIGHT_BITS'd71: reg_rtpaddy = `SUM_BITS'd22720;
			`HEIGHT_BITS'd72: reg_rtpaddy = `SUM_BITS'd23040;
			`HEIGHT_BITS'd73: reg_rtpaddy = `SUM_BITS'd23360;
			`HEIGHT_BITS'd74: reg_rtpaddy = `SUM_BITS'd23680;
			`HEIGHT_BITS'd75: reg_rtpaddy = `SUM_BITS'd24000;
			`HEIGHT_BITS'd76: reg_rtpaddy = `SUM_BITS'd24320;
			`HEIGHT_BITS'd77: reg_rtpaddy = `SUM_BITS'd24640;
			`HEIGHT_BITS'd78: reg_rtpaddy = `SUM_BITS'd24960;
			`HEIGHT_BITS'd79: reg_rtpaddy = `SUM_BITS'd25280;
			`HEIGHT_BITS'd80: reg_rtpaddy = `SUM_BITS'd25600;
			`HEIGHT_BITS'd81: reg_rtpaddy = `SUM_BITS'd25920;
			`HEIGHT_BITS'd82: reg_rtpaddy = `SUM_BITS'd26240;
			`HEIGHT_BITS'd83: reg_rtpaddy = `SUM_BITS'd26560;
			`HEIGHT_BITS'd84: reg_rtpaddy = `SUM_BITS'd26880;
			`HEIGHT_BITS'd85: reg_rtpaddy = `SUM_BITS'd27200;
			`HEIGHT_BITS'd86: reg_rtpaddy = `SUM_BITS'd27520;
			`HEIGHT_BITS'd87: reg_rtpaddy = `SUM_BITS'd27840;
			`HEIGHT_BITS'd88: reg_rtpaddy = `SUM_BITS'd28160;
			`HEIGHT_BITS'd89: reg_rtpaddy = `SUM_BITS'd28480;
			`HEIGHT_BITS'd90: reg_rtpaddy = `SUM_BITS'd28800;
			`HEIGHT_BITS'd91: reg_rtpaddy = `SUM_BITS'd29120;
			`HEIGHT_BITS'd92: reg_rtpaddy = `SUM_BITS'd29440;
			`HEIGHT_BITS'd93: reg_rtpaddy = `SUM_BITS'd29760;
			`HEIGHT_BITS'd94: reg_rtpaddy = `SUM_BITS'd30080;
			`HEIGHT_BITS'd95: reg_rtpaddy = `SUM_BITS'd30400;
			`HEIGHT_BITS'd96: reg_rtpaddy = `SUM_BITS'd30720;
			`HEIGHT_BITS'd97: reg_rtpaddy = `SUM_BITS'd31040;
			`HEIGHT_BITS'd98: reg_rtpaddy = `SUM_BITS'd31360;
			`HEIGHT_BITS'd99: reg_rtpaddy = `SUM_BITS'd31680;
			`HEIGHT_BITS'd100: reg_rtpaddy = `SUM_BITS'd32000;
			`HEIGHT_BITS'd101: reg_rtpaddy = `SUM_BITS'd32320;
			`HEIGHT_BITS'd102: reg_rtpaddy = `SUM_BITS'd32640;
			`HEIGHT_BITS'd103: reg_rtpaddy = `SUM_BITS'd32960;
			`HEIGHT_BITS'd104: reg_rtpaddy = `SUM_BITS'd33280;
			`HEIGHT_BITS'd105: reg_rtpaddy = `SUM_BITS'd33600;
			`HEIGHT_BITS'd106: reg_rtpaddy = `SUM_BITS'd33920;
			`HEIGHT_BITS'd107: reg_rtpaddy = `SUM_BITS'd34240;
			`HEIGHT_BITS'd108: reg_rtpaddy = `SUM_BITS'd34560;
			`HEIGHT_BITS'd109: reg_rtpaddy = `SUM_BITS'd34880;
			`HEIGHT_BITS'd110: reg_rtpaddy = `SUM_BITS'd35200;
			`HEIGHT_BITS'd111: reg_rtpaddy = `SUM_BITS'd35520;
			`HEIGHT_BITS'd112: reg_rtpaddy = `SUM_BITS'd35840;
			`HEIGHT_BITS'd113: reg_rtpaddy = `SUM_BITS'd36160;
			`HEIGHT_BITS'd114: reg_rtpaddy = `SUM_BITS'd36480;
			`HEIGHT_BITS'd115: reg_rtpaddy = `SUM_BITS'd36800;
			`HEIGHT_BITS'd116: reg_rtpaddy = `SUM_BITS'd37120;
			`HEIGHT_BITS'd117: reg_rtpaddy = `SUM_BITS'd37440;
			`HEIGHT_BITS'd118: reg_rtpaddy = `SUM_BITS'd37760;
			`HEIGHT_BITS'd119: reg_rtpaddy = `SUM_BITS'd38080;
			`HEIGHT_BITS'd120: reg_rtpaddy = `SUM_BITS'd38400;
			`HEIGHT_BITS'd121: reg_rtpaddy = `SUM_BITS'd38720;
			`HEIGHT_BITS'd122: reg_rtpaddy = `SUM_BITS'd39040;
			`HEIGHT_BITS'd123: reg_rtpaddy = `SUM_BITS'd39360;
			`HEIGHT_BITS'd124: reg_rtpaddy = `SUM_BITS'd39680;
			`HEIGHT_BITS'd125: reg_rtpaddy = `SUM_BITS'd40000;
			`HEIGHT_BITS'd126: reg_rtpaddy = `SUM_BITS'd40320;
			`HEIGHT_BITS'd127: reg_rtpaddy = `SUM_BITS'd40640;
			`HEIGHT_BITS'd128: reg_rtpaddy = `SUM_BITS'd40960;
			`HEIGHT_BITS'd129: reg_rtpaddy = `SUM_BITS'd41280;
			`HEIGHT_BITS'd130: reg_rtpaddy = `SUM_BITS'd41600;
			`HEIGHT_BITS'd131: reg_rtpaddy = `SUM_BITS'd41920;
			`HEIGHT_BITS'd132: reg_rtpaddy = `SUM_BITS'd42240;
			`HEIGHT_BITS'd133: reg_rtpaddy = `SUM_BITS'd42560;
			`HEIGHT_BITS'd134: reg_rtpaddy = `SUM_BITS'd42880;
			`HEIGHT_BITS'd135: reg_rtpaddy = `SUM_BITS'd43200;
			`HEIGHT_BITS'd136: reg_rtpaddy = `SUM_BITS'd43520;
			`HEIGHT_BITS'd137: reg_rtpaddy = `SUM_BITS'd43840;
			`HEIGHT_BITS'd138: reg_rtpaddy = `SUM_BITS'd44160;
			`HEIGHT_BITS'd139: reg_rtpaddy = `SUM_BITS'd44480;
			`HEIGHT_BITS'd140: reg_rtpaddy = `SUM_BITS'd44800;
			`HEIGHT_BITS'd141: reg_rtpaddy = `SUM_BITS'd45120;
			`HEIGHT_BITS'd142: reg_rtpaddy = `SUM_BITS'd45440;
			`HEIGHT_BITS'd143: reg_rtpaddy = `SUM_BITS'd45760;
			`HEIGHT_BITS'd144: reg_rtpaddy = `SUM_BITS'd46080;
			`HEIGHT_BITS'd145: reg_rtpaddy = `SUM_BITS'd46400;
			`HEIGHT_BITS'd146: reg_rtpaddy = `SUM_BITS'd46720;
			`HEIGHT_BITS'd147: reg_rtpaddy = `SUM_BITS'd47040;
			`HEIGHT_BITS'd148: reg_rtpaddy = `SUM_BITS'd47360;
			`HEIGHT_BITS'd149: reg_rtpaddy = `SUM_BITS'd47680;
			`HEIGHT_BITS'd150: reg_rtpaddy = `SUM_BITS'd48000;
			`HEIGHT_BITS'd151: reg_rtpaddy = `SUM_BITS'd48320;
			`HEIGHT_BITS'd152: reg_rtpaddy = `SUM_BITS'd48640;
			`HEIGHT_BITS'd153: reg_rtpaddy = `SUM_BITS'd48960;
			`HEIGHT_BITS'd154: reg_rtpaddy = `SUM_BITS'd49280;
			`HEIGHT_BITS'd155: reg_rtpaddy = `SUM_BITS'd49600;
			`HEIGHT_BITS'd156: reg_rtpaddy = `SUM_BITS'd49920;
			`HEIGHT_BITS'd157: reg_rtpaddy = `SUM_BITS'd50240;
			`HEIGHT_BITS'd158: reg_rtpaddy = `SUM_BITS'd50560;
			`HEIGHT_BITS'd159: reg_rtpaddy = `SUM_BITS'd50880;
			`HEIGHT_BITS'd160: reg_rtpaddy = `SUM_BITS'd51200;
			`HEIGHT_BITS'd161: reg_rtpaddy = `SUM_BITS'd51520;
			`HEIGHT_BITS'd162: reg_rtpaddy = `SUM_BITS'd51840;
			`HEIGHT_BITS'd163: reg_rtpaddy = `SUM_BITS'd52160;
			`HEIGHT_BITS'd164: reg_rtpaddy = `SUM_BITS'd52480;
			`HEIGHT_BITS'd165: reg_rtpaddy = `SUM_BITS'd52800;
			`HEIGHT_BITS'd166: reg_rtpaddy = `SUM_BITS'd53120;
			`HEIGHT_BITS'd167: reg_rtpaddy = `SUM_BITS'd53440;
			`HEIGHT_BITS'd168: reg_rtpaddy = `SUM_BITS'd53760;
			`HEIGHT_BITS'd169: reg_rtpaddy = `SUM_BITS'd54080;
			`HEIGHT_BITS'd170: reg_rtpaddy = `SUM_BITS'd54400;
			`HEIGHT_BITS'd171: reg_rtpaddy = `SUM_BITS'd54720;
			`HEIGHT_BITS'd172: reg_rtpaddy = `SUM_BITS'd55040;
			`HEIGHT_BITS'd173: reg_rtpaddy = `SUM_BITS'd55360;
			`HEIGHT_BITS'd174: reg_rtpaddy = `SUM_BITS'd55680;
			`HEIGHT_BITS'd175: reg_rtpaddy = `SUM_BITS'd56000;
			`HEIGHT_BITS'd176: reg_rtpaddy = `SUM_BITS'd56320;
			`HEIGHT_BITS'd177: reg_rtpaddy = `SUM_BITS'd56640;
			`HEIGHT_BITS'd178: reg_rtpaddy = `SUM_BITS'd56960;
			`HEIGHT_BITS'd179: reg_rtpaddy = `SUM_BITS'd57280;
			`HEIGHT_BITS'd180: reg_rtpaddy = `SUM_BITS'd57600;
			`HEIGHT_BITS'd181: reg_rtpaddy = `SUM_BITS'd57920;
			`HEIGHT_BITS'd182: reg_rtpaddy = `SUM_BITS'd58240;
			`HEIGHT_BITS'd183: reg_rtpaddy = `SUM_BITS'd58560;
			`HEIGHT_BITS'd184: reg_rtpaddy = `SUM_BITS'd58880;
			`HEIGHT_BITS'd185: reg_rtpaddy = `SUM_BITS'd59200;
			`HEIGHT_BITS'd186: reg_rtpaddy = `SUM_BITS'd59520;
			`HEIGHT_BITS'd187: reg_rtpaddy = `SUM_BITS'd59840;
			`HEIGHT_BITS'd188: reg_rtpaddy = `SUM_BITS'd60160;
			`HEIGHT_BITS'd189: reg_rtpaddy = `SUM_BITS'd60480;
			`HEIGHT_BITS'd190: reg_rtpaddy = `SUM_BITS'd60800;
			`HEIGHT_BITS'd191: reg_rtpaddy = `SUM_BITS'd61120;
			`HEIGHT_BITS'd192: reg_rtpaddy = `SUM_BITS'd61440;
			`HEIGHT_BITS'd193: reg_rtpaddy = `SUM_BITS'd61760;
			`HEIGHT_BITS'd194: reg_rtpaddy = `SUM_BITS'd62080;
			`HEIGHT_BITS'd195: reg_rtpaddy = `SUM_BITS'd62400;
			`HEIGHT_BITS'd196: reg_rtpaddy = `SUM_BITS'd62720;
			`HEIGHT_BITS'd197: reg_rtpaddy = `SUM_BITS'd63040;
			`HEIGHT_BITS'd198: reg_rtpaddy = `SUM_BITS'd63360;
			`HEIGHT_BITS'd199: reg_rtpaddy = `SUM_BITS'd63680;
			`HEIGHT_BITS'd200: reg_rtpaddy = `SUM_BITS'd64000;
			`HEIGHT_BITS'd201: reg_rtpaddy = `SUM_BITS'd64320;
			`HEIGHT_BITS'd202: reg_rtpaddy = `SUM_BITS'd64640;
			`HEIGHT_BITS'd203: reg_rtpaddy = `SUM_BITS'd64960;
			`HEIGHT_BITS'd204: reg_rtpaddy = `SUM_BITS'd65280;
			`HEIGHT_BITS'd205: reg_rtpaddy = `SUM_BITS'd65600;
			`HEIGHT_BITS'd206: reg_rtpaddy = `SUM_BITS'd65920;
			`HEIGHT_BITS'd207: reg_rtpaddy = `SUM_BITS'd66240;
			`HEIGHT_BITS'd208: reg_rtpaddy = `SUM_BITS'd66560;
			`HEIGHT_BITS'd209: reg_rtpaddy = `SUM_BITS'd66880;
			`HEIGHT_BITS'd210: reg_rtpaddy = `SUM_BITS'd67200;
			`HEIGHT_BITS'd211: reg_rtpaddy = `SUM_BITS'd67520;
			`HEIGHT_BITS'd212: reg_rtpaddy = `SUM_BITS'd67840;
			`HEIGHT_BITS'd213: reg_rtpaddy = `SUM_BITS'd68160;
			`HEIGHT_BITS'd214: reg_rtpaddy = `SUM_BITS'd68480;
			`HEIGHT_BITS'd215: reg_rtpaddy = `SUM_BITS'd68800;
			`HEIGHT_BITS'd216: reg_rtpaddy = `SUM_BITS'd69120;
			`HEIGHT_BITS'd217: reg_rtpaddy = `SUM_BITS'd69440;
			`HEIGHT_BITS'd218: reg_rtpaddy = `SUM_BITS'd69760;
			`HEIGHT_BITS'd219: reg_rtpaddy = `SUM_BITS'd70080;
			`HEIGHT_BITS'd220: reg_rtpaddy = `SUM_BITS'd70400;
			`HEIGHT_BITS'd221: reg_rtpaddy = `SUM_BITS'd70720;
			`HEIGHT_BITS'd222: reg_rtpaddy = `SUM_BITS'd71040;
			`HEIGHT_BITS'd223: reg_rtpaddy = `SUM_BITS'd71360;
			`HEIGHT_BITS'd224: reg_rtpaddy = `SUM_BITS'd71680;
			`HEIGHT_BITS'd225: reg_rtpaddy = `SUM_BITS'd72000;
			`HEIGHT_BITS'd226: reg_rtpaddy = `SUM_BITS'd72320;
			`HEIGHT_BITS'd227: reg_rtpaddy = `SUM_BITS'd72640;
			`HEIGHT_BITS'd228: reg_rtpaddy = `SUM_BITS'd72960;
			`HEIGHT_BITS'd229: reg_rtpaddy = `SUM_BITS'd73280;
			`HEIGHT_BITS'd230: reg_rtpaddy = `SUM_BITS'd73600;
			`HEIGHT_BITS'd231: reg_rtpaddy = `SUM_BITS'd73920;
			`HEIGHT_BITS'd232: reg_rtpaddy = `SUM_BITS'd74240;
			`HEIGHT_BITS'd233: reg_rtpaddy = `SUM_BITS'd74560;
			`HEIGHT_BITS'd234: reg_rtpaddy = `SUM_BITS'd74880;
			`HEIGHT_BITS'd235: reg_rtpaddy = `SUM_BITS'd75200;
			`HEIGHT_BITS'd236: reg_rtpaddy = `SUM_BITS'd75520;
			`HEIGHT_BITS'd237: reg_rtpaddy = `SUM_BITS'd75840;
			`HEIGHT_BITS'd238: reg_rtpaddy = `SUM_BITS'd76160;
			`HEIGHT_BITS'd239: reg_rtpaddy = `SUM_BITS'd76480;
		endcase
	end
endmodule
