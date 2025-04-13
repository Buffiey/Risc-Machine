`define OHR0 7'b00000001 // Define register 0 as one hot code
`define OHR1 7'b00000010 // Define register 1 as one hot code
`define OHR2 7'b00000100 // Define register 2 as one hot code
`define OHR3 7'b00001000 // Define register 3 as one hot code
`define OHR4 7'b00010000 // Define register 4 as one hot code
`define OHR5 7'b00100000 // Define register 5 as one hot code
`define OHR6 7'b01000000 // Define register 6 as one hot code
`define OHR7 7'b10000000 // Define register 7 as one hot code

module regfile_tb;
reg write, clk; // bit input
reg [15:0] data_in; // 16 bit data input
reg [2:0] writenum, readnum; // 3 bit input for decoders
wire [15:0] data_out; // 16 bit data output
reg err; // error checker

regfile DUT(.write(write),.clk(clk),.data_in(data_in),.writenum(writenum),.readnum(readnum),.data_out(data_out)); //instantiate inputs and outputs of regfile module

task my_checker; // test function

input [15:0] expected_R0; // 16 bit expected value of register 0
input [15:0] expected_R1; // 16 bit expected value of register 1
input [15:0] expected_R2; // 16 bit expected value of register 2
input [15:0] expected_R3; // 16 bit expected value of register 3
input [15:0] expected_R4; // 16 bit expected value of register 4
input [15:0] expected_R5; // 16 bit expected value of register 5
input [15:0] expected_R6; // 16 bit expected value of register 6
input [15:0] expected_R7; // 16 bit expected value of register 7
input [15:0] expected_data_out; // 16 bit expected data output

begin
    if( DUT.R0 !== expected_R0) begin // if register 0 does not equate to expected register 0 value, outputs error message
        $display("ERROR ** R0 is %b, expected %b", DUT.R0, expected_R0);
        err = 1'b1; // sets error checker as 1 
end
    if( DUT.R1 !== expected_R1) begin // if register 0 does not equate to expected register 1 value, outputs error message
        $display("ERROR ** R1 is %b, expected %b", DUT.R1, expected_R1);
        err = 1'b1; // sets error checker as 1 
end
    if( DUT.R2 !== expected_R2) begin // if register 0 does not equate to expected register 2 value, outputs error message
        $display("ERROR ** R2 is %b, expected %b", DUT.R2, expected_R2);
        err = 1'b1; // sets error checker as 1 
end
    if( DUT.R3 !== expected_R3) begin // if register 0 does not equate to expected register 3 value, outputs error message
        $display("ERROR ** R3 is %b, expected %b", DUT.R3, expected_R3);
        err = 1'b1; // sets error checker as 1 
end
    if( DUT.R4 !== expected_R4) begin // if register 0 does not equate to expected register 4 value, outputs error message
        $display("ERROR ** R4 is %b, expected %b", DUT.R4, expected_R4);
        err = 1'b1; // sets error checker as 1 
end
    if( DUT.R5 !== expected_R5) begin // if register 0 does not equate to expected register 5 value, outputs error message
        $display("ERROR ** R5 is %b, expected %b", DUT.R5, expected_R5);
        err = 1'b1; // sets error checker as 1 
end
    if( DUT.R6 !== expected_R6) begin // if register 0 does not equate to expected register 6 value, outputs error message
        $display("ERROR ** R6 is %b, expected %b", DUT.R6, expected_R6);
        err = 1'b1; // sets error checker as 1 
end
    if( DUT.R7 !== expected_R7) begin // if register 0 does not equate to expected register 7 value, outputs error message
        $display("ERROR ** R7 is %b, expected %b", DUT.R7, expected_R7);
        err = 1'b1; // sets error checker as 1 
end
    if( data_out !== expected_data_out) begin
        $display("ERROR ** R7 is %b, expected %b", DUT.R7, expected_R7);
        err = 1'b1; // sets error checker as 1 
end    
end
endtask

initial begin 
    clk = 1'b0; #5; // initially sets clk at 0 
    forever begin // activates clock to alternate 5ps at a time
        clk = 1'b1; #5;
        clk = 1'b0; #5;
    end
end

initial begin

    err = 1'b0; // sets error initially at 0

    $display("checking to see if R3 has 42 value stored from write"); 
    writenum[2:0] = 3'b011; // tested writenum input
    data_in[15:0] = 16'd42; // tested data input
    write = 1'b1; // Activate tested write as 1
    #10; // delay 10ps
    my_checker(16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'd42, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx); // expected output of register 3
    
    $display("checking to see if R0 has 12 value stored from write"); 
    writenum[2:0] = 3'b000; // tested writenum input
    data_in[15:0] = 16'd12; // tested data input
    write = 1'b1;  // Activate tested write as 1
    #10; // delay 10ps
    my_checker(16'd12, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'd42, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx); // expected output of register 0
    
    $display("checking to see if R1 has 22 value stored from write"); 
    writenum[2:0] = 3'b001; // tested writenum input
    data_in[15:0] = 16'd22; // tested data input
    write = 1'b1; // Activate tested write as 1
    #10; // delay 10ps
    my_checker(16'd12, 16'd22, 16'bxxxxxxxx, 16'd42, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx); // expected output of register 1
    
    $display("checking to see if R2 has 32 value stored from write"); 
    writenum[2:0] = 3'b010; // tested writenum input
    data_in[15:0] = 16'd32; // tested data input
    write = 1'b1; // Activate tested write as 1
    #10; // delay 10ps
    my_checker(16'd12, 16'd22, 16'd32, 16'd42, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx); // expected output of register 2

    $display("checking to see if R0 with value 12 can be read"); 
    readnum[2:0] = 3'b000; // sets input of readnum
    #10; // delay 10ps
    my_checker(16'd12, 16'd22, 16'd32, 16'd42, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'bxxxxxxxx, 16'd12); /// expected output of data_out

end





endmodule