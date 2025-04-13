module ALU_tb;

    reg [15:0] Ain; // 16 bit input from output of Mux at block 6
    reg [15:0] Bin; // 16 bit input from output of Mux at block 7
    reg [1:0] ALUop; // ALU states
    wire [15:0] out; // 16 bit output from ALU
    wire Z; // 1 bit output from ALU
    reg err; // Error checker 

    ALU DUT(.Ain(Ain), .Bin(Bin), .ALUop(ALUop), .out(out), .Z(Z)); //instantiate inputs and outputs of ALU module

    task my_checker; // test function

        input [15:0] expected_output; // 16 bit expected output of out
        input expected_Z; // 1 bit expected output of Z

        if (expected_output != out) begin // test condition where if expected output does not match with output, prints error message
            $display("ERROR ** output is %b, expected %b", DUT.out, expected_output);
            err = 1'b1; // sets error to 1 indicating error in testbench
        end

        if (expected_Z != Z) begin // test condition where if expected output Z does not match with output Z, prints error message
            $display("ERROR ** Z is %b, expected %b", DUT.Z, expected_Z);
            err = 1'b1; // sets error to 1 indicating error in testbench
        end

    endtask

    initial begin

    err = 1'b0; #10; // sets error initially at 0 (if error goes to 1, there is an error)

    $display("Checking to see if state 00 adds Ain and Bin to out setting a Z value");
    Ain[15:0] = 16'b1111000011001111; // tested A input
    Bin[15:0] = 16'b1011100101100101; // tested B input
    ALUop[1:0] = 2'b00; // ALU state 00
    #10; // delay by 10ps
    my_checker(16'b011010101000110100, 1'b0); // expected output of out and Z

    $display("Checking to see if state 01 subtracts Ain and Bin to out setting a Z value");
    Ain[15:0] = 16'b1111000011001111; // tested A input
    Bin[15:0] = 16'b1011100101100101; // tested B input
    ALUop[1:0] = 2'b01; // ALU state 01
    #10; // delay by 10ps
    my_checker(16'b0011011101101010, 1'b0); // expected output of out and Z

    $display("Checking to see if state 10 Ands Ain and Bin setting a Z value");
    Ain[15:0] = 16'b1111000011001111; // tested A input
    Bin[15:0] = 16'b1011100101100101; // tested B input
    ALUop[1:0] = 2'b10; // ALU state 10
    #10; // delay by 10ps
    my_checker(16'b1011000001000101, 1'b0); // expected output of out and Z

    $display("Checking to see if state 11 Nots Bin setting a Z value");
    Ain[15:0] = 16'b1111000011001111; // tested A input
    Bin[15:0] = 16'b1011100101100101; // tested B input
    ALUop[1:0] = 2'b11; // ALU state 11
    #10; // delay by 10ps
    my_checker(16'b0100011010011010, 1'b0); // expected output of out and Z

    $display("Checking to see if state 01 subtracts Ain and Bin to out setting a Z value of 1");
    Ain[15:0] = 16'b1111000011001111; // tested A input
    Bin[15:0] = 16'b1111000011001111; // tested B input
    ALUop[1:0] = 2'b01; // ALU state 01
    #10; // delay by 10ps
    my_checker(16'b0000000000000000, 1'b1); // expected output of out and Z

    $display("Checking to see if state 11 Nots Bin setting a Z value of 1");
    Ain[15:0] = 16'b1111000011001111; // tested A input
    Bin[15:0] = 16'b1111111111111111; // tested B input
    ALUop[1:0] = 2'b11; // ALU state 11
    #10; // delay by 10ps
    my_checker(16'b0000000000000000, 1'b1); // expected output of out and Z

    $display("Checking to see if state 10 Ands Ain and Bin setting a Z value of 1");
    Ain[15:0] = 16'b0000000000000000; // tested A input
    Bin[15:0] = 16'b0000000000000000; // tested B input
    ALUop[1:0] = 2'b10; // ALU state 10
    #10; // delay by 10ps
    my_checker(16'b0000000000000000, 1'b1); // expected output of out and Z
    
    end

endmodule