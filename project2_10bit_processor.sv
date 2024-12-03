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

logic ext_enable;                             // External Data Receiver Enable
logic [9:0] instr_from_ir;                    // Instruction from IR to ALU's INSTR input
logic [1:0] timestep;                         // Timestep counter: From output of Counter
wire [9:0] data_bus;                          // Shared Data Bus
logic [9:0] reg_read_data;                    // Data read from Register File
logic debounced_clk;                          // Debounced Clock signal
logic ir_enable;                              // Instruction Register Enable signal
logic [1:0] dataBtwobits;                     // Last 2 bits of Data Bus
logic debounced_peek;                         // Debounced Peek signal
logic clear;                                  // Clear signal for Instruction Register and Output Logic Module


    inputControl inputLogic(
        .switch_input(DataBus),
        .peek_signal(Pkb),
        .board_clk_50MHz(Clock_50MHz),
        .button_clk_input(Clkb),
        .enable_bus_write(ext_enable),
        

        .bus_output(data_bus),
        .peek_address(dataBtwobits),
        .debounced_clk(debounced_clk),
        .debounced_peek(debounced_peek)
    );

        upcount2 countermodule (
            .CLR (clear),
            .CLKb (debounced_clk),
            .CNT (dataBtwobits),
        );


        reg10 instructionRegister (
            .D(data_bus),
            .EN (ir_enable), //Instruction Register Enable
            .CLKb (debounced_clk),
            .Q(instr_from_ir)
        );

        logic wr_en;                                 // Write enable signal
        logic [1:0] wr_addr;                         // Register write address
        logic [1:0] rd_addr;                         // Register read address

        logic a_en;                                  // ALU input A enable
        logic g_en;                                  // ALU input G enable
        logic g_out_en;                              // ALU output G enable
        logic [3:0] alu_ctrl;                        // ALU control signal

        logic addr_rd_en;                            // Address register read enable

        // Instantiate the controller module
        controller u_controller (
            .inst(instr_from_ir),           // Instruction input
            .t(timestep),                   // Time step input
            .imm(imm),                      // Immediate value output
            .reg_in(reg_in),                // Register input output
            .reg_out(reg_out),              // Register output
            .write_en(write_en),            // Write enable output
            .read_en(read_en),              // Read enable output
            .alu_in(alu_in),                // ALU input signal output
            .alu_out_in(alu_out_in),        // ALU output input signal output
            .alu_out(alu_out),              // ALU output signal output
            .alu_ctrl(alu_ctrl),            // ALU control signal output
            .ext_en(ext_en),                // External enable output
            .ir_in(ir_enable),              // Instruction register input output
            .clear(clear),                  // Clear signal output
    );


        registerFile u_registerFile (
            .D(DataBus),                   // Data input for writing to registers
            .ENW(wr_en),                   // Write enable signal
            .ENR0(read_en),                // Read enable for Q0 output
            .ENR1(read_en),                // Read enable for Q1 output
            .CLKb(Clock_50MHz),            // Clock signal
            .WRA(wr_addr),                 // Register address for writing
            .RDA0(rd_addr),                // Register address for Q0 output
            .RDA1(rd_addr),                // Register address for Q1 output
            .Q0(reg_read_data),            // Output for read address RDA0
            .Q1(reg_read_data)             // Output for read address RDA1
    );

        // Instantiate the ALU module
        ALU u_ALU (
            .OP(DataBus),                  // Input data from shared bus (DataBus)
            .FN(alu_ctrl),                 // ALU control signal (from controller)
            .Ain(a_en),                    // Enable input for Register A (from controller)
            .Gin(g_en),                    // Enable saving result in G register (from controller)
            .Gout(g_out_en),               // Enable output from G register (from controller)
            .CLKb(Clock_50MHz),            // Clock signal
            .RES(alu_result)               // ALU result output
    );


        outputLogic u_outputLogic (
            .bus_data(DataBus),           // Data from the shared bus
            .reg_data(reg_read_data),     // Data from the register file
            .step_count(timestep),        // Current timestep
            .done_flag(DoneSignal),      // Done signal indicating operation completion
            .peek_active(debounced_peek), // Signal from Peek button

            .led_display(LED_Data),       // LEDs to show data from bus or register based on Peek
            .seg_hex0(DHEX0),             // First 7-segment display
            .seg_hex1(DHEX1),             // Second 7-segment display
            .seg_hex2(DHEX2),             // Third 7-segment display
            .step_display(TimeStep),      // Display current timestep
            .led_done(DoneSignal)         // LED to indicate operation completion
    );

endmodule