`define OHR0 7'b00000001 // defines register 0 as one hot
`define OHR1 7'b00000010 // defines register 1 as one hot
`define OHR2 7'b00000100 // defines register 2 as one hot
`define OHR3 7'b00001000 // defines register 3 as one hot
`define OHR4 7'b00010000 // defines register 4 as one hot
`define OHR5 7'b00100000 // defines register 5 as one hot
`define OHR6 7'b01000000 // defines register 6 as one hot
`define OHR7 7'b10000000 // defines register 7 as one hot

module datapath_tb;
reg vsel, write, clk, loada, loadb, asel, bsel, loadc, loads; // sets 1 bit inputs
reg [1:0] shift, ALUop; // sets 2 bit inputs
reg [2:0] writenum, readnum; // sets 3 bit inputs
reg [15:0] datapath_in; // sets 16 bit inputs
wire Z_out; // sets 1 bit output
wire [15:0] datapath_out; // sets 16 bit output
reg err; // sets 1 bit input

datapath DUT(.datapath_in(datapath_in), .vsel(vsel), .writenum(writenum), .write(write), .readnum(readnum), 
.clk(clk), .loada(loada), .loadb(loadb), .shift(shift), .asel(asel), .bsel(bsel), .ALUop(ALUop), .loadc(loadc),
 .loads(loads), .Z_out(Z_out), .datapath_out(datapath_out)); // instantiates input and outputs

task my_checker; // checker function

input [15:0] expected_R0; // expected value of register 0
input [15:0] expected_R1; // expected value of register 1
input [15:0] expected_R2; // expected value of register 2


begin
    if( datapath_tb.DUT.REGFILE.R0 !== expected_R0) begin // test condition where if expected register 0 value does not equal register 0 value
        $display("ERROR ** R0 is %b, expected %b", datapath_tb.DUT.REGFILE.R0, expected_R0);
        err = 1'b1;
end
    if( datapath_tb.DUT.REGFILE.R1 !== expected_R1) begin // test condition where if expected register 1 value does not equal register 1 value
        $display("ERROR ** R1 is %b, expected %b", datapath_tb.DUT.REGFILE.R1, expected_R1);
        err = 1'b1;
end
    if( datapath_tb.DUT.REGFILE.R2 !== expected_R2) begin // test condition where if expected register 2 value does not equal register 2 value
        $display("ERROR ** R2 is %b, expected %b", datapath_tb.DUT.REGFILE.R2, expected_R2);
        err = 1'b1;
end
  
end
endtask

initial begin // clock 
    clk = 1'b0; #5; // initially sets clock as 0
    forever begin // alternates clock between on and off
        clk = 1'b1; #5; 
        clk = 1'b0; #5;
    end
end

initial begin

    err = 1'b0; // sets error initially at 0

    $display("checking to see if R2 = R1 + R0 * 2"); 
    datapath_in = 16'd7; //load 7 in binary on datapath
    vsel = 1'b1; //vsel is 1 thus data_in has 7 in binary
    writenum = 3'b000; //writes into register 0
    write = 1'b1; //write is 1 so on next clk cycle it will write into the register
    #10;
    datapath_in = 16'd2; //load 2 in binary on datapath
    vsel = 1'b1; //vsel is 1 data_in has 12 2 binary
    writenum = 3'b001; //write to register 1
    write = 1'b1; //write is 1 so next clk cycle it will write into the register
    #10;
    write = 1'b0; //write is 0 so no longer writing
    readnum = 3'b001; //reading from register 1
    loada = 1'b1; //send it towards A branch
    #10;
    loada = 1'b0; //loada is 0 
    readnum = 3'b000; //load from register 0
    loadb = 1'b1; //send it towards B branch
    #10;
    loadb = 1'b0; //loadb is 0
    shift = 2'b01; // go through shifter and operation is << 1 so 01
    asel = 1'b0; //asel is 0
    bsel = 1'b0; //bsel is 0
    ALUop = 2'b00; //adding so select 00 for ALU
    loadc = 1'b1; //loadC is 1 so send to C 
    #10;
    vsel = 1'b0; //vsel is 0 so we can write our addition to the datapath
    writenum = 3'b010; //write to register 2 the addition of r0 and r1
    write = 1'b1; //write is 1 so it gets sent to the register
    #10;
    my_checker(16'd7,16'd2,16'd16); //check if the register should have all the values

end





endmodule