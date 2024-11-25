// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date Completed: November 22, 2024
// Description: This file contains a SystemVerilog module for a 2-bit up-counter. 
// The counter increments by 1 on each falling edge of the clock (CLKb) and resets to 0 when the clear signal (CLR) is high. 
// It is used to keep track of the steps in the processor's operations.

module upcount2 (
    input logic CLR,        // Active-high clear signal
    input logic CLKb,       // Negative-edge triggered clock
    output logic [1:0] CNT  // 2-bit counter output
);

always_ff @(negedge CLKb) begin
    if (CLR) begin
        CNT <= 2'b00;       // Reset counter to 0 when CLR is high
    end else begin
        CNT <= CNT + 1'b1;  // Increment counter on the negative edge of CLKb
    end
end

endmodule
