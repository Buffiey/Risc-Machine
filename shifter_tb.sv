module shifter_tb;

reg [15:0] in; // 16 bit input from B block
reg [1:0] shift; // Shift states
reg err; // Error checker
wire [15:0] sout; // 16 bit shift output

shifter DUT(.in(in), .shift(shift), .sout(sout)); //instantiate inputs and outputs of shifter module

task my_checker; // checker function

input [15:0] expected_sout; // expected output of shifter from shift state

begin

    if (DUT.sout != expected_sout) begin // Condition where if shifter output does not equate to expected shifter output, prints error message
        $display("ERROR ** shifter output is %b, expected %b", DUT.sout, expected_sout);
        err = 1'b1; // sets error to 1
    end

end

endtask

initial begin

    err = 1'b0; #10; // sets error initially at 0 (if error goes to 1, there is an error)

    $display("Checking to see if the shifter output at state 00 does not shift value");
    in[15:0] = 16'b1111000011001111; // tested input
    shift[1:0] = 2'b00; // shift state 00
    #10; // delay by 10ps
    my_checker(16'b1111000011001111); // expected output

    $display("Checking to see if the shifter output at state 01 does shifts 1 bit value left");
    in[15:0] = 16'b1111000011001111; // tested input
    shift[1:0] = 2'b01; // shift state 01
    #10; // delay by 10ps
    my_checker(16'b1110000110011110); // expected output

    $display("Checking to see if the shifter output at state 10 does shift 1 bit value right");
    in[15:0] = 16'b1111000011001111; // tested input
    shift[1:0] = 2'b10; // shift state 10
    #10; // delay by 10ps
    my_checker(16'b0111100001100111); // expected output

    $display("Checking to see if the shifter output at state 00 does shift 1 bit value right with padding of 1");
    in[15:0] = 16'b1111000011001111; // tested input
    shift[1:0] = 2'b11; // shift state 11
    #10; // delay by 10ps
    my_checker(16'b1111100001100111); // expected output

end

endmodule