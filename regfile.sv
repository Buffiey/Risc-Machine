`define OHR0 7'b00000001 // Define register 0 as one hot code
`define OHR1 7'b00000010 // Define register 1 as one hot code
`define OHR2 7'b00000100 // Define register 2 as one hot code
`define OHR3 7'b00001000 // Define register 3 as one hot code
`define OHR4 7'b00010000 // Define register 4 as one hot code
`define OHR5 7'b00100000 // Define register 5 as one hot code
`define OHR6 7'b01000000 // Define register 6 as one hot code
`define OHR7 7'b10000000 // Define register 7 as one hot code


module regfile(data_in,writenum,write,readnum,clk,data_out);
input [15:0] data_in; // 16 bit data input
input [2:0] writenum, readnum; // 3 bit input for decoders
input write, clk; // 1 bit input
output reg [15:0] data_out; // 16 bit data output
reg [7:0] decoderoutput1; // 8 bit output of first decoder (writenum)
reg [7:0] decoderoutput2; // 8 bit output of second decoder (readnum)
reg [7:0] load; // 8 bit output for first decoder

reg [15:0] R0; // 16 bit value of register 0
reg [15:0] R1; // 16 bit value of register 1
reg [15:0] R2; // 16 bit value of register 2
reg [15:0] R3; // 16 bit value of register 3
reg [15:0] R4; // 16 bit value of register 4
reg [15:0] R5; // 16 bit value of register 5
reg [15:0] R6; // 16 bit value of register 6
reg [15:0] R7; // 16 bit value of register 7

always_ff @(posedge clk) begin // sequential logic block because of input from clock
    if (load != 7'b00000000) begin // condition to see if load is not 0
    case(writenum) // 8 cases from 8 different states
    3'b000: R0 = data_in; // state 0, sets data input to register 0
    3'b001: R1 = data_in; // state 1, sets data input to register 1
    3'b010: R2 = data_in; // state 2, sets data input to register 2
    3'b011: R3 = data_in; // state 3, sets data input to register 3
    3'b100: R4 = data_in; // state 4, sets data input to register 4
    3'b101: R5 = data_in; // state 5, sets data input to register 5
    3'b110: R6 = data_in; // state 6, sets data input to register 6
    3'b111: R7 = data_in; // state 7, sets data input to register 7
    endcase
    end
end

always_comb begin // cominational logic block
    case(writenum) // 8 cases from 8 different states (1st decoder)
    3'b000:  decoderoutput1 = `OHR0; // state 0, sets one hot of register 0 to decoder output
    3'b001:  decoderoutput1 = `OHR1; // state 1, sets one hot of register 1 to decoder output
    3'b010:  decoderoutput1 = `OHR2; // state 2, sets one hot of register 2 to decoder output
    3'b011:  decoderoutput1 = `OHR3; // state 3, sets one hot of register 3 to decoder output
    3'b100:  decoderoutput1 = `OHR4; // state 4, sets one hot of register 4 to decoder output
    3'b101:  decoderoutput1 = `OHR5; // state 5, sets one hot of register 5 to decoder output
    3'b110:  decoderoutput1 = `OHR6; // state 6, sets one hot of register 6 to decoder output
    3'b111:  decoderoutput1 = `OHR7; // state 7, sets one hot of register 7 to decoder output
    endcase 
    load = decoderoutput1 & {write, write, write, write, write, write, write, write}; // setting load by decoderoutput ANDing with write

    case(readnum) // 8 cases from 8 different states (2nd decoder)
    3'b000:  decoderoutput2 = `OHR0; // state 0, sets one hot of register 0 to decoder output
    3'b001:  decoderoutput2 = `OHR1; // state 1, sets one hot of register 1 to decoder output
    3'b010:  decoderoutput2 = `OHR2; // state 2, sets one hot of register 2 to decoder output
    3'b011:  decoderoutput2 = `OHR3; // state 3, sets one hot of register 3 to decoder output
    3'b100:  decoderoutput2 = `OHR4; // state 4, sets one hot of register 4 to decoder output
    3'b101:  decoderoutput2 = `OHR5; // state 5, sets one hot of register 5 to decoder output
    3'b110:  decoderoutput2 = `OHR6; // state 6, sets one hot of register 6 to decoder output
    3'b111:  decoderoutput2 = `OHR7; // state 7, sets one hot of register 7 to decoder output
    endcase

    case(decoderoutput2) // 8 cases from 8 different states with decoderoutput2 equating to one hot of register
    `OHR0: data_out = R0; // One hot register 0, value of register 0 equals data output
    `OHR1: data_out = R1; // One hot register 1, value of register 1 equals data output
    `OHR2: data_out = R2; // One hot register 2, value of register 2 equals data output
    `OHR3: data_out = R3; // One hot register 3, value of register 3 equals data output
    `OHR4: data_out = R4; // One hot register 4, value of register 4 equals data output
    `OHR5: data_out = R5; // One hot register 5, value of register 5 equals data output
    `OHR6: data_out = R6; // One hot register 6, value of register 6 equals data output
    `OHR7: data_out = R7; // One hot register 7, value of register 7 equals data output
    endcase
end
endmodule