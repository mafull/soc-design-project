module gesture_av(
	output logic [6:0] segments,
	input wire button,
	input wire Clock, nReset
);


typedef enum logic {BUTTON_ON, BUTTON_OFF} button_state_t;
button_state_t prevButtonState;


logic [3:0] count;


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


seven_segment seg1(
	segments,
	count
);

endmodule