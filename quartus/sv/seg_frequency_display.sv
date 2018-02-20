module seg_frequency_display(
	output wire [6:0] segments [2],
	input wire [7:0] frequency
);


seven_segment seg0(
	segments[0],
	frequency[3:0]
);

seven_segment seg1(
	segments[1],
	frequency[7:4]
);


endmodule