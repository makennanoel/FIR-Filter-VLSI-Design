//PARALLEL IMPLEMENTATION
//L=2 and (L=3)
module FIRFilterS25 (
	input clk,
	input reset,
	input signed [23:0] inputData1,
	input signed [23:0] inputData2,
	input signed [23:0] inputData3,
	output reg signed [23:0] outputData1,
	output reg signed [23:0] outputData2,
	output reg signed [23:0] outputData3

);
	
	//Create coefficients 
	reg signed [23:0] coeffs [0:99];//Creation of 100 Taps with 24 bits each
	
	//Shift Registers for Stage 1
	reg signed [23:0] shift_register_stage1 [0:49];
	reg signed [23:0] shift_register_stage2 [0:49];
	reg signed [23:0] shift_register_stage3 [0:49];

	
	//Registers for Stage 2 (24 bits x 2 = 48 bits)
	reg signed [32:0] multiply_stage1[0:49];//contains all of our products
	reg signed [32:0] multiply_stage2[0:49];//contains all of our products
	reg signed [32:0] multiply_stage3[0:49];//contains all of our products
	
	//Registers for Stage 3
	reg signed [32:0] sum1;
	reg signed [32:0] sum2;
   reg signed [32:0] sum3;

	
	//counter to keep track of which state we are on
	reg [7:0] counter; // Use reg to store state across cycles
	reg [7:0] index;

	
	//Final Output Register for Stage 4
	
	initial begin
		$readmemb("C:\\Users\\Makenna\\Documents\\Spring 2025\\Advanced VLSI\\FIR Filter Project\\coeffs.mem", coeffs); // Read coefficients from file
	end
	
	 parameter IDLE = 2'b00, SHIFT = 2'b01, MULTIPLY = 2'b10, SUM = 2'b11, OUTPUT = 2'b100, RESET = 2'b101;
	 reg [1:0] state;
	
	//STAGE 1
    integer i;

    always @(posedge clk or posedge reset) 
	 begin
        if (reset) 
		  begin
            // Reset all internal registers
            for (i = 0; i < 50; i = i + 1) begin
                shift_register_stage1[i] <= 0;
                multiply_stage1[i] <= 0;
					 
                shift_register_stage2[i] <= 0;
                multiply_stage2[i] <= 0;
					 
                shift_register_stage3[i] <= 0;
                multiply_stage3[i] <= 0;
            end
				outputData1 <= 0;
				outputData2 <= 0;
				outputData3 <= 0;												
						
				counter <= 0;
				sum1 <= 0;
				sum2 <= 0;
				sum3 <= 0;

				state <= IDLE;
        end else 
		  begin
				case (state)
					// Stage 1: Shift Register
					
					IDLE:
					begin
						if (counter < 33)
						begin
							state <= SHIFT;
						end
						else
						begin
							state <= IDLE;
						end
					end
					
					SHIFT: 
					begin
						
							for (i = 1; i < 32; i = i + 1) 
							begin
								shift_register_stage1[i] <= shift_register_stage1[i-1];
								shift_register_stage2[i] <= shift_register_stage2[i-1];
								shift_register_stage3[i] <= shift_register_stage3[i-1];
							end
					
							shift_register_stage1[0] <= inputData1;
							shift_register_stage2[0] <= inputData2;
							shift_register_stage3[0] <= inputData3;

						state <= MULTIPLY;
					end
					
					MULTIPLY:
					begin
						// Stage 2: Multiply			  
						//Multiply the previous data inputs of both by its coefficient
						outputData1 <= outputData1 + shift_register_stage1[0] * coeffs[counter*3];
						outputData2 <= outputData2 + shift_register_stage2[0] * coeffs[counter*3+1];
						outputData3 <= outputData3 + shift_register_stage3[0] * coeffs[counter*3+2];												
						
						if (counter == 32)
						begin
							state <= IDLE;
						end
						else
						begin
							counter <= counter + 1;//Increment Counter
							state <= SHIFT;
						end
					end
				endcase
        end
    end
endmodule