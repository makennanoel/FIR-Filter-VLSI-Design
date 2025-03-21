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

    // FIR filter coefficients
    reg signed [23:0] coeffs [0:99];

    // Shift registers for three parallel input streams
    reg signed [23:0] shift_register_stage1[0:32];
    reg signed [23:0] shift_register_stage2[0:32];
    reg signed [23:0] shift_register_stage3[0:32];

    // Registers for intermediate sums
    reg signed [47:0] sum_stage1, sum_stage2, sum_stage3;

    // Counter for tracking processing stage
    reg [7:0] counter;
    integer i;

    initial begin
        $readmemb("C:\\Users\\Makenna\\Documents\\Spring 2025\\Advanced VLSI\\FIR Filter Project\\coeffs.mem", coeffs);
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                shift_register_stage1[i] <= 0;
                shift_register_stage2[i] <= 0;
                shift_register_stage3[i] <= 0;
            end
				
        end else begin
            // Shift registers update
				if (counter < 32) 
				begin
					for (i = 32; i > 0; i = i - 1) begin
						 shift_register_stage1[i] <= shift_register_stage1[i-1];
						 shift_register_stage2[i] <= shift_register_stage2[i-1];
						 shift_register_stage3[i] <= shift_register_stage3[i-1];
					end
					shift_register_stage1[0] <= inputData1;
					shift_register_stage2[0] <= inputData2;
					shift_register_stage3[0] <= inputData3;
				end
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sum_stage1 <= 0;
            sum_stage2 <= 0;
            sum_stage3 <= 0;
        end else begin
            // Multiply and accumulate for each parallel path
				
				if (counter == 1)
				begin
					sum_stage1 <= shift_register_stage1[1] * coeffs[0];
					sum_stage2 <= shift_register_stage2[1] * coeffs[1];
					sum_stage3 <= shift_register_stage3[1] * coeffs[2];
					end else
				if (counter > 1 && counter < 32)
				begin					
					sum_stage1 <= sum_stage1 + shift_register_stage1[1] * coeffs[counter*3];
					sum_stage2 <= sum_stage2 + shift_register_stage2[1] * coeffs[counter*3+1];
					sum_stage3 <= sum_stage3 + shift_register_stage3[1] * coeffs[counter*3+2];
				end
				
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            outputData1 <= 0;
            outputData2 <= 0;
            outputData3 <= 0;
				counter <= 0;
        end else begin
            // Assign outputs from accumulated sums
					outputData1 <= sum_stage1;
					outputData2 <= sum_stage2;
					outputData3 <= sum_stage3;
				if (counter < 32)
				begin
					counter <= counter + 1;
				end
        end
    end

endmodule