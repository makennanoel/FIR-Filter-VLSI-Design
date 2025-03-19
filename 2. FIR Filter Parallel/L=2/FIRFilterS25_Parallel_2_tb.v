`timescale 1ns / 1ps

module FIRFilterS25_tb;
    
	 reg clk;
    reg reset;
    reg signed [23:0] inputData1;
    reg signed [23:0] inputData2;
    wire signed [23:0] outputData1;
    wire signed [23:0] outputData2;
	 wire signed [47:0] sum_even;
	 wire signed [47:0] sum_odd;

    // Instantiate the FIR filter module
    FIRFilterS25 uut (
        .clk(clk),
        .reset(reset),
        .inputData1(inputData1),
        .inputData2(inputData2),
        .outputData1(outputData1),
        .outputData2(outputData2),
		  .sum_even(sum_even),
		  .sum_odd(sum_odd)
    );
    
    // Clock generation (50 MHz)
    always #10 clk = ~clk;  // 20 ns period -> 50 MHz
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        inputData1 = 0;
		  inputData2 = 0;
        
        // Apply reset for a few cycles
        #50;
        reset = 0;
        
        repeat(12) begin // Repeat 12 times to get 96 values (close to 100
			   #20 inputData1 = 24'd1;
			   #20 inputData2 = 24'd1;
			   #20 inputData1 = 24'd1;
			   #20 inputData2 = 24'd1;
				#20 inputData1 = 24'd1;
            #20 inputData2 = 24'd1;
            #20 inputData1 = 24'd1;
            #20 inputData2 = 24'd1;
            #20 inputData1 = 24'd1;
            #20 inputData2 = 24'd1;

        end
        // Let the simulation run for some time
        #10000;
        
        // Finish simulation
        $finish;
    end
    
    // Monitor output
    initial begin
        $monitor("Time = %0t | inputData1 = %d | inputData2 = %d | sum_even = %d | sum_odd = %d | outputData1 = %d | outputData2 = %d", $time, inputData1, inputData2, sum_even, sum_odd, outputData1, outputData2);
    end
    
endmodule