module RFA(A, B, Cin, S, G, P);
    input logic A;
    input logic B;
    input logic Cin;
    output logic S;
    output logic P;
    output logic G;

    logic tempAND;

    assign P = A | B;
    assign G = A & B;

    assign tempAND = ~G & P;
    assign S = ~(Cin & tempAND) & (Cin | tempAND);

endmodule

module BCLG1(Cin, G, P, Cout);
    input logic Cin, G, P;
    output logic Cout;

    assign Cout = G | (P & Cin);
endmodule

module BCLG4(A, B, Cin, S, Gout, Pout);
    input logic [3:0] A;
    input logic [3:0] B;
    input logic Cin;
    output logic [3:0] S;
    output logic Gout, Pout;

    logic G0, G1, G2, G3;
    logic P0, P1, P2, P3;
    logic C1, C2, C3, C4;


    RFA RFA_Zero(A[0], B[0], Cin, S[0], G0, P0);
    BCLG1 BCLG1_Zero(Cin, G0, P0, C1);

    RFA RFA_One(A[1], B[1], C1, S[1], G1, P1);
    BCLG1 BCLG1_One(C1, G1, P1, C2);

    RFA RFA_Two(A[2], B[2], C2, S[2], G2, P2);
    BCLG1 BLCG1_Two(C2, G2, P2, C3);

    RFA RFA_Three(A[3], B[3], C3, S[3], G3, P3);
    BCLG1 BCLG1_Three(C3, G3, P3, C4);

    assign Gout = G3 | (P3 & G2) | (P3 & P2 & G1) | (P3 & P2 & P1 & G0);
    assign Pout = P3 & P2 & P1 & P0;
endmodule

module BCLG4_Teir2(A, B, Cin, S, Gout, Pout);
    input logic [15:0] A;
    input logic [15:0] B;
    input logic Cin;
    output logic [15:0] S;
    output logic Gout, Pout;

    logic G0, G1, G2, G3;
    logic P0, P1, P2, P3;
    logic C1, C2, C3, C4;

    BCLG4 BCLG4_Zero(A[3:0], B[3:0], Cin, S[3:0], G0, P0);
    BCLG1 BCLG1_Zero(Cin, G0, P0, C1);

    BCLG4 BCLG4_One(A[7:4], B[7:4], C1, S[7:4], G1, P1);
    BCLG1 BCLG1_One(C1, G1, P1, C2);

    BCLG4 BCLG4_Two(A[11:8], B[11:8], C2, S[11:8], G2, P2);
    BCLG1 BCLG1_Two(C2, G2, P2, C3);

    BCLG4 BCLG4_Three(A[15:12], B[15:12], C3, S[15:12], G3, P3);
    BCLG1 BCLG1_Three(C3, G3, P3, C4);

    assign Gout = G3 | (P3 & G2) | (P3 & P2 & G1) | (P3 & P2 & P1 & G0);
    assign Pout = P3 & P2 & P1 & P0;

endmodule

// 31-bit adder
module BCLG4_Teir3(A, B, Cin, S, Cout);
    input logic [30:0] A;
    input logic [30:0] B;
    input logic Cin;
    output logic [30:0] S;
    output logic Cout;

    logic [31:0] tempA, tempB, tempS;

    assign tempA[30:0] = A;
    assign tempA[31] = 1'b0;
    assign tempB[30:0] = B;
    assign tempB[31] = 1'b0;

    logic G0, G1;
    logic P0, P1;
    logic C1, C2;

    BCLG4_Teir2 BCLG4_Teir2_Zero(tempA[15:0], tempB[15:0], Cin, tempS[15:0], G0, P0);
    BCLG1 BCLG1_Zero(Cin, G0, P0, C1);

    BCLG4_Teir2 BCLG4_TEIR2_One(tempA[31:16], tempB[31:16], C1, tempS[31:16], G1, P1);
    BCLG1 BCLG1_One(C1, G1, P1, C2); //This may not be needed
    
    //Dont need Gout or Pout here

    assign S = tempS[30:0];
    assign Cout = tempS[31];

