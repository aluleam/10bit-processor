// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date Completed: November 24, 2024
// Description: This file contains a SystemVerilog module that drives a 7-segment display based on a 4-bit input.
// The module takes a 4-bit binary input and outputs a 7-bit signal to drive the corresponding segments of the display.
// If the input is a negative value (based on the most significant bit), the display shows a "-" sign.
// Otherwise, the input value is displayed on the 7-segment display, with segment patterns for digits 0-9.
// An enable signal ensures the display is activated only when needed.

module seven_seg(
    input logic [3:0] a,         // 4-bit input
    output logic [6:0] s,        // 7-segment display output
    output logic en              // Enable signal
);

    always_comb begin
        en = 1'b1; // Enable the display by default

        if (a[3] == 1'b1) begin
            s = 7'b1111110; 
        end else begin
            case (a)
                4'b0000: s = 7'b1000000; // 0
                4'b0001: s = 7'b1111001; // 1
                4'b0010: s = 7'b0100100; // 2
                4'b0011: s = 7'b0110000; // 3
                4'b0100: s = 7'b0011001; // 4
                4'b0101: s = 7'b0010010; // 5
                4'b0110: s = 7'b0000010; // 6
                4'b0111: s = 7'b1111000; // 7
                4'b1000: s = 7'b0000000; // 8
                4'b1001: s = 7'b0010000; // 9
                default: s = 7'b1111111; // Blank display for invalid input
            endcase
        end
    end

endmodule
