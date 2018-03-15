module waveform_generator(
	output logic [23:0] waveOut,
	//input wire [2:0] frequency,
	//input wire amplitude,
	input wire Clock, nReset
);


logic [2:0] phase;


logic [(8*8)-1:0] sine_lut;

always_ff @ (
	posedge Clock,
	negedge nReset) begin
	
	if(!nReset) begin
		phase <= 'b0;
		
		// TEMP - LUT
		sine_lut[(8*1)-1:(8*0)] <= 0;
		sine_lut[(8*2)-1:(8*1)] <= 78;
		sine_lut[(8*3)-1:(8*2)] <= 97;
		sine_lut[(8*4)-1:(8*3)] <= 43;
		sine_lut[(8*5)-1:(8*4)] <= -43;
		sine_lut[(8*6)-1:(8*5)] <= -97;
		sine_lut[(8*7)-1:(8*6)] <= -78;
		sine_lut[(8*8)-1:(8*7)] <= -0;
		
	end
	else begin
		phase <= phase + 1;//frequency;
	end	
end

//assign waveOut = sine_lut[(((phase + 1) * 8)-1):(phase*8)] * 10;//amplitude;

always_comb begin
	case(phase)
		0: waveOut = sine_lut[(8*1)-1:(8*0)];
		1: waveOut = sine_lut[(8*2)-1:(8*1)];
		2: waveOut = sine_lut[(8*3)-1:(8*2)];
		3: waveOut = sine_lut[(8*4)-1:(8*3)];
		4: waveOut = sine_lut[(8*5)-1:(8*4)];
		5: waveOut = sine_lut[(8*6)-1:(8*5)];
		6: waveOut = sine_lut[(8*7)-1:(8*6)];
		7: waveOut = sine_lut[(8*8)-1:(8*7)];
	endcase

end

endmodule