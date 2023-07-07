`timescale 1ns / 1ps

module LFSR(
    input clk,
    output [7:0] Q
    );

    wire [7:0] random;
    wire [0:0] register;
    assign register[0] = (random[0] ^ random[5] ^ random[6] ^ random[7]);
    
    FDRE #(.INIT(1'b1)) ff_0 (.C(clk),.R(1'b0), .CE(1'b1), .D(register[0]), .Q(random[0]));
    FDRE #(.INIT(1'b0)) ff_1 (.C(clk),.R(1'b0), .CE(1'b1), .D(random[0]), .Q(random[1]));
    FDRE #(.INIT(1'b0)) ff_2 (.C(clk),.R(1'b0), .CE(1'b1), .D(random[1]), .Q(random[2]));
    FDRE #(.INIT(1'b0)) ff_3 (.C(clk),.R(1'b0), .CE(1'b1), .D(random[2]), .Q(random[3]));
    FDRE #(.INIT(1'b0)) ff_4 (.C(clk),.R(1'b0), .CE(1'b1), .D(random[3]), .Q(random[4]));
    FDRE #(.INIT(1'b0)) ff_5 (.C(clk),.R(1'b0), .CE(1'b1), .D(random[4]), .Q(random[5]));
    FDRE #(.INIT(1'b0)) ff_6 (.C(clk),.R(1'b0), .CE(1'b1), .D(random[5]), .Q(random[6]));
    FDRE #(.INIT(1'b0)) ff_7 (.C(clk),.R(1'b0), .CE(1'b1), .D(random[6]), .Q(random[7]));

    assign Q[7:0] = random[7:0];

endmodule