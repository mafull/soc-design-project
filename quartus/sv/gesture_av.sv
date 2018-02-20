module gesture_av(
	output wire [6:0] segments,
	output wire [6:0] volumeLEDs,
	output wire [6:0] frequencySegments [2],
	input wire button,
	input wire Clock, nReset
);


typedef enum logic {BUTTON_ON, BUTTON_OFF} button_state_t;
button_state_t prevButtonState;


logic [3:0] count;
logic [2:0] volume;


always_ff @ (
	posedge Clock,
	negedge nReset) begin
	
	if(!nReset) begin
		count <= 0;
		prevButtonState <= BUTTON_OFF;
	end
	else begin
		if(prevButtonState == BUTTON_OFF) begin
			if(!button) begin
				count <= count + 4'b1;
				prevButtonState <= BUTTON_ON;
			end
			else begin
				count <= count;
				prevButtonState <= BUTTON_OFF;
			end
		end
		else begin
			prevButtonState <= !button ? BUTTON_ON : BUTTON_OFF;
			count <= count;
		end
	end
end


assign volume = count % 8;


seven_segment seg1(
	segments,
	count
);

led_volume_display vol_disp(
	volumeLEDs,
	volume
);

seg_frequency_display freq_disp(
	frequencySegments,
	{count,~count}
);

endmodule