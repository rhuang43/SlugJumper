`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2023 04:28:40 PM
// Design Name: 
// Module Name: selector
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


module selector(
    input [3:0] sel,
    input [15:0] N,
    output [3:0] H
);

assign H = ({4{sel[0]}} & N[3:0] ) | ({4{sel[1]}} & N[7:4]) | ({4{sel[2]}}&N[11:8])| {4{sel[3]}} & N[15:12];
    
    

endmodule