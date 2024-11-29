// Names: Masumbuko Alulea, Mike
// Class: CSC-244 Digital Logic
// Instructor: Galipeau
// Date: November 25, 2024
// Description: ALU module for performing arithmetic and logical operations. 
// It processes 10-bit input data based on a 4-bit function code and interacts with 
// registers for staging inputs and storing results.

module ALU (
    input logic [9:0] OP,       // Input data from the shared bus
    input logic [3:0] FN,       // Operation selector
    input logic Ain,            // Enable input for Register A
    input logic Gin,            // Enable saving result in G register
    input logic Gout,           // Enable output from G register
    input logic CLKb,           // Clock signal
    
    output logic [9:0] RES      // ALU result
);

parameter 
    LOAD  = 4'b0000, // Load a value
    COPY  = 4'b0001, // Copy Ry to Rx
    ADD   = 4'b0010, // Rx ← Rx + Ry
    SUB   = 4'b0011, // Rx ← Rx - Ry
    INV   = 4'b0100, // Rx ← -Ry (two's complement)
    FLIP  = 4'b0101, // Rx ← ~Ry (bitwise NOT)
    AND   = 4'b0110, // Rx ← Rx & Ry (bitwise AND)
    OR    = 4'b0111, // Rx ← Rx | Ry (bitwise OR)
    XOR   = 4'b1000, // Rx ← Rx ^ Ry (bitwise XOR)
    LSL   = 4'b1001, // Rx ← Rx << Ry (logical shift left)
    LSR   = 4'b1010, // Rx ← Rx >> Ry (logical shift right)
    ASR   = 4'b1011, // Rx ← Rx >>> Ry (arithmetic shift right)
    ADDI  = 4'b1100, // Rx ← Rx + immediate value
    SUBI  = 4'b1101; // Rx ← Rx - immediate value


    logic [9:0] A; // Register A
    logic [9:0] regResult; //The result of the register G
    logic [9:0] res; // Result from the operations

    always_ff @(negedge CLKb ) begin

            if(Ain) begin
            A<= OP;  
        end
    end

// ALU operations
    always_comb begin
        case (FN)
            LOAD:   res = OP;           // Store input to result
            COPY:   res = A;            // Copy A to result
            ADD:    res = A + OP;       // Add A and OP
            SUB:    res = A - OP;       // Subtract OP from A
            INV:    res = (~OP) + 1;    // Negate OP (two's complement)
            FLIP:   res = ~A;           // Invert A
            AND:    res = A & OP;       // Bitwise AND
            OR:     res = A | OP;       // Bitwise OR
            XOR:    res = A ^ OP;       // Bitwise XOR
            LSL:    res = A << OP;      // Logical left shift
            LSR:    res = A >> OP;      // Logical right shift
            ASR:    res = $signed(A) >>> OP; // Arithmetic right shift
            ADDI:   res = A + OP;       // Add immediate value
            SUBI:   res = A - OP;       // Subtract immediate value
            default: res = 10'b0;       // Clear result for undefined operation
        endcase
    end
// Store the result in the G register when Gin is active
    always_ff @(negedge CLKb ) begin
        if(Gin) begin
            regResult <= res;
        end
    end
 //output the result from the G register when Gout is active
    always_comb begin
        if(Gout == 1'b1) begin
            RES = regResult;
        end
        else begin
            RES = 10'bz; // High impendance when not enabled
        end
    end
    
endmodule
