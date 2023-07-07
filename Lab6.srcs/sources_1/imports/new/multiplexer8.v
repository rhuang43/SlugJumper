`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2023 04:15:13 PM
// Design Name: 
// Module Name: multiplexer8
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


module multiplexer8(
        input [7:0]i0,
        input [7:0]i1,
        output[7:0]out,
        input sub
    );
    multiplex Mult1 (.i0(i0[0]),.i1(i1[0]),.s(out[0]),.o(out[0]));
    multiplex Mult2 (.i0(i0[1]),.i1(i1[1]),.s(out[1]),.o(out[1]));
    multiplex Mult3 (.i0(i0[2]),.i1(i1[2]),.s(out[2]),.o(out[2]));
    multiplex Mult4 (.i0(i0[3]),.i1(i1[3]),.s(out[3]),.o(out[3]));
    multiplex Mult5 (.i0(i0[4]),.i1(i1[4]),.s(out[4]),.o(out[4]));
    multiplex Mult6 (.i0(i0[5]),.i1(i1[5]),.s(out[5]),.o(out[5]));
    multiplex Mult7 (.i0(i0[6]),.i1(i1[6]),.s(out[6]),.o(out[6]));
    multiplex Mult8 (.i0(i0[7]),.i1(i1[7]),.s(out[7]),.o(out[7]));
endmodule
