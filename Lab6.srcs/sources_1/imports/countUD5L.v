`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 03:10:18 PM
// Design Name: 
// Module Name: countUD5L
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:-
// 
//////////////////////////////////////////////////////////////////////////////////


module countUD5L #(parameter INIT = 5'd0)(
   input [4:0]D,
   input clk,
   input Dw,
   input Up,
   input LD,
   output UTC,
   output DTC,
   output [4:0]Q
    );
   wire [3:0]connectors;
   wire [4:0]Incrementer;
   wire [4:0]Decrementer;
   wire enable;
   wire out0;
   wire out1;
   wire out2;
   wire out3;
   wire out4;
    
    //enables us to enter data into flip-flops
    assign enable  = LD | (Dw ^ Up);
    assign Incrementer[4] = ((~Q[4] & Q[3] &  Q[2] & Q[1] & Q[0]) | (Q[4] & ~Q[3]) | (Q[4] & ~Q[2]) | (Q[4]& ~Q[1])| (Q[4]& ~Q[0]));
    assign Decrementer[4] =  ((~Q[4] & ~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[4] & Q[0]) | (Q[4] & Q[1]) | ( Q[4] & Q[2]) | (Q[4] & Q[3]));
    
    assign Incrementer[3] = ((~Q[3]&Q[2]&Q[1]&Q[0]) | (Q[3]&~Q[2]) | (Q[3]& ~Q[1])| (Q[3]&~Q[0]));
    assign Decrementer[3] = (~Q[3] & ~Q[2] & ~Q[1] & ~Q[0]) | (Q[3] & Q[0]) | (Q[3] & Q[1]) | (Q[3] & Q[2]);
    
    assign Incrementer[2]  = ((~Q[2] & Q[1] & Q[0]) | (Q[2] & ~Q[1]) | (Q[2] & ~Q[0]));
    assign Decrementer[2]  = ((~Q[2] & ~Q[1] & ~Q[0]) | (Q[2] & Q[0]) | (Q[2] & Q[1]));
    
    assign Incrementer[1] = ((~Q[1] & Q[0]) | (Q[1] & ~Q[0]));
    assign Decrementer[1] = ((~Q[1] & ~Q[0]) | (Q[1] & Q[0]));
    
    assign Incrementer[0] = ~Q[0] ;
    assign Decrementer[0] =  ~Q[0];
    
    assign out4 = ~LD & Up & Incrementer[4] | ~LD & Dw & Decrementer[4] | LD & D[4];
    assign out3 = ~LD & Up & Incrementer[3] | ~LD & Dw & Decrementer[3] | LD & D[3]; 
    assign out2 = ~LD & Up & Incrementer[2] | ~LD & Dw & Decrementer[2] | LD & D[2]; 
    assign out1 = ~LD & Up & Incrementer[1] | ~LD & Dw & Decrementer[1] | LD & D[1];
    assign out0 = ~LD & Up & Incrementer[0] | ~LD & Dw & Decrementer[0] | LD & D[0];
    
    assign UTC = Q[4] & Q[3] & Q[2] & Q[1] & Q[0];
    assign DTC = ~(Q[4] | Q[3] | Q[2] | Q[1] | Q[0]);
    

    //load to flip flop
    //allow is 1 if allowed else 0
    FDRE #(.INIT(INIT[0]) ) ff_instance_1095 (.C(clk), .R(0), .CE(enable), .D(out0), .Q(Q[0]));
    FDRE #(.INIT(INIT[1]) ) ff_instance_1096 (.C(clk), .R(0), .CE(enable), .D(out1), .Q(Q[1]));
    FDRE #(.INIT(INIT[2]) ) ff_instance_1097 (.C(clk), .R(0), .CE(enable), .D(out2), .Q(Q[2]));
    FDRE #(.INIT(INIT[3]) ) ff_instance_1098 (.C(clk), .R(0), .CE(enable), .D(out3), .Q(Q[3]));
    FDRE #(.INIT(INIT[4]) ) ff_instance_1099 (.C(clk), .R(0), .CE(enable), .D(out4), .Q(Q[4]));
    
    
    
    
    
    
    
    
    
   
    
    
    
    
    
    
endmodule
