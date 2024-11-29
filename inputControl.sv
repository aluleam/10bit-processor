// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date:  November 25, 2024
// Description: This module is part of a 10-bit processor. 
// It provides the input logic that handles raw data from external switches, manages the Peek button, 
// and debounces clock and Peek signals. The module also facilitates writing external data to the 
// shared data bus and provides a way for selecting registers during the Peek function.

module inputControl(
    input logic [9:0] switch_input,      // 10-bit input from external switches on the DE-10 Lite board
    input logic peek_signal,             // Signal for the Peek button
    input logic board_clk_50MHz,         // 50 MHz clock input from the DE-10 Lite board
    input logic button_clk_input,        // Input signal from the clock button
    input enable_bus_write,              // Signal to enable writing external data to the shared data bus

    output logic [9:0] bus_output,       // Data output to the shared data bus
    output logic [1:0] peek_address,     // 2-bit address specifying which register to peek into
    output logic debounced_clk,          // Debounced clock signal
    output logic debounced_peek          // Debounced Peek button signal
);

debounce debouncedP (.A_noisy(peek_signal),.CLK50M(board_clk_50MHz),. A(debounced_peek));
debounce debouncedClock (.A_noisy(button_clk_input),.CLK50M(board_clk_50MHz),. A(debounced_clk));

assign peek_address = switch_input[1:0];

always_comb begin
if(enable_bus_write) begin
    end
    else begin
        bus_output = 10'bz;
    end
    end


endmodule
