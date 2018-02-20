module testbench;

wire [6:0] segments;
wire [6:0] volumeLEDs;
wire [6:0] frequencySegments [2];

logic button, Clock, nReset;

gesture_av tl(
	segments,
	volumeLEDs,
	frequencySegments,
	button,
	Clock, nReset
);


initial begin
	button = 1;
	Clock = 0;
	nReset = 1;

	#200

	nReset = 0;
	#1000 nReset = 1;
	
	#2000 button = 0;
	#1000 button = 1;
	#2000 button = 0;
	#1000 button = 1;
	#2000 button = 0;
	#1000 button = 1;

	$stop;
	$finish;

end

always #500 Clock = ~Clock;

endmodule