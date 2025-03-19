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
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        inputData = 0;
        
        #50;
        reset = 0;
        
        #20 inputData = 24'd1;
        #20 inputData = 24'd1;
        #20 inputData = 24'd1;
        #20 inputData = 24'd1;
        
        repeat(12) begin
            #20 inputData = 24'd1;
            #20 inputData = 24'd1;
            #20 inputData = 24'd1;
            #20 inputData = 24'd1;
            #20 inputData = 24'd1;
            #20 inputData = 24'd1;
            #20 inputData = 24'd1;
            #20 inputData = 24'd1;
        end

        #10000;
        
        $finish;
    end
    
    initial begin
        $monitor("Time = %0t | inputData = %d | sum_stage = %d | outputData = %d", $time, inputData, sum_stage, outputData);
    end
    
endmodule