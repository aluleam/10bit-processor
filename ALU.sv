// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date: November 25, 2024
// Description: ALU module for performing arithmetic and logical operations. 
// It processes 10-bit input data based on a 4-bit function code and interacts with 
// registers for staging inputs and storing results.

module ALU (
    input logic [9:0] OP,       // Input data from the shared bus
    input logic [3:0] FN,       // Operation selector
    input logic Ain,            // Enable input for Register A
    input logic Gin,            // Enable saving result in G register
    input logic Gout,           // Enable output from G register
    input logic CLKb,           // Clock signal
    
    output logic [9:0] RES      // ALU result
);

logic [9:0] A;
logic [9:0] ALURes;
logic [9:0] G;


// TODO: Add logic for operations.

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
	
	
	always_ff @(negedge CLKb) begin
		if (Ain) begin
			A <= OP;
		end
	end
	
	always_comb begin
		ALURes = 10'b0;
		case (FN)
			LOAD:	ALURes = OP;
			COPY: ALURes = A;
			ADD:  ALURes = A + OP;
			SUB:  ALURes = A - OP;
			INV:  ALURes = (~OP) + 1;
			FLIP: ALURes = ~A;
			AND:  ALURes = A & OP;
			OR:   ALURes = A | OP;
			XOR:  ALURes = A ^ OP;
			LSL:  ALURes = A << OP[3:0];
			LSR:  ALURes = A >> OP[3:0];
			ASR:  ALURes = $signed(A) >>> OP[3:0];
			ADDI: ALURes = A + {4'b0000, OP[5:0]};
			SUBI: ALURes = A - {4'b0000, OP[5:0]};
			default: ALURes = 10'b0;
		endcase
	end
	
	always_ff @(negedge CLKb) begin
		if (Gin) begin
			G<= ALURes;
		end
	end
	
	always_comb begin
        if (Gout) begin
            RES = G;  
        end else begin
            RES = 10'bz;   
        end
    end
endmodule