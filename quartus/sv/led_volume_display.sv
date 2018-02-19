module led_volume_display(
		output logic [6:0] leds,
		input logic [2:0] volume
);

always_comb begin
	case(volume)
		0:	leds = 7'b0000000;
		1:	leds = 7'b0000001;
		2:	leds = 7'b0000011;
		3:	leds = 7'b0000111;
		4:	leds = 7'b0001111;
		5:	leds = 7'b0011111;
		6:	leds = 7'b0111111;
		7:	leds = 7'b1111111;
	endcase
end

endmodule