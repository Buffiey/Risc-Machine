module ALU(Ain,Bin,ALUop,out,Z);

    input [15:0] Ain, Bin; // 16 bit input from output of Mux at block 6 and 7
    input [1:0] ALUop; // ALU states
    output reg [15:0] out; // 16 bit output from ALU
    output reg Z; // 1 bit output from ALU

    always_comb begin

        case(ALUop) // 4 cases of ALU

            2'b00: out = Ain + Bin; // Adding Ain and Bin to temp

            2'b01: out = Ain - Bin; // Subtracting Ain and Bin to temp

            2'b10: out = Ain & Bin; // ANDing Ain and Bin to temp

            2'b11: out = ~Bin; // NOTing Bin to temp

        endcase

        if (out == 16'b0) begin // checks to see if out is 0, setting Z as 1
            Z = 1'b1;
        end else begin
            Z = 1'b0; // if out is not 0, sets Z as 0
        end

    end

endmodule   