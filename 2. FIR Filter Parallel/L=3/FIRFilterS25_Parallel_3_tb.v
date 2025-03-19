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
    
    always #10 clk = ~clk;
    
    initial begin
        clk = 0;
        reset = 1;
        inputData1 = 0;
		  inputData2 = 0;
		  inputData3 = 0;

        #50;
        reset = 0;
        
        repeat(33) begin
			   #20 inputData1 = 24'd1;
			   #20 inputData2 = 24'd1;
			   #20 inputData3 = 24'd1;
	
        end
        #10000;
        $finish;
    end
    
    initial begin
        $monitor("Time = %0t | inputData1 = %d | inputData2 = %d | inputData3 = %d | outputData1 = %d | outputData2 = %d | outputData3 = %d", $time, inputData1, inputData2, inputData3, outputData1, outputData2, outputData3);
    end
    
endmodule