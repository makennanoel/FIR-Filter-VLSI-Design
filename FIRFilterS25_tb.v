

//`timescale 1ns/1ps
//
//module FIRFilterS25_tb;
//
//    reg clk;
//    reg reset;
//    reg signed [23:0] inputData;
//    wire signed [23:0] outputData;
//    wire signed [47:0] sum_stage;
//
//    // Instantiate the FIR filter module
//    FIRFilterS25 uut (
//        .clk(clk),
//        .reset(reset),
//        .inputData(inputData),
//        .outputData(outputData),
//        .sum_stage(sum_stage)
//    );
//
//    // Clock generation (50 MHz)
//    always #10 clk = ~clk;  // 20 ns period -> 50 MHz
//
//    // LUT-based sine wave input generation (16 samples per cycle)
//    reg signed [23:0] sine_wave [0:15];
//    integer i = 0;
//
//    initial begin
//        // Initialize signals
//        clk = 0;
//        reset = 1;
//        inputData = 0;
//
//        // Define a 16-sample sine wave lookup table (scaled by 2^22 for 24-bit precision)
//        sine_wave[0]  =  24'd0;
//        sine_wave[1]  =  24'd4194304;
//        sine_wave[2]  =  24'd7414554;
//        sine_wave[3]  =  24'd9637853;
//        sine_wave[4]  =  24'd10737418;
//        sine_wave[5]  =  24'd9637853;
//        sine_wave[6]  =  24'd7414554;
//        sine_wave[7]  =  24'd4194304;
//        sine_wave[8]  =  24'd0;
//        sine_wave[9]  = -24'd4194304;
//        sine_wave[10] = -24'd7414554;
//        sine_wave[11] = -24'd9637853;
//        sine_wave[12] = -24'd10737418;
//        sine_wave[13] = -24'd9637853;
//        sine_wave[14] = -24'd7414554;
//        sine_wave[15] = -24'd4194304;
//
//        // Apply reset for a few cycles
//        #50;
//        reset = 0;
//
//        // Apply sine wave to input data
//        for (i = 0; i < 64; i = i + 1) begin
//            #20 inputData = sine_wave[i % 16];  // Cycle through sine LUT
//        end
//        
//        // Let the simulation run for some time
//        #1000000;
//        $finish;
//    end
//
//    // Monitor output
//    initial begin
//        $monitor("Time = %0t | inputData = %d | sum_stage = %d | outputData = %d", 
//                  $time, inputData, sum_stage, outputData);
//    end
//
//endmodule

//`timescale 1ns/1ps
//
//module FIRFilterS25_tb;
//
//    reg clk;
//    reg reset;
//    reg signed [23:0] inputData;
//    wire signed [23:0] outputData;
//	 wire signed [47:0] sum_stage;
//
//    FIRFilterS25 uut (
//        .clk(clk),
//        .reset(reset),
//        .inputData(inputData),
//        .outputData(outputData),
//		  .sum_stage(sum_stage)
//    );
//    
//    always #10 clk = ~clk;
//    
//    initial begin
//        clk = 0;
//        reset = 1;
//        inputData = 0;
//        
//        #50;
//        reset = 0;
//        
//        #20 inputData = 24'd0;
//        #20 inputData = 24'd10;
//        #20 inputData = 24'd20;
//        #20 inputData = 24'd30;
//        
//        repeat(12) begin
//            #20 inputData = 24'd20;
//            #20 inputData = 24'd10;
//            #20 inputData = 24'd0;
//            #20 inputData = 24'd10;
//            #20 inputData = 24'd20;
//            #20 inputData = 24'd30;
//            #20 inputData = 24'd20;
//            #20 inputData = 24'd10;
//        end
//
//        #10000;
//        
//        $finish;
//    end
//    
//    initial begin
//        $monitor("Time = %0t | inputData = %d | sum_stage = %d | outputData = %d", $time, inputData, sum_stage, outputData);
//    end
//    
//endmodule

//`timescale 1ns/1ps
//
//module FIRFilterS25_tb;
//
//    reg clk;
//    reg reset;
//    reg signed [23:0] inputData;
//    wire signed [23:0] outputData;
//    wire signed [47:0] sum_stage;
//
//    FIRFilterS25 uut (
//        .clk(clk),
//        .reset(reset),
//        .inputData(inputData),
//        .outputData(outputData),
//        .sum_stage(sum_stage)
//    );
//    
//    always #10 clk = ~clk; // 50MHz clock (20ns period)
//    
//    integer i;
//    real pi = 3.141592653589793;
//    real freq = 1.0 / 40.0; // Adjust frequency based on your sampling
//    real amplitude = 2**22; // Scale to match 24-bit fixed point
//
//    initial begin
//        clk = 0;
//        reset = 1;
//        inputData = 0;
//
//        #50;
//        reset = 0;
//
//        // Generate a sine wave input for 1000 cycles
//        for (i = 0; i < 1000; i = i + 1) begin
//            inputData = $rtoi(amplitude * $sin(2 * pi * freq * i)); // Convert real to integer
//            #20; // Sample every 20ns (50MHz)
//        end
//
//        #10000;
//        
//        $finish;
//    end
//    
//    initial begin
//        $monitor("Time = %0t | inputData = %d | sum_stage = %d | outputData = %d", $time, inputData, sum_stage, outputData);
//    end
//
//endmodule

`timescale 1ns/1ps

module FIRFilterS25_tb;

    reg clk;
    reg reset;
    reg signed [23:0] inputData;
    wire signed [23:0] outputData;
    wire signed [47:0] sum_stage;

    FIRFilterS25 uut (
        .clk(clk),
        .reset(reset),
        .inputData(inputData),
        .outputData(outputData),
        .sum_stage(sum_stage)
    );
    
    always #10 clk = ~clk; // 50 MHz clock (20 ns period)
    
    integer i;
    real pi = 3.141592653589793;
    real Fs = 50000000.0;   // 50 MHz sampling frequency
    real f = 215.0;         // Match MATLAB passband frequency (215 Hz)
    real freq = 0.0000043;     // Normalize to clock
    real amplitude = 2**22; // Scale to 24-bit fixed point

    initial begin
        clk = 0;
        reset = 1;
        inputData = 0;

        #50;
        reset = 0;

        // Generate a sine wave input for 1000 cycles
        for (i = 0; i < 1000; i = i + 1) begin
            inputData = $rtoi(amplitude * $sin(2 * pi * freq * i)); // Convert real to integer
            #20; // Sample every 20ns (50MHz clock)
        end

        #10000;
        
        $finish;
    end
    
    initial begin
        $monitor("Time = %0t | inputData = %d | sum_stage = %d | outputData = %d", 
                 $time, inputData, sum_stage, outputData);
    end

endmodule
