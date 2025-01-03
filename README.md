10-bit Processor
This project involves the development of a 10-bit processor using SystemVerilog for the DE10-Lite FPGA board. The processor is designed to perform basic operations, such as data movement, arithmetic, immediate actions, and logical operations. It is a foundational step towards understanding processor design and FPGA implementation.

Features:
10-bit Data Processing: The processor is designed to handle 10-bit data for operations such as arithmetic and logic.
Arithmetic Operations: Supports basic arithmetic operations like addition, subtraction, etc.
Logical Operations: Includes basic logical operations like AND, OR, XOR.
Immediate Actions: Supports operations involving immediate values.
Control Logic: Implements control logic for instruction fetching, decoding, and execution.
FPGA Implementation: The processor is designed to run on the DE10-Lite FPGA board, which serves as the hardware platform for testing and simulation.
Requirements:
DE10-Lite FPGA Board (or similar FPGA platform)
SystemVerilog for hardware description
Quartus Prime for FPGA design and synthesis
ModelSim for simulation and verification
Basic knowledge of digital logic design and FPGA programming
Installation and Setup:
Clone or download the repository to your local machine.
Open the project in Quartus Prime to synthesize the design.
Use ModelSim for simulation and verification of the processor's behavior.
Load the synthesized design onto the DE10-Lite FPGA board for hardware testing.
How to Use:
Load the Design to FPGA:

After synthesizing the design in Quartus Prime, load the compiled bitstream file onto the DE10-Lite FPGA board.
Test the Processor:

Use the FPGA board to run the processor and verify its operations, such as executing arithmetic and logical operations.
Simulation (Optional):

Run the SystemVerilog testbenches in ModelSim to simulate the behavior of the processor before hardware implementation.
Key Components:
ALU (Arithmetic Logic Unit): Responsible for performing arithmetic and logical operations.
Control Unit: Decodes instructions and generates the necessary control signals to drive the processor.
Register File: Stores data values for manipulation and processing by the ALU.
Instruction Set: A set of instructions that the processor can execute, including data movement, arithmetic, and logical operations.
Program Counter: Keeps track of the current instruction to be executed.
Future Improvements:
Expanded Instruction Set: Additional operations and control logic for more complex processing tasks.
Pipelining: Implement pipelining techniques for improved performance.
I/O Support: Adding input/output capabilities for more interactive processing.
