// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date: November 26, 2024
// Description: This module handles the output logic for the 10-bit processor. 
// It determines the values displayed on the LEDs and seven-segment displays based on the current 
// bus data, register file data, the Peek signal, and the current timestep. The module also controls 
// an LED to indicate when the processor operation is completed.

module outputLogic(
    input logic [9:0] bus_data,         // Data coming from the shared data bus
    input logic [9:0] reg_data,         // Data fetched from the register file
    input logic [1:0] step_count,       // Current processing step
    input logic done_flag,              // Signal indicating completion of an operation
    input logic peek_active,            // Signal from the Peek button to switch data display
    output logic [9:0] led_display,     // LEDs show data from either the bus or register, based on Peek
    output logic [6:0] seg_hex0,        // First seven-segment display, lower digit of the data
    output logic [6:0] seg_hex1,        // Second seven-segment display, middle digit of the data
    output logic [6:0] seg_hex2,        // Third seven-segment display, upper digit of the data
    output logic [6:0] step_display,    // Seven-segment display showing the current timestep
    output logic led_done               // LED that lights up when the done signal is active
);



// TODO: logic to select data for display, drive LEDs, and handle timestep display.

endmodule
