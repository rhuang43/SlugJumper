`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2023 12:46:05 PM
// Design Name: 
// Module Name: VGAController
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


module VGAController(
    input clk,

    output Hsync,
    output Vsync,
    output [14:0]pixelH,
    output [14:0]pixelV
    );
    wire resHor, resVer;
    wire Hs, Vs;
    
    assign resHor = (pixelH == 15'd799);
    assign resVer = (pixelV == 15'd524);
    assign Hsync = ~((pixelH < 15'd751) & (pixelH > 15'd654));
    assign Vsync = ~((pixelV > 15'd488) & (pixelV < 15'd491));
    counterUD15L C1 (.clk(clk),
                     .Up(1'b1),
                     .Dw(1'b0),
                     .inc(15'b000000000000000),
                     .Q(pixelH),
                     .Ld(resHor)
                     );
    counterUD15L C2(.clk(clk),
                     .Up(resHor),
                     .Dw(1'b0),
                     .inc(15'b000000000000000),
                     .Q(pixelV),
                     .Ld(resHor & resVer)
                     );
//    assign pH = pixelH;
//    wire [14:0]pixelV;
//    wire [14:0]pixelH;
//    assign pV = pixelV;
//    FDRE #(.INIT(1'b1) ) ff1 (.C(clk), .R(), .CE(), .D(Hs), .Q(Hsync));
//    FDRE #(.INIT(1'b1) ) ff2 (.C(clk), .R(), .CE(), .D(Vs), .Q(Vsync));
    
       
endmodule
