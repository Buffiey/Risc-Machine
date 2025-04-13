module datapath(datapath_in, vsel, writenum, write, readnum, clk, loada, loadb, 
shift, asel, bsel, ALUop, loadc, loads, Z_out, datapath_out); 
input [15:0] datapath_in; // 16 bit input for datapath
input [2:0] writenum, readnum; // 3 bit input for register block 1
input [1:0] shift, ALUop; // 2 bit input for states
input vsel, asel, bsel, clk, write, loada, loadb, loadc, loads; // 1 bit inputs
wire Z; 
output reg Z_out; // 1 bit output from block 10
output reg [15:0] datapath_out; // 16 bit output from RISC machine
wire [15:0] data_in, data_out, loada_out, loadb_out, sout, Ain, Bin, out; // connected as input and output

MuxDatapath U0 (datapath_in, datapath_out, vsel, data_in); // instantiate of input and outputs for datapath multiplexer
regfile REGFILE (data_in, writenum, write, readnum, clk, data_out); // instantiate of input and outputs for register file
loadR loadA (clk, loada, data_out, loada_out); // instantiate of input and outputs for block A
loadR loadB (clk, loadb, data_out, loadb_out); // instantiate of input and outputs for block B
shifter U4 (loadb_out, shift, sout ); // instantiate of input and outputs for shifter
MuxA U5 (asel, loada_out, Ain); // instantiate of input and outputs for multiplexer A
MuxB U6 ({11'b0, datapath_in[4:0]}, bsel, sout, Bin); // instantiate of input and outputs for multiplexer B
ALU U7 (Ain, Bin, ALUop, out, Z); // instantiate of input and outputs for ALU
loadR loadstatus (clk, loads, Z, Z_out); // instantiate of input and outputs for block status
loadR loadC (clk, loadc, out, datapath_out); // instantiate of input and outputs for block C

endmodule

module loadR(clk, en, data_out, loadR_out); // inputs and outputs of module
 input clk, en ; // cloak and selector
 input [15:0] data_out; // data input from previous outputs
 output [15:0] loadR_out; // data output of block
 reg [15:0] loadR_out; // set output as register
 wire [15:0] next_out;
 assign next_out = en ? data_out : loadR_out; // if selector is true, next_out equals data_out, otherwise it equals loadr_out
 always @(posedge clk) // when there is a rising edge of cloak
 loadR_out = next_out; // sets output value into output
endmodule

module MuxA(asel, loada_out, Ain); // inputs and outputs of module
    input [15:0] loada_out; // data output of block
    input asel; // selector for multiplexer A
    output reg [15:0] Ain; // output of multiplexer A
    always_comb begin // combinational logic block
        case (asel) // 2 states with 2 cases
            1'b1: Ain = 16'b0; // if selector is 1, Ain is 0, otherwise, Ain is loada_out
            1'b0: Ain = loada_out; // if selector is 0, Ain is output of load a block
        endcase
    end
endmodule

module MuxB(datapath_in ,bsel, sout, Bin); // inputs and outputs of module
    input [15:0] sout; // input from output of shifter block
    input [15:0] datapath_in; // 16 bit input for multiplexer B
    input bsel; // selector for multiplexer B
    output reg [15:0] Bin; // output of multiplexer B
    always_comb begin // combinational logic block
        case (bsel) // 2 states with 2 cases
            1'b1: Bin = {11'b0, datapath_in[4:0]}; // if selector b is 1, sets Bin as value of 11'b0 concatinated with datapath_in
            1'b0: Bin = sout; // if selector b is 0, sets Bin as shift output
        endcase
    end
endmodule

module MuxDatapath(datapath_in, datapath_out, vsel, data_in); // inputs and outputs of module
    input [15:0] datapath_in, datapath_out; // 16 bit inputs for datapath multiplexer
    input vsel; // 1 bit input for multiplexer selector
    output reg [15:0] data_in; // 16 bit data output from datapath multiplexer
    always_comb begin // combinational logic block
        case (vsel) // 2 cases 
            1'b1: data_in = datapath_in; // if selector is 1, data equals datapath input
            1'b0: data_in = datapath_out; // if selector is 0, data equals datapath output
        endcase
    end
endmodule