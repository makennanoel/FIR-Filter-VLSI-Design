# FIR-Filter-VLSI-Design

This repository contains the design, implementation, and analysis of a **Finite Impulse Response (FIR) filter** for **ECSE 6680 - Advanced VLSI Design**. The project includes **MATLAB simulations**, **Verilog hardware implementation**, and **FPGA synthesis results using Quartus**.

## Project Overview
This project focuses on designing and implementing an **FIR filter** with **99 taps**, optimized for efficient hardware realization.

## Matlab Filter Design: MATLAB Coefficient Calculations & Quantization

1. **Magnitude and Phase Responses of FIR Filter Before Coefficient Quantization**  
   ![Unquantized Magnitude Response](https://github.com/user-attachments/assets/afe96a06-a256-4c57-88d4-1a3d17840e85)

   ![Unquantized Phase Response](https://github.com/user-attachments/assets/07f730af-1268-4c5a-b5ea-aecd9cae9750)

2. **Magnitude and Phase Responses of FIR Filter After Coefficient Quantization**  

    ![Quantized Magnitude Response](https://github.com/user-attachments/assets/75938ff6-e1bc-42b9-a0ea-d166a581ed9f)

    ![Unquantized Phase Response](https://github.com/user-attachments/assets/8323348a-8ef8-47c6-9e7c-17d4224a06e8)

## FIR Filter VLSI Architecture Explanation

3 Different Architectures are explored:

1. Pipelined

![Pipelined FIR Filter](https://github.com/user-attachments/assets/f734bc82-ed40-458a-9e4e-491e0d73bd43)

3. Parallel (L=2) and (L=3)

![Reduced Complexity Parallel FIR Filter L=2](https://github.com/user-attachments/assets/63ebf88c-1963-4789-8c93-fca510068946)

![Reduced Complexity Parallel FIR Filter L=3](https://github.com/user-attachments/assets/ee68a847-7be3-481d-85b3-f8e4fa9e0aa8)

Images are referenced from Keshab K. Parhi - VLSI Digital Signal Processing Systems Design and Implementation-Wiley-Interscience (1999).

4. Combined Parallel and Pipeline (L=3)

## Testing Using ModelSim and Results

[]

## References
[1]“Parks-McClellan Bandpass Filter,” Mathworks.com, 2025. https://www.mathworks.com/help/signal/ref/firpm.html#mw_a610b0ff-bc10-4a9f-8b0b-188c89429bc3 (accessed Mar. 15, 2025).
[2]“Parks-McClellan optimal FIR filter order estimation - MATLAB firpmord,” www.mathworks.com. https://www.mathworks.com/help/signal/ref/firpmord.html
[3]"K. K. Parhi, VLSI Digital Signal Processing Systems: Design and Implementation." New York, NY, USA: Wiley-Interscience, 1999.
