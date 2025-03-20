# FIR-Filter-VLSI-Design

This repository contains the design, implementation, and analysis of a **Finite Impulse Response (FIR) filter** for **ECSE 6680 - Advanced VLSI Design**. The project includes **MATLAB simulations**, **Verilog hardware implementation**, and **FPGA synthesis results using Quartus**.

## Project Overview
Finite Impulse Response filters have an important role in DSP applications for communication systems, biomedical devices, and image processing. The main challenge in designing FIR filters for VLSI implementation is rooted in its optimization of latency, area utilization, and power efficiency, while maintaining high filtering accuracy.

My project attempts the design and hardware implementation of a 99-tap FIR filter for ECSE 6680 - Advanced VLSI Design, that integrates pipelining, parallelization (L=2, L=3), and a combined parallel-pipelined approach (L=3). The filter is implemented using MATLAB simulations for coefficient generation, followed by Verilog-based hardware realization and FPGA synthesis using Quartus.

## Matlab Filter Design: MATLAB Coefficient Calculations & Quantization

The FIR filter coefficients are generated using MATLAB's Parks-McClellan algorithm (firpm). The filter requirements include a passband ripple (Rp) of 1 dB and a stopband attenuation (Rs) of 80 dB.

To enable hardware implementation, the coefficients are quantized to 24-bit fixed-point representation to ensure compatibility with FPGA arithmetic units. This step introduces quantization error, which is analyzed by comparing the magnitude and phase response of the unquantized and quantized coefficients.

1. **Magnitude and Phase Responses of FIR Filter Before Coefficient Quantization**  
   ![Unquantized Magnitude Response](https://github.com/user-attachments/assets/afe96a06-a256-4c57-88d4-1a3d17840e85)

   ![Unquantized Phase Response](https://github.com/user-attachments/assets/07f730af-1268-4c5a-b5ea-aecd9cae9750)

2. **Magnitude and Phase Responses of FIR Filter After Coefficient Quantization**  

    ![Quantized Magnitude Response](https://github.com/user-attachments/assets/75938ff6-e1bc-42b9-a0ea-d166a581ed9f)

    ![Unquantized Phase Response](https://github.com/user-attachments/assets/8323348a-8ef8-47c6-9e7c-17d4224a06e8)

## FIR Filter VLSI Architecture Explanation

The pipelined architecture introduces registers between computational stages to increase clock speed and throughput. This step requires additional area due to register overhead.

3 Different Architectures are explored:

1. Pipelined

![Pipelined FIR Filter](https://github.com/user-attachments/assets/f734bc82-ed40-458a-9e4e-491e0d73bd43)

Resource Utilization:
![Resource Utilization of Pipeline](https://github.com/user-attachments/assets/7ae9977a-1098-4993-91f2-2339c315eac9)

Clock Frequency Estimate:
![Clock Frequency of Pipeline](https://github.com/user-attachments/assets/e4ff6b41-84d7-4922-a49e-3954ca569d99)

2. Parallel (L=2) and (L=3)

Parallelization involves the use of multiple input data streams, allowing the FIR filter to compute multiple outputs per clock cycle. Two (L=2) and three (L=3) parallel data paths are implemented to analyze trade-offs between hardware complexity and speed.

![Reduced Complexity Parallel FIR Filter L=2](https://github.com/user-attachments/assets/63ebf88c-1963-4789-8c93-fca510068946)

![Reduced Complexity Parallel FIR Filter L=3](https://github.com/user-attachments/assets/ee68a847-7be3-481d-85b3-f8e4fa9e0aa8)

Images are referenced from Keshab K. Parhi - VLSI Digital Signal Processing Systems Design and Implementation-Wiley-Interscience (1999).

Resource Utilization of Parallel (L=3):
![Resource Utilization of Parallel (L=3)](https://github.com/user-attachments/assets/ec7841af-befb-47df-8086-a43c801b415b)

Resource Utilization of Parallel (L=3):
![Clock Frequency of Parallel (L=3)](https://github.com/user-attachments/assets/b2376e2e-2cfd-4d0c-9b2a-8e791975800e)


3. Combined Parallel and Pipeline (L=3) Explanation

The final architecture combines parallelization and pipelining. The integration uses three parallel data paths (L=3) and pipelining techniques.

![Combined Parallel and Pipeline](https://github.com/user-attachments/assets/ec77a28f-3f48-4c82-a177-9858899257ef)

Resource Utilization:
![Resource Utilization of Parallel and Pipeline (L=3)](https://github.com/user-attachments/assets/dd983860-2b34-40be-8925-22c637a71fe1)

Clock Frequency Estimate:
![Clock Frequency of Parallel and Pipeline](https://github.com/user-attachments/assets/e1c53ec5-3df4-4d06-ac1a-8a1b99cf6ad0)

## Future Plans

This project is an iterative effort, and I am continuing to refine the implementation by addressing any minor logistical issues and optimizing performance. Current areas of focus include improving testbench validation, ensuring accuracy in hardware verification, and further streamlining the design for resource efficiency. As testing progresses, I aim to enhance the robustness of the architecture while maintaining correctness and computational efficiency.

## References
[1]“Parks-McClellan Bandpass Filter,” Mathworks.com, 2025. https://www.mathworks.com/help/signal/ref/firpm.html#mw_a610b0ff-bc10-4a9f-8b0b-188c89429bc3 (accessed Mar. 15, 2025).
[2]“Parks-McClellan optimal FIR filter order estimation - MATLAB firpmord,” www.mathworks.com. https://www.mathworks.com/help/signal/ref/firpmord.html
[3]"K. K. Parhi, VLSI Digital Signal Processing Systems: Design and Implementation." New York, NY, USA: Wiley-Interscience, 1999.
