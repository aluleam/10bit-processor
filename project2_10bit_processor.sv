// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date:  November 25, 2024
// Description: This is the top-level module 10-bit processor. 
// It brings together all other essential modules, including the ALU, register file, controller, 
// and input and output logic, to emulate a fully functional processor. 
// The module manages the data flow and control signals, making sure the different parts of 
// the processor work together correctly.

module project2_10bit_processor (

    input logic [9:0] DataBus,
    input logic Clock_50MHz,
    input logic Pkb,
    input logic Clkb,
    output logic [9:0] LED_Data 
    output logic [6:0] DHEX0,                   
    output logic [6:0] DHEX1,               
    output logic [6:0] DHEX2,                   
    output logic [6:0] TimeStep,   
    output logic DoneSignal

);

//logic



endmodule