endmodule

// Brent/Kung adder
module Black(Gin, Pin, Gin2, Pin2, Gout, Pout);
    input logic Gin;
    input logic Pin;
    input logic Gin2;
    input logic Pin2;
    output logic Gout, Pout; 

    assign Gout = Gin | (Pin & Gin2);    
    assign Pout = Pin & Pin2;
endmodule

module White(Gin, Pin, Gout, Pout);
    input logic Gin, Pin;
    output logic Gout, Pout;

    assign Gout = Gin;
    assign Pout = Pin;
endmodule

module BKA(A, B, Cin, S, Cout);
    input logic [15:0] A, B;
    input logic Cin;
    output logic [15:0] S;
    output logic Cout;

    logic G0, G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12, G13, G14, G15;
    logic P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15;
    logic C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16;
    logic Gout1, Gout2, Gout3, Gout4, Gout5, Gout6, Gout7, Gout8, Gout9, Gout10, Gout11, Gout12, Gout13, Gout14, Gout15;
    logic Pout1, Pout2, Pout3, Pout4, Pout5, Pout6, Pout7, Pout8, Pout9, Pout10, Pout11, Pout12, Pout13, Pout14, Pout15;
    logic Gout3_1, Gout5_1, Gout7_1, Gout9_1, Gout11_1, Gout13_1, Gout15_1;
    logic Pout3_1, Pout5_1, Pout7_1, Pout9_1, Pout11_1, Pout13_1, Pout15_1;
    logic Gout7_2, Gout11_2, Gout15_2;
    logic Pout7_2, Pout11_2, Pout15_2;
    logic Gout15_3;
    logic Pout15_3;


    RFA RFA_Zero(A[0], B[0], Cin, S[0], G0, P0);
    BCLG1 BCLG1_Zero(Cin, G0, P0, C1);

    RFA RFA_One(A[1], B[1], C1, S[1], G1, P1);
    Black Black_One(G1, P1, G0, P0, Gout1, Pout1);
    BCLG1 BCLG1_One(C1, Gout1, Pout1, C2);

    RFA RFA_Two(A[2], B[2], C2, S[2], G2, P2);
    Black Black_Two(G2, P2, Gout1, Pout1, Gout2, Pout2);
    BCLG1 BCLG1_Two(C2, Gout2, Pout2, C3);

    RFA RFA_Three(A[3], B[3], C3, S[3], G3, P3);
    Black Black_Three_0(G3, P3, G2, P2, Gout3, Pout3);
    Black Black_Three_1(Gout3, Pout3, G1, P1, Gout3_1, Pout3_1);
    BCLG1 BCLG1_Three(C3, Gout3_1, Pout3_1, C4);

    RFA RFA_Four(A[4], B[4], C4, S[4], G4, P4);
    Black Black_Four(G4, P4, Gout3_1, Pout3_1, Gout4, Pout4);
    BCLG1 BCLG1_Four(C4, Gout4, Pout4, C5);

    RFA RFA_5(A[5], B[5], C5, S[5], G5, P5);
    Black Black_5_0(G5, P5, G4, P4, Gout5, Pout5);
    Black Black_5_1(Gout5, Pout5, Gout3_1, Pout3_1, Gout5_1, Pout5_1);
    BCLG1 BCLG1_5(C5, Gout5_1, Pout5_1, C6);

    RFA RFA_6(A[6], B[6], C6, S[6], G6, P6);
    Black Black_6(G6, P6, Gout5_1, Pout5_1, Gout6, Pout6);
    BCLG1 BCLG1_6(C6, Gout6, Pout6, C7);

    RFA RFA_7(A[7], B[7], C7, S[7], G7, P7);
    Black Black_7_0(G7, P7, G6, P6, Gout7, Pout7);
    Black Black_7_1(Gout7, Pout7, Gout5, Pout5, Gout7_1, Pout7_1);
    Black Black_7_2(Gout7_1, Pout7_1, Gout3_1, Pout3_1, Gout7_2, Pout7_2);
    BCLG1 BCLG1_7(C7, Gout7_2, Pout7_2, C8);

    RFA RFA_8(A[8], B[8], C8, S[8], G8, P8);
    Black Black_8(G8, P8, Gout7_2, Pout7_2, Gout8, Pout8);
    BCLG1 BCLG1_8(C8, Gout8, Pout8, C9);

    RFA RFA_9(A[9], B[9], C9, S[9], G9, P9);
    Black Black_9_0(G9, P9, G8, P8, Gout9, Pout9);
    Black Black_9_1(Gout9, Pout9, Gout7_2, Pout7_2, Gout9_1, Pout9_1);
    BCLG1 BCLG1_9(C9, Gout9, Pout9, C10);

    RFA RFA_10(A[10], B[10], C10, S[10], G10, P10);
    Black Black_10(G10, P10, Gout9_1, Pout9_1, Gout10, Pout10);
    BCLG1 BCLG1_10(C10, Gout10, Pout10, C11);

    RFA RFA_11(A[11], B[11], C11, S[11], G11, P11);
    Black Black_11_0(G11, P11, G10, P10, Gout11, Pout11);
    Black Black_11_1(Gout11, Pout11, Gout9, Pout9, Gout11_1, Pout11_1);
    Black Black_11_2(Gout11_1, Pout11_1, Gout7_2, Pout7_2, Gout11_2, Pout11_2);
    BCLG1 BCLG1_11(C11, Gout11_2, Pout11_2, C12);

    RFA RFA_12(A[12], B[12], C12, S[12], G12, P12);
    Black Black_12(G12, P12, Gout11_2, Pout11_2, Gout12, Pout12);
    BCLG1 BCLG1_12(C12, Gout12, Pout12, C13);

    RFA RFA_13(A[13], B[13], C13, S[13], G13, P13);
    Black Black_13_0(G13, P13, G12, P12, Gout13, Pout13);
    Black Black_13_1(Gout13, Pout13, Gout11_2, Pout11_2, Gout13_1, Pout13_1);
    BCLG1 BCLG1_13(C13, Gout13_1, Pout13_1, C14);

    RFA RFA_14(A[14], B[14], C14, S[14], G14, P14);
    Black Black_14(G14, P14, Gout13_1, Pout13_1, Gout14, Pout14);
    BCLG1 BCLG1_14(C14, Gout14, Pout14, C15);

    RFA RFA_15(A[15], B[15], C15, S[15], G15, P15);
    Black Black_15_0(G15, P15, G14, P14, Gout15, Pout15);
    Black Black_15_1(Gout15, Pout15, Gout13, Pout13, Gout15_1, Pout15_1);
    Black Black_15_2(Gout15_1, Pout15_1, Gout11_1, Pout11_1, Gout15_2, Pout15_2);
    Black Black_15_3(Gout15_2, Pout15_2, Gout7_2, Pout7_2, Gout15_3, Pout15_3);
    BCLG1 BCLG1_15(C15, Gout15_3, Pout15_3, C16);

    assign Cout = C16;
endmodule

module BKA_Teir2(A, B, Cin, S, Cout);
    input logic [30:0] A, B;
    input logic Cin;
    output logic [30:0] S;
    output logic Cout;

    logic [31:0] tempA, tempB, tempS;
    logic C1, C2;

    assign tempA[30:0] = A;
    assign tempA[31] = 1'b0;
    assign tempB[30:0] = B;
    assign tempB[31] = 1'b0;

    BKA BKA_Zero(tempA[15:0], tempB[15:0], Cin, tempS[15:0], C1);
    BKA BKA_One(tempA[31:16], tempB[31:16], C1, tempS[31:16], C2);

    assign S = tempS[30:0];
    assign Cout = tempS[31];

endmodule