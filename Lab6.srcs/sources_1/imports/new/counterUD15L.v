`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2023 04:17:23 PM
// Design Name: 
// Module Name: counterUD15L
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


module counterUD15L #(parameter INIT = 15'd0) (
    input [14:0]inc,
    input clk,
    input Ld,
    input Up,
    input Dw,
    
    output [14:0]Q,
    output dtc,
    output utc
    );
    wire [2:0]DTC;
    wire [2:0]UTC;
    
    
    
    countUD5L #(.INIT(INIT[4:0])) Vbitcounter_1(.clk(clk),.Up(Up),.LD(Ld),.D(inc[4:0]),.Q(Q[4:0]),.UTC(UTC[0]),.DTC(DTC[0]),.Dw(Dw));
    countUD5L #(.INIT(INIT[9:5])) Vbitcounter_2(.clk(clk),.Up(Up & UTC[0]),.LD(Ld),.D(inc[9:5]),.Q(Q[9:5]),.UTC(UTC[1]),.DTC(DTC[1]),.Dw(Dw & DTC[0]));
    countUD5L #(.INIT(INIT[14:10])) Vbitcounter_3(.clk(clk),.Up(Up & UTC[1] & UTC[0]),.LD(Ld),.D(inc[14:10]),.Q(Q[14:10]),.UTC(UTC[2]),.DTC(DTC[2]),.Dw(Dw & DTC[1] & DTC[0]));
    
    assign utc = UTC[0] & UTC[1] & UTC[2];
    assign dtc = DTC[0] & DTC[1] & DTC[2];
endmodule
