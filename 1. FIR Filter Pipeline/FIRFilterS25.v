//PIPELINED IMPLEMENTATION
module FIRFilterS25 (
	input clk,
	input reset,
	input signed [23:0] inputData,
	output reg signed [23:0] outputData,
	output reg signed [47:0] sum_stage

);

	
	//Create coefficients 
	reg signed [23:0] coeffs [0:99];//Creation of 100 Taps with 24 bits each
	
	//Shift Registers for Stage 1
	reg signed [23:0] shift_register_stage[0:99];
	
	//Registers for Stage 
	reg signed [23:0] register_sum_stage[0:99];
	reg signed [23:0] finalizedSum;

	
	//counter to keep track of which state we are on
	reg [7:0] counter; // Use reg to store state across cycles

	
	initial 
	begin
		$readmemb("C:\\Users\\Makenna\\Documents\\Spring 2025\\Advanced VLSI\\FIR Filter Project\\coeffs.mem", coeffs); // Read coefficients from file
	end
	  
	  
	 integer i;

    always @(posedge clk or posedge reset) 
	 begin
        if (reset) 
		  begin
            // Reset all internal registers
            for (i = 0; i < 100; i = i + 1) 
				begin
                shift_register_stage[i] <= 0;
            end
        end 
		  else 
		  begin
            // Stage 1: Shift Register
				if (counter < 100) 
				begin
					for (i = 1; i < 100; i = i + 1) 
					begin
						 shift_register_stage[i] <= shift_register_stage[i - 1];
					end
					shift_register_stage[0] <= inputData;

				end
		  end
	  end

    always @(posedge clk or posedge reset) 
	 begin
            // Multiplication & Summation
			if (reset) begin
				  sum_stage <= 0;
            for (i = 0; i < 100; i = i + 1) 
				begin
					 register_sum_stage[i] <= 0;
            end
			 end else 
			 begin
				if (counter == 1)
				begin
					register_sum_stage[0] <= shift_register_stage[1] * coeffs[0];
					sum_stage <= register_sum_stage[counter-1];
				end else
				if (counter > 1 && counter < 100)
				begin
					register_sum_stage[counter-1] <= register_sum_stage[counter-2] + shift_register_stage[1] * coeffs[counter-1];
					sum_stage <= register_sum_stage[counter-1];
				end
			end
	 end
				
    always @(posedge clk or posedge reset) 
	 begin
			if (reset) begin
				  counter <= 0;
				  outputData <= 0;
				  finalizedSum <=0;
			 end else 
			 begin
					if (counter == 99)
					begin
						outputData <= register_sum_stage[counter-1] + shift_register_stage[0] * coeffs[counter];
					end
					else
					begin
						counter <= counter + 1'b1;
					   $display("Counter Value: counter = %d", counter);

					end
			 end
	 end
endmodule