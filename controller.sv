// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date: November 25, 2024
// Description: This module controls how the processor works by managing the flow of data 
// and controlling the operations like reading/writing registers, doing calculations, 
// and interacting with memory or external data.

module controller(
    input logic [9:0] ImmediateData,   // Data value used directly in instructions
    input logic [1:0] CurrentTimestep, // The current step in the processor's cycle

    output logic [9:0] ImmediateValue,  // Value to be placed on the bus
    output logic [1:0] RegisterToWrite, // Which register to write data to
    output logic [1:0] RegisterToRead,  // Which register to read data from
    output logic WriteEnable,           // Turns on writing to the register file
    output logic ReadEnable,            // Turns on reading from the register file
    output logic ALUInputEnable,        // Turns on the A input to the ALU
    output logic ALUOutputEnable,       // Turns on the G output from the ALU
    output logic ALUToBusEnable,        // Puts the ALU result on the bus
    output logic [3:0] ALUControl,      // Decides what calculation the ALU will do
    output logic ExternalBusEnable,     // Allows external data to be on the bus
    output logic InstructionRegEnable,  // Loads data into the instruction register
    output logic ResetTimestep,         // Resets the timestep counter

);

	logic [1:0] Rx; // Rx register
	logic [1:0] Ry; // Ry register
	logic [3:0] Opcode;
	logic [1:0] InstructionType;

// TODO: Logic to control the data flow, 
// like moving data to/from registers, the ALU, or memory, 
// depending on the current step in the processor.

parameter

	LD =   4'b0000, 	// Load Data: Rx ← Data
	CP =   4'b0001, 	// Copy: Rx: Rx ← [Ry]
	ADD =  4'b0010, 	// Add: Rx: Rx ← [Rx] + [Ry]
	SUB =  4'b0011, 	// Subtract: Rx: Rx ← [Rx]−[Ry]
	INV =  4'b0100, 	// Inv (Two's comp): Rx: Rx ← −[Ry] 
	FLP =  4'b0101, 	// Flip: Rx: Rx ←∼ [Ry]
	AND =  4'b0110, 	// And: Rx: Rx ← [Rx] & [Ry]
	OR =   4'b0111, 	// Or: Rx: Rx ← [Rx] | [Ry]
	XOR =  4'b1000, 	// Xor: Rx: ← [Rx] ∧ [Ry]
	LSL =  4'b1001, 	// Logical shift left: Rx: Rx ← [Rx] <<[Ry]
	LSR =  4'b1010, 	// Logical shift right: Rx: Rx ← [Rx] >>[Ry]
	ASR =  4'b1011, 	// Arithmatic shift right: Rx: ← [Rx] >>>[Ry]
	ADDI = 4'b1100, 	// Rx: Rx ← [Rx] + 10’b0000IIIIII
	SUBI = 4'b1101, 	// Rx: Rx ← [Rx] - 10’b0000IIIIII
	
	always_comb begin
		 ImmediateValue = 10'bzzzzzzzzzz;
       RegisterToWrite = 2'b0;
       RegisterToRead = 2'b0;
       WriteEnable = 1'b0;
       ReadEnable = 1'b0;
       ALUInputEnable = 1'b0;
       ALUOutputEnable = 1'b0;
       ALUToBusEnable = 1'b0;
       ALUControl = 4'bzzzz;
       ExternalBusEnable = 1'b0;
       InstructionRegEnable = 1'b0;
       ResetTimestep = 1'b0;
		 
		 case (CurrentTimestep)
			2'b00: begin
				ExternalBusEnable = 1'b1;
				InstructionRegEnable  = 1'b1;
			end
			
			2'b01: begin
				case (Opcode)
					LOAD: begin
						ExternalBusEnable: 1'b1;
						RegisterToWrite = Rx;
						WriteEnable = 1'b1;
						ResetTimestep = 1'b1;
					end
					
					COPY: begin
						RegisterToRead = Ry; 
						ReadEnable = 1'b1;
						RegisterToWrite = Rx;
						WriteEnable = 1'b1;
						ResetTimestep = 1'b1;
					end
					
					default: begin
						RegisterToRead = Ry;
						ReadEnable = 1'b1;
						ALUInputEnable = 1'b1;
					end
				endcase
			end
			
			2'b10: begin
				case (InstructionType)
					2'b00: begin
						RegisterToRead = Ry;
						ReadEnable = 1'b1;
						ALUControl = Opcode;
						ALUOutputEnable = 1'b1;
					end
					2'b10: begin
						ImmediateValue = {4'b0000, Instruction[5:0]};
						ALUControl = SUB;
						ALUOutputEnable = 1'b1;
					end
				endcase
			end
			
			2'b11: begin
				ALUToBusEnable = 1'b1;
				RegisterToWrite = Rx;
				WriteNeable = 1'b1;
				ResetTimestep = 1'b1;
			end
			
			default: begin
			
			
			end
		endcase
	end
				

endmodule