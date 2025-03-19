# FIR-Filter-VLSI-Design

This repository contains the design, implementation, and analysis of a **Finite Impulse Response (FIR) filter** for **ECSE 6680 - Advanced VLSI Design**. The project includes **MATLAB simulations**, **Verilog hardware implementation**, and **FPGA synthesis results using Quartus**.

## Project Overview
This project focuses on designing and implementing an **FIR filter** with **99 taps**, optimized for efficient hardware realization.

## Matlab Filter Design: MATLAB Coefficient Calculations & Quantization

1. **Unquantized Coefficient Magnitude and Phase Response**  
   ![Unquantized Magnitude Response](https://github.com/user-attachments/assets/afe96a06-a256-4c57-88d4-1a3d17840e85)

   ![Unquantized Phase Response](https://github.com/user-attachments/assets/07f730af-1268-4c5a-b5ea-aecd9cae9750)

2. **Quantized Coefficient Magnitude and Phase Response**  

    ![Quantized Magnitude Response](https://github.com/user-attachments/assets/75938ff6-e1bc-42b9-a0ea-d166a581ed9f)

    ![Unquantized Phase Response](https://github.com/user-attachments/assets/8323348a-8ef8-47c6-9e7c-17d4224a06e8)


4. Graph Interpretation

[]

## FIR Filter VLSI Architecture Explanation

3 Different Architectures are explored:
1. Pipelined
2. Parallel (L=3) and (L=4)
3. Combined Parallel and Pipeline (L=3)

## Testing Using ModelSim and Results

[]

## References
[1]“Parks-McClellan Bandpass Filter,” Mathworks.com, 2025. https://www.mathworks.com/help/signal/ref/firpm.html#mw_a610b0ff-bc10-4a9f-8b0b-188c89429bc3 (accessed Mar. 15, 2025).
[2]“Parks-McClellan optimal FIR filter order estimation - MATLAB firpmord,” www.mathworks.com. https://www.mathworks.com/help/signal/ref/firpmord.html
