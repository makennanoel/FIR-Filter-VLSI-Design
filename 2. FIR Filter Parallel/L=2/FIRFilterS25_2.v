//PARALLEL IMPLEMENTATION
//(L=2) and L =3
module FIRFilterS25 (
	input clk,
	input reset,
	input signed [23:0] inputData1,
	input signed [23:0] inputData2,
	output reg signed [23:0] outputData1,
	output reg signed [23:0] outputData2,
	output reg signed [47:0] sum_even,
	output reg signed [47:0] sum_odd
);
	
	//Create coefficients 
	reg signed [23:0] coeffs [0:99];//Creation of 100 Taps with 24 bits each
	
	//Shift Registers for Stage 1
	reg signed [23:0] shift_register_stage_even [0:49];
	reg signed [23:0] shift_register_stage_odd [0:49];

	
	//Registers for Stage 2 (24 bits x 2 = 48 bits)
	reg signed [47:0] multiply_stage_even[0:49];//contains all of our products
	reg signed [47:0] multiply_stage_odd[0:49];//contains all of our products

	
	//Registers for Stage 3
	
	//counter to keep track of which state we are on
	reg [7:0] counter; // Use reg to store state across cycles
	reg [7:0] index;

	
	//Final Output Register for Stage 4
	
	initial begin
		$readmemb("C:\\Users\\Makenna\\Documents\\Spring 2025\\Advanced VLSI\\FIR Filter Project\\coeffs.mem", coeffs); // Read coefficients from file
	end
	
	 parameter IDLE = 3'b000, SHIFT = 3'b001, MULTIPLY = 3'b010, SUM = 3'b011, OUTPUT = 3'b100, RESET = 3'b101;
	 reg [2:0] state;
	
	//STAGE 1
    integer i;
	
	

    always @(posedge clk or posedge reset) 
	 begin
        if (reset) 
		  begin
			
			   //$display("reset flag");

            // Reset all internal registers
            for (i = 0; i < 50; i = i + 1) begin
                shift_register_stage_even[i] <= 0;
                multiply_stage_even[i] <= 0;
                shift_register_stage_odd[i] <= 0;
                multiply_stage_odd[i] <= 0;
            end
				
				counter <= 0;
				sum_even <= 0;
				sum_odd <= 0;
				outputData1 <= 0;//Add up both sums
				outputData2 <= 0;
				state <= IDLE;
        end else 
		  begin
				case (state)
					// Stage 1: Shift Register
					
					IDLE:
					begin
					
						//$display("idle flag");
						if (counter < 50)
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
						//$display("shift flag");

							for (i = 1; i < 49; i = i + 1) 
							begin
									shift_register_stage_even[i] <= shift_register_stage_even[i-1];
									shift_register_stage_odd[i] <= shift_register_stage_odd[i-1];
							end
					
							shift_register_stage_even[0] <= inputData1;
							shift_register_stage_odd[0] <= inputData2;
						state <= MULTIPLY;
					end
					
					MULTIPLY:
					begin
						//$display("multiply flag");
						// Stage 2: Multiply			  
						//Multiply the previous data inputs of both by its coefficient
						multiply_stage_even[counter] <= shift_register_stage_even[0] * coeffs[counter*2];
						multiply_stage_odd[counter] <= shift_register_stage_odd[0] * coeffs[counter*2+1];	
						//$display("Time=%0t | shift_register_stage_odd[0]=%d | coeffs[counter*2+1] = %d| inputData2 = %d", $time, shift_register_stage_odd[0], coeffs[counter*2+1], inputData2);
						
						outputData1 <= outputData1 + shift_register_stage_even[0] * coeffs[counter*2]; 
						outputData2 <= outputData2 + shift_register_stage_odd[0] * coeffs[counter*2+1]; 
						
						if (counter == 49)
						begin
							state <= IDLE;
						end
						else
						begin
							counter <= counter + 1;//Increment Counter
							state <= SHIFT;
						end
						//state <= OUTPUT;
					end
					endcase
        end
    end
endmodule