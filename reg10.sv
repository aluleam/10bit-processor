// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date Completed: November 19, 2024
// Description: This file contains a SystemVerilog module for a 10-bit register (reg10).
// The register captures a 10-bit input (D) on the negative edge of the clock (CLKb) when the enable signal (EN) is high.
// When EN is low, the register retains its previous value.

module reg10 (
    input logic [9:0] D,    // 10-bit input data
    input logic EN,          // Enable signal for the register
    input logic CLKb,        // Clock signal (negative edge triggered)
    output logic [9:0] Q     // 10-bit output data 
);

// Always block triggered on the negative edge of the clock
always_ff @(negedge CLKb) begin
    if (EN) begin
        // If enable signal (EN) is high, capture input (D) into register (Q)
        Q  <= D;     
    end
end

endmodule
