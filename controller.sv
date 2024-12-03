// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date: November 25, 2024
// Description: This module controls how the processor works by managing the flow of data 
// and controlling the operations like reading/writing registers, doing calculations, 
// and interacting with memory or external data.

module controller(
    input logic [9:0] inst,     // 10-bit instruction input
    input logic [1:0] t,        // 2-bit time step input

    output logic [9:0] imm,     // Immediate value output
    output logic [1:0] reg_in,  // Register input
    output logic [1:0] reg_out, // Register output
    output logic write_en,      // Write enable signal
    output logic read_en,       // Read enable signal
    output logic alu_in,        // ALU input signal
    output logic alu_out_in,    // ALU output input signal
    output logic alu_out,       // ALU output signal
    output logic [3:0] alu_ctrl,// ALU control signals
    output logic ext_en,        // Extend enable signal
    output logic ir_in,         // Instruction register input
    output logic clear          // Clear signal
);

// Define operation codes for different instructions
parameter 
    LOAD = 4'b0000,             // Load instruction
    COPY = 4'b0001,             // Copy instruction
    ADD = 4'b0010,              // Add instruction
    SUB = 4'b0011,              // Subtract instruction
    INV = 4'b0100,              // Invert instruction
    FLIP = 4'b0101,             // Flip instruction
    AND = 4'b0110,              // AND instruction
    OR = 4'b0111,               // OR instruction
    XOR = 4'b1000,              // XOR instruction
    LSL = 4'b1001,              // Logical shift left instruction
    LSR = 4'b1010,              // Logical shift right instruction
    ASR = 4'b1011,              // Arithmetic shift right instruction
    ADDI = 4'b1100,             // Add immediate instruction
    SUBI = 4'b1101;             // Subtract immediate instruction

// Always block to update control signals based on time step and instruction
always_comb begin
    // Default values for control signals
    imm = 10'bzzzzzzzzzz;   
    reg_in = 2'b0;           
    reg_out = 2'b0;         
    write_en = 1'b0; 
    read_en = 1'b0;       
    alu_in = 1'b0;         
    alu_out_in = 1'b0;      
    alu_out = 1'b0;        
    alu_ctrl = 4'bzzzz;      
    ext_en = 1'b0;        
    ir_in = 1'b0;          
    clear = 1'b0;            

    // Control signals for each time step (t)
    if (t == 2'b00) begin
        // Time step 00: Initialize control signals for external and instruction register
        ext_en = 1;        // Enable external control signal
        ir_in = 1;         // Enable instruction register input
    end else if (t == 2'b01) begin
        // Time step 01: Set control signals based on instruction (inst)
        if (inst[9:8] == 2'b00 && inst[3:0] == LOAD) begin
            // If instruction is LOAD, set control signals for loading data
            ext_en = 1;                // Enable external signal
            reg_in = inst[7:6];        // Set register input
            write_en = 1;              // Enable write
            clear = 1;                 // Enable clear
            
        end else if (inst[9:8] == 2'b00 && inst[3:0] == 4'b0001) begin
            // If instruction is COPY, set control signals for copying data
            reg_out = inst[5:4];       // Set register output
            read_en = 1;               // Enable read
            reg_in = inst[7:6];        // Set register input
            write_en = 1;              // Enable write
            clear = 1;                 // Enable clear
        end else if (inst[9:8] == 2'b00 && inst[3:0] == 4'b1100) begin 
            // If instruction is ADDI, set control signals for address register read
            reg_out = inst[5:4];       // Set register output
            read_en = 1;               // Enable read
            write_en = 0;              // Disable write
        end else if (inst[9:8] == 2'b00 && inst[3:0] == 4'b1101) begin
            // If instruction is SUBI, set control signals for address register read
            reg_out = inst[7:6];       // Set register output
            read_en = 1;               // Enable read
            write_en = 0;              // Disable write
        end else begin
            // Default case for other instructions, set control signals for ALU input
            reg_out = inst[7:6];       // Set register output
            read_en = 1;               // Enable read
            alu_in = 1;                // Enable ALU input
        end
    end else if (t == 2'b10) begin
        // Time step 10: Control signals for ALU operations
        if (inst[9:8] == 2'b00) begin
            if (inst[3:0] == 4'b1100) begin 
                // If instruction is ADDI, set control signals for ALU operations
                alu_ctrl = inst[3:0];   // Set ALU control signal
                alu_out_in = 1;         // Enable ALU output input
                write_en = 1;           // Enable write
                clear = 1;              // Enable clear
            end else if (inst[3:0] == 4'b1101) begin 
                // If instruction is SUBI, set control signals for ALU operations
                alu_ctrl = inst[3:0];   // Set ALU control signal
                alu_out_in = 1;         // Enable ALU output input
                write_en = 1;           // Enable write
                clear = 1;              // Enable clear
            end else begin
                // For other instructions, set ALU control signals
                alu_ctrl = inst[3:0];   // Set ALU control signal
                alu_out_in = 1;         // Enable ALU output input
            end
        end
    end
end

endmodule
