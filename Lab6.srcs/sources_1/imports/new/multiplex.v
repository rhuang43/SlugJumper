`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2023 01:53:20 PM
// Design Name: 
// Module Name: multiplex
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


module multiplex(
    input [7:0]i0,
    input [7:0]i1,
    input s,
    output [7:0]o
    );
    
    assign o = ({8{~s}} & i0) | ({8{s}} & i1);
endmodule
