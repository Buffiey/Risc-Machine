module shifter(in,shift,sout);

    input [15:0] in; // 16 bit input from B block
    input [1:0] shift; // Shift states
    output reg [15:0] sout; // 16 bit shift output

    always_comb begin // combinational block 

        case(shift) // sets the 4 types of states with cases

            2'b00: sout = in; // state 00, sets input as output making no shifting with bits 

            2'b01: sout = in << 1; // state 01, shifts the input bits to the left by one position

            2'b10: sout = in >> 1; // state 10, shifts the input bits to the right by one position

            2'b11: sout = {in[15], in[15:1]}; // state 11, shifts all the input bits from [15:1] to the right by one position making in[15] = in[0]

        endcase

    end

endmodule