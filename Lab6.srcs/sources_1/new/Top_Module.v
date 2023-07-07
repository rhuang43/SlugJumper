`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2023 03:01:55 PM
// Design Name: 
// Module Name: Top_Module
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


module Top_Module(
    input btnU,  
    input btnD, 
    input btnC,  
    input btnR,  //btnR is the global reset in S23 Lab6
    input btnL,  
    input clkin, 
    output [6:0]seg, 
    output dp, 
    output [3:0]an,
    output [3:0]vgaBlue,
    output [3:0]vgaRed,
    output [3:0]vgaGreen,        
    output Vsync, 
    output Hsync, 
    input [15:0]sw, 
    output [15:0]led
    );
    
    wire [14:0] pH;
    wire [14:0] pV;
    wire [3:0] vgaR;
    wire [3:0] vgaB;
    wire [3:0] vgaG;
    wire Top, Left, Right, Bottom, digsel, clk, active, Border, pond, start, pinned, stopper, bug_colli_confirm, frame, flash, wet;
    wire left_colli_confirm;
    wire bug_colli, bug_flash;
    wire [14:0]slugPLR;
    wire [14:0]platwidth;
    wire [3:0] randowidth;
    wire topP, bottomP, leftP, rightP;
    wire [14:0]pixelP;
    wire [14:0]pixelF, pixelG;
    
    
    //frame counter
    assign frame = (pH == 10'd799) & (pV == 10'd485);
    counterUD15L #(.INIT(15'd0)) framcounter (.clk(clk),.Up(frame & (wet | left_colli_confirm)),.Ld(pixelF == 15'd129), .inc(15'd0),.Q(pixelF));
    counterUD15L #(.INIT(15'd0)) bugblinker (.clk(clk),.Up(frame & (bug_colli_confirm)),.Ld(pixelG == 15'd119), .inc(15'd0),.Q(pixelG));
    //start
    FDRE #(.INIT(1'b0)) starting (.C(clk),.R(1'b0), .CE(btnC), .D(1'b1), .Q(start));
    
    //platform stopper
     //assign top left right and bottom border for VGA Blue
    labVGA_clks not_so_slow (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
    VGAController VGA (.clk(clk),.pixelH(pH),.pixelV(pV),.Hsync(Hsync),.Vsync(Vsync));
    
    
    assign active = (pH <= 639) & (pV <=479);
    
    //border
    assign Top = (pV < 8) & active;
    assign Left = (pH < 8) & active;
    assign Right = ((pH < 640) & (pH > 632)) & active;
    assign Bottom = (pV < 480) & (pV > 472) & active;
    
    assign Border = Top | Left | Right | Bottom;
    
    //pond
    
    assign pond = ((pV >= 350) & active) & ~Border;
    
    //platform 1
    assign frame = (pH == 10'd799) & (pV == 10'd485);
    counterUD15L #(.INIT(15'd300)) platsize (.clk(clk),.Dw(~bug_colli_confirm & frame & start & ~pinned),.Ld((pixelP <= 15'd0)), .inc(15'd900),.Q(pixelP));
    //252-128=124 / 31 = 4 
    LFSR rando(.clk(clk),.Q(randowidth));
//    assign randowidth[7:4] = 1'b0;
    wire [3:0]randonum;
    FDRE #(.INIT(1'b1)) r1 [3:0] (.C(clk),.R(1'b0), .CE((pixelP <= 15'd0) & start), .D(randowidth), .Q(randonum));
    
    assign platwidth = (randonum[1:0] * 15'd32) + 15'd128;
    
    assign leftP = pH + platwidth;
    //The top vertical coordinate of the platforms is 200
    
    wire platform;
    assign platform = (pH + platwidth >= pixelP) & (pH <=  pixelP)& (pV <= 10'd207) & (pV >= 10'd200) & ~Border;
    
    
    
    //platform 2
    wire [14:0]platwidth2;
    wire [3:0] randowidth2;
    wire frame2, topP2, bottomP2, leftP2, rightP2;
    wire [14:0]pixelP2;
    assign frame2 = (pH == 10'd799) & (pV == 10'd485);
    counterUD15L #(.INIT(15'd900)) platsize2 (.clk(clk),.Dw(~bug_colli_confirm & frame & start & ~pinned),.Ld((pixelP2 <= 15'd0)), .inc(15'd900),.Q(pixelP2));
    //252-128=124 / 31 = 4 
    LFSR rando2(.clk(clk),.Q(randowidth2));
//    assign randowidth[7:4] = 1'b0;
    wire [3:0]randonum2;
    FDRE #(.INIT(1'b1)) r2 [3:0] (.C(clk),.R(1'b0), .CE(pixelP2 <= 15'd0), .D(randowidth2), .Q(randonum2));
    
    assign platwidth2 = (randonum2[1:0] * 15'd32) + 15'd128;
    
    assign leftP2 = pH + platwidth2;
    //The top vertical coordinate of the platforms is 200
    
    wire platform2;
    assign platform2 = (pH + platwidth2 >= pixelP2) & (pH <=  pixelP2)& (pV <= 10'd207) & (pV >= 10'd200) & ~Border;
    
     //platform 3
    wire [14:0]platwidth3;
    wire [3:0] randowidth3;
    wire frame3, topP3, bottomP3, leftP3, rightP3;
    wire [14:0]pixelP3;
    assign frame3 = (pH == 10'd799) & (pV == 10'd485);
    counterUD15L #(.INIT(15'd600)) platsize3 (.clk(clk),.Dw(~bug_colli_confirm & frame & start & ~pinned),.Ld((pixelP3 <= 15'd0)), .inc(15'd900),.Q(pixelP3));
    //252-128=124 / 31 = 4 
    LFSR rando3(.clk(clk),.Q(randowidth3));
//    assign randowidth[7:4] = 1'b0;
    wire [3:0]randonum3;
    FDRE #(.INIT(1'b1)) r3 [3:0] (.C(clk),.R(1'b0), .CE(pixelP3 <= 15'd0), .D(randowidth3), .Q(randonum3));
    
    assign platwidth3 = (randonum3[1:0] * 15'd32) + 15'd128;
    
    assign leftP3 = pH + platwidth3;
    //The top vertical coordinate of the platforms is 200 
    
    wire platform3;
    assign platform3 = (pH + platwidth3 >= pixelP3) & (pH <=  pixelP3)& (pV <= 10'd207) & (pV >= 10'd200) & ~Border;
    
    
   //bug generator
    wire [14:0]bug;
    wire [2:0] position;
    wire frameS, topPB, bottomPB, leftPB, rightPB;
    wire [14:0]pixelPB;
    assign frameS = (pH == 15'd799) & (pV == 15'd480);
    counterUD15L #(.INIT(15'd642)) bugGo (.clk(clk),.Dw(~bug_colli_confirm & (frameS | frame) & start),.Ld((pixelPB <= 15'd0) | (pixelG >= 15'd119)), .inc(15'd642),.Q(pixelPB));
    //252-128=124 / 31 = 4 
    LFSR randoB(.clk(clk),.Q(position));
//    assign randowidth[7:4] = 1'b0;
    wire [2:0]randopos;
    FDRE #(.INIT(1'b1)) rB [2:0] (.C(clk),.R(((pixelPB <= 15'd0) | (pixelG >= 15'd199)) & bug_colli_confirm), .CE((pixelPB <= 15'd0)), .D(position), .Q(randopos));
  
    
    wire [9:0] bugspot;
    //top gen
//    assign bugspot[7] = 1'b1;
    assign bugspot[4:2] = randopos[2:0];
    
    assign bugspot[6:5] = 1'b0;
    assign bugspot[1:0] = 1'b0;
    
    wire[1:0]opA, opB;
    
    assign opA[1:0] = 2'd1;
    assign opB[1:0] = 2'd2;
    
    wire tOb;
    wire holding_rtOb;
    
    LFSR rtOb(.clk(clk),.Q(holding_rtOb));
    wire why;
    assign why = ((pixelPB <= 15'd0) | (pixelG == 15'd119));
    FDRE #(.INIT(1'b1)) hrtOb [3:0] (.C(clk),.R(), .CE(why), .D(holding_rtOb), .Q(tOb));
    multiplex multi(.i0(opA),.i1(opB),.s(tOb),.o(bugspot[8:7]));
    
    wire bugger;
    assign bugger = (pH + 15'd8 >= pixelPB) & (pH <=  pixelPB) & (pV >= bugspot) & (pV <= bugspot + 15'd8) & ~Border & ~bug_flash;
    
    //counter - lsfr to get the size
    //grab a frame to get the timing
    //decrement with another counter to move
    //Banana Tree Kicker
    wire slug, slugTop, slugBot, sluglef, slugrig, slugH;
    wire [14:0]slugP;
//    assign slugS = (pH >= 15'd140) & (pH <= 15'd156);
////    assign slugL = slugH + 15'd16;
////    assign slugB = (pV == 15'd199);
//    assign slugH = (pV >= 15'd184) & (pV <= 15'd199);
//    assign slug = slugH & slugS;
    
    
    //slug collison
    wire platcolli;
    assign platcolli = (((pixelP3 <= platwidth3) | ((pixelP3 - platwidth3) <= 10'd155)) & (pixelP3 >= 10'd140)) |
                       (((pixelP2 <= platwidth2) | ((pixelP2 - platwidth2) <= 10'd155)) & (pixelP2 >= 10'd140)) |
                       (((pixelP <= platwidth) | ((pixelP - platwidth) <= 10'd155)) & (pixelP >= 10'd140))
                        ;
    
    wire top_colli, bot_colli, left_colli, ceiling;
    
    assign pinned = slugPLR == 8;
    assign stopper = slugPLR <= 8 & (((pixelP3 - platwidth3 - 10'd1) == 10'd6) |
                        ((pixelP2 - platwidth2 - 10'd1) == 10'd6) |
                        ((pixelP - platwidth - 10'd1) == 10'd6));
    
    assign top_colli = platcolli & (slugP == 10'd199);
    assign bot_colli = platcolli & ((slugP - 10'd15) == 10'd208);
    assign left_colli = (((pixelP3 - platwidth3 - 10'd1) == 10'd155) |
                        ((pixelP2 - platwidth2 - 10'd1) == 10'd155) |
                        ((pixelP - platwidth - 10'd1) == 10'd155)) &
                        (slugP >= 10'd200) & (slugP - 10'd15 <= 10'd207);
    
    assign bug_colli = (((pixelPB == 10'd140) | (pixelPB - 10'd8 == 10'd154)) & (bugspot - 10'd1 <= slugP) & ((bugspot + 10'd8) >= (slugP - 10'd15)))
                       | (((pixelPB + 10'd1) >= 10'd140) & (pixelPB - 10'd8 <= 10'd155)) & ((bugspot - 10'd1 == slugP) | ((bugspot + 10'd8) == (slugP - 10'd15)))
                        ;
                        
    wire bugres;
    assign bugres = pixelG < 119;
    FDRE #(.INIT(1'b0)) left_BAM (.C(clk),.R(1'b0), .CE(1'b1), .D(left_colli | left_colli_confirm ), .Q(left_colli_confirm));
    FDRE #(.INIT(1'b0)) bug_smack (.C(clk),.R(1'b0), .CE(1'b1), .D((bug_colli | bug_colli_confirm) & bugres), .Q(bug_colli_confirm));                 
    assign wet = (slugP > 15'd350);
    assign ceiling = (slugP - 10'd15 < 15'd9);
//    assign led[0] = left_colli_confirm;
//    assign led[1] = top_colli;
//    assign led[2] = bot_colli;
//    assign led[15] = wet;
//    assign led[5] = bug_colli_confirm;
    
    wire FlashTiming, BugFlashTiming;
    
   assign BugFlashTiming = (((pixelG) > 0) & ((pixelG) <= 10)) | (((pixelG) >= 20) & ((pixelG) <= 30)) |
                        (((pixelG) >= 40) & ((pixelG) <= 50)) | (((pixelG) >= 60) & ((pixelG) <= 70)) |
                        (((pixelG) >= 80) & ((pixelG) <= 90)) | (((pixelG) >= 100) & ((pixelG) <= 110));
                        
                        
   assign FlashTiming = (((pixelF) > 0) & ((pixelF) <= 10)) | ((pixelF >= 10) & ((pixelF) <= 20)) |  ((pixelF >= 30) & (pixelF <= 40)) | ((pixelF >= 50) & (pixelF <= 60)) | ((pixelF >= 70) & (pixelF <= 80)) |
                           ((pixelF >= 90) & (pixelF <= 100))|
                           ((pixelF >= 110) & (pixelF <= 120));
    
    
   // assign led[10] = FlashTiming;
    assign flash = (left_colli_confirm | wet) & FlashTiming;
    assign bug_flash = bug_colli_confirm & BugFlashTiming;
    
    
    
    //////////////////////////////////////////////////////////////////
    counterUD15L #(.INIT(15'd199)) slugGo (.clk(clk),.Up((frameS | frame) & ~btnU & ~top_colli & ~bot_colli & ~left_colli_confirm & ~wet),
                    .Dw((frameS |frame) & btnU & ~bot_colli & ~left_colli_confirm & ~wet & ~ceiling),.Q(slugP));
    counterUD15L #(.INIT(15'd140)) slugGoLR (.clk(clk),.Up(),
                    .Dw((frame) & left_colli_confirm & ~pinned),.Q(slugPLR));
//    assign slugrig = pH + 15'd16 >= slugP;
//    assign sluglef = pH <= slugP;
//    assign slugTop = slugH >= pV;
//    assign slugBot = slugH <= pV + 15'd16;
//    assign slug = slugrig & sluglef & slugTop & slugBot;
    wire [3:0]ringOutput;
    wire [15:0]out;
    wire [3:0]H;
    counterUD15L #(.INIT(15'd0)) slugPoint (.clk(clk),.Up((pixelG == 10'd119)),
                    .Dw(),.Q(out));
    ringCounter rc(.Qput(ringOutput[3:0]),.Inc(digsel),.clk(clk));
    selector sellout(.sel(ringOutput[3:0]),.N(out[15:0]),.H(H[3:0]));
    hex7seg s7eg(.n(H[3:0]),.seg(seg));
    assign slug = (pH >= slugPLR) & (pH < slugPLR + 10'd16) & (pV <= slugP) & (pV >= (slugP - 10'd15)) & ~flash;
    assign vgaRed = ({4{active}} & {4{Border}} & {4'b0000}) |
                    ({4{active}} & {4{platform}} & {4'b1111}) |
                    ({4{active}} & {4{platform2}} & {4'b1111}) |
                    ({4{active}} & {4{platform3}} & {4'b1111}) |
                    ({4{active}} & {4{slug}} & {4'b1111})
                    ;
    assign vgaBlue = ({4{active}} & {4{Border}} & {4'b1111}) |
                     ({4{active}} & {4{pond}} & {4'b1111}) |
                     ({4{active}} & {4{platform}} & {4'b1111}) |
                     ({4{active}} & {4{platform2}} & {4'b1111}) 
                     ;
    assign vgaGreen = ({4{active}} & {4{Border}} & {4'b0000}) | 
                      ({4{active}} & {4{pond}} & {4'b1111}) |
                      ({4{active}} & {4{platform2}} & {4'b1111}) |
                      ({4{active}} & {4{slug}} & {4'b1111}) |
                      ({4{active}} & {4{bugger}} & {4'b1111})
                      ;
    
    assign an = ~ringOutput[1:0];

endmodule