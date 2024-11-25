
// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date Completed: November 22, 2024
// Description: This file contains a SystemVerilog module for a 4-register file. 
// It stores and retrieves data in a processor. It writes data on the falling edge of the clock (CLKb) 
// when the write enable (ENW) is active, and provides outputs (Q0, Q1) based on read enable signals (ENR0, ENR1).

module registerFile (
    input [9:0] D,      // Data input for writing to registers
    input ENW,          // Write enable
    input ENR0,         // Read enable for output Q0
    input ENR1,         // Read enable for output Q1
    input CLKb,         // Clock signal
    input [1:0] WRA,    // Register address to write to
    input [1:0] RDA0,   // Register address for Q0 output
    input [1:0] RDA1,   // Register address for Q1 output
    output reg [9:0] Q0,   
    output reg [9:0] Q1 
);

reg [9:0] R0, R1, R2, R3;  // Separate 4 registers, each 10 bits wide

// Initial block to reset all registers and outputs to 0
initial begin
    R0 = 10'b0;
    R1 = 10'b0;
    R2 = 10'b0;
    R3 = 10'b0;
    Q0 = 10'b0;
    Q1 = 10'b0;
end

// Write operation (triggered on the falling edge of CLKb)
always_ff @(negedge CLKb) begin
    if (ENW) begin
        case(WRA)
            2'b00: R0 <= D;  // Write to register 0
            2'b01: R1 <= D;  // Write to register 1
            2'b10: R2 <= D;  // Write to register 2
            2'b11: R3 <= D;  // Write to register 3
        endcase
    end
end

// Read operation (combinational logic)
always_comb begin
    if (ENR0) begin
        case (RDA0)
            2'b00: Q0 = R0;
            2'b01: Q0 = R1;
            2'b10: Q0 = R2;
            2'b11: Q0 = R3;
            default: Q0 = 10'b0;  // Default to 0
        endcase
    end else begin
        Q0 = 10'b0;  // Default value when ENR0 is not active
    end

    if (ENR1) begin
        case (RDA1)
            2'b00: Q1 = R0;
            2'b01: Q1 = R1;
            2'b10: Q1 = R2;
            2'b11: Q1 = R3;
            default: Q1 = 10'b0;  // Default to 0
        endcase
    end else begin
        Q1 = 10'b0;  // Default value when ENR1 is not active
    end
end

endmodule
