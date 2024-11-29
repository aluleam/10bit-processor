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

logic [9:0] display_data;              // Data to display on LEDs or seven-segment displays
assign display_data = peek_active ? bus_data : reg_data; // Select bus or register data based on Peek

assign led_display = display_data;    // Directly connect to LEDs

logic en_hex;                         // Enable signal for seven-segment modules

// Lower 4 bits for the first seven-segment display
seven_seg u_hex0(
    .a(display_data[3:0]), 
    .s(seg_hex0), 
    .en(en_hex)
);

// Middle 4 bits for the second seven-segment display
seven_seg u_hex1(
    .a(display_data[7:4]), 
    .s(seg_hex1), 
    .en(en_hex)
);

// Upper 2 bits for the third seven-segment display (padded to 4 bits with zeros)
seven_seg u_hex2(
    .a({2'b00, display_data[9:8]}), 
    .s(seg_hex2), 
    .en(en_hex)
);

// Display current timestep on the seven-segment display (padded to 4 bits with zeros)
seven_seg u_step(
    .a({2'b00, step_count}), 
    .s(step_display), 
    .en(en_hex)
);

// Light LED when done_flag is active
assign led_done = done_flag;

// Set enable signal to always active
assign en_hex = 1'b1;

endmodule
