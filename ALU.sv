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

// TODO: Add logic for operations.

endmodule
