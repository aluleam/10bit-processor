// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date: November 25, 2024
// Description: This module controls how the processor works by managing the flow of data 
// and controlling the operations like reading/writing registers, doing calculations, 
// and interacting with memory or external data.

module controller(
    input logic [9:0] ImmediateData,   // Data value used directly in instructions
    input logic [1:0] CurrentTimestep, // The current step in the processor's cycle

    output logic [9:0] ImmediateValue,  // Value to be placed on the bus
    output logic [1:0] RegisterToWrite, // Which register to write data to
    output logic [1:0] RegisterToRead,  // Which register to read data from
    output logic WriteEnable,           // Turns on writing to the register file
    output logic ReadEnable,            // Turns on reading from the register file
    output logic ALUInputEnable,        // Turns on the A input to the ALU
    output logic ALUOutputEnable,       // Turns on the G output from the ALU
    output logic ALUToBusEnable,        // Puts the ALU result on the bus
    output logic [3:0] ALUControl,      // Decides what calculation the ALU will do
    output logic ExternalBusEnable,     // Allows external data to be on the bus
    output logic InstructionRegEnable,  // Loads data into the instruction register
    output logic ResetTimestep,         // Resets the timestep counter


    output logic readRam;
    output logic writeRam;
    output logic EnableAddress;

);

parameter 
    LOAD  = 4'b0000,
    COPY  = 4'b0001,
    ADD   = 4'b0010,
    SUB   = 4'b0011,
    INV   = 4'b0100,
    FLIP  = 4'b0101,
    AND   = 4'b0110,
    OR    = 4'b0111,
    XOR   = 4'b1000,
    LSL   = 4'b1001,
    LSR   = 4'b1010,
    ASR   = 4'b1011,
    ADDI  = 4'b1100,
    SUBI  = 4'b1101;





endmodule
