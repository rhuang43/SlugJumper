`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 07:28:03 PM
// Design Name: 
// Module Name: ringCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ringCounter(
    input clk,
    input Inc,
    output [3:0]Qput
    );
    wire[3:0]Q;
    assign Qput[3:0] = {Q[3],Q[2],Q[1],Q[0]};
    FDRE #(.INIT(1'b1) ) ringff1 (.C(clk), .R(0), .CE(Inc), .D(Q[3]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) ringff2 (.C(clk), .R(0), .CE(Inc), .D(Q[0]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) ringff3 (.C(clk), .R(0), .CE(Inc), .D(Q[1]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) ringff4 (.C(clk), .R(0), .CE(Inc), .D(Q[2]), .Q(Q[3]));
    
    
endmodule
