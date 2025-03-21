`timescale 1ns / 1ps

module FIRFilterS25_tb;
    
    reg clk;
    reg reset;
    reg signed [23:0] inputData1;
    reg signed [23:0] inputData2;
    reg signed [23:0] inputData3;
    wire signed [23:0] outputData1;
    wire signed [23:0] outputData2;
    wire signed [23:0] outputData3;

    // Instantiate the FIR filter module
    FIRFilterS25 uut (
        .clk(clk),
        .reset(reset),
        .inputData1(inputData1),
        .inputData2(inputData2),
        .inputData3(inputData3),
        .outputData1(outputData1),
        .outputData2(outputData2),
        .outputData3(outputData3)
    );
    
    // Clock generation (50 MHz)
    always #10 clk = ~clk;  // 20 ns period -> 50 MHz
    
    // LUT-based sine wave input generation (16 samples per cycle)
    reg signed [23:0] sine_wave [0:15];
    integer i = 0;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        inputData1 = 0;
        inputData2 = 0;
        inputData3 = 0;

        // Define a 16-sample sine wave lookup table (scaled by 2^22 for 24-bit precision)
        sine_wave[0]  =  24'd0;
        sine_wave[1]  =  24'd4194304;
        sine_wave[2]  =  24'd7414554;
        sine_wave[3]  =  24'd9637853;
        sine_wave[4]  =  24'd10737418;
        sine_wave[5]  =  24'd9637853;
        sine_wave[6]  =  24'd7414554;
        sine_wave[7]  =  24'd4194304;
        sine_wave[8]  =  24'd0;
        sine_wave[9]  = -24'd4194304;
        sine_wave[10] = -24'd7414554;
        sine_wave[11] = -24'd9637853;
        sine_wave[12] = -24'd10737418;
        sine_wave[13] = -24'd9637853;
        sine_wave[14] = -24'd7414554;
        sine_wave[15] = -24'd4194304;

        // Apply reset for a few cycles
        #50;
        reset = 0;
        
        // Apply sine wave to input data
        for (i = 0; i < 64; i = i + 1) begin
            #20 inputData1 = sine_wave[i % 16];  // Cycle through sine LUT
            #20 inputData2 = sine_wave[(i + 5) % 16];  // Shifted sine for second input
            #20 inputData3 = sine_wave[(i + 10) % 16]; // Shifted sine for third input
        end
        
        // Let the simulation run for some time
        #1000000;
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time = %0t | inputData1 = %d | inputData2 = %d | inputData3 = %d | outputData1 = %d | outputData2 = %d | outputData3 = %d", 
                  $time, inputData1, inputData2, inputData3, outputData1, outputData2, outputData3);
    end

endmodule

//`timescale 1ns / 1ps
//
//module FIRFilterS25_tb;
//    
//	 reg clk;
//    reg reset;
//    reg signed [23:0] inputData1;
//    reg signed [23:0] inputData2;
//	 reg signed [23:0] inputData3;
//    wire signed [23:0] outputData1;
//    wire signed [23:0] outputData2;
//    wire signed [23:0] outputData3;
//
//    // Instantiate the FIR filter module
//    FIRFilterS25 uut (
//        .clk(clk),
//        .reset(reset),
//        .inputData1(inputData1),
//        .inputData2(inputData2),
//        .inputData3(inputData3),
//        .outputData1(outputData1),
//        .outputData2(outputData2),
//        .outputData3(outputData3)
//    );
//    
//    // Clock generation (50 MHz)
//    always #10 clk = ~clk;  // 20 ns period -> 50 MHz
//    
//    initial begin
//        // Initialize signals
//        clk = 0;
//        reset = 1;
//        inputData1 = 0;
//		  inputData2 = 0;
//		  inputData3 = 0;
//
//        // Apply reset for a few cycles
//        #50;
//        reset = 0;
//        
//        repeat(33) begin
//			   #20 inputData1 = 24'd1;
//			   #20 inputData2 = 24'd1;
//			   #20 inputData3 = 24'd1;
//	
//        end
//		#1000000;
//      $finish;
//    end
//    
//    // Monitor output
//    initial begin
//        $monitor("Time = %0t | inputData1 = %d | inputData2 = %d | inputData3 = %d | outputData1 = %d | outputData2 = %d | outputData3 = %d", $time, inputData1, inputData2, inputData3, outputData1, outputData2, outputData3);
//    end
//    
//endmodule