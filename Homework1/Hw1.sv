module halfAdder(A, B, S, Cout);
    input logic A;
    input logic B;
    output logic S;
    output logic Cout;
    assign S = A ^ B;
    assign Cout = A & B;
endmodule

module fullAdder(A, B, Cin, S, Cout);
    input logic A;
    input logic B;
    input logic Cin;
    output logic S;
    output logic Cout;

    logic temp;

    assign temp = A ^ B;

    assign S = temp ^ Cin;
    assign Cout = (temp & Cin) | (A & B);
endmodule

module adder4(A, B, Cin, S, Cout);
    input logic [3:0] A;
    input logic [3:0] B;
    input logic Cin;
    output logic [3:0] S;
    output logic Cout;

    wire w0, w1, w2;

    fullAdder add0(A[0], B[0], Cin, S[0], w0);
    fullAdder add1(A[1], B[1], w0, S[1], w1);
    fullAdder add2(A[2], B[2], w1, S[2], w2);
    fullAdder add3(A[3], B[3], w2, S[3], Cout);
endmodule

module adder8(A, B, Cin, S, Cout);
    input logic [7:0] A;
    input logic [7:0] B;
    input logic Cin;
    output logic [7:0] S;
    output logic Cout;

    wire w0;

    adder4 add0(A[3:0], B[3:0], Cin, S[3:0], w0);
    adder4 add1(A[7:4], B[7:4], w0, S[7:4], Cout);
endmodule

module adder16(A, B, Cin, S, Cout);
    input logic [15:0] A;
    input logic [15:0] B;
    input logic Cin;
    output logic [15:0] S;
    output logic Cout;

    wire w0, w1, w2;

    adder4 add0(A[3:0], B[3:0], Cin, S[3:0], w0);
    adder4 add1(A[7:4], B[7:4], w0, S[7:4], w1);
    adder4 add2(A[11:8], B[11:8], w1, S[11:8], w2);
    adder4 add3(A[15:12], B[15:12], w2, S[15:12], Cout);
endmodule

module adder32(A, B, Cin, S, Cout);
    input logic [31:0] A;
    input logic [31:0] B;
    input logic Cin;
    output logic [31:0] S;
    output logic Cout;

    wire w0;

    adder16 add0(A[15:0], B[15:0], Cin, S[15:0], w0);
    adder16 add1(A[31:16], B[31:16], w0, S[31:16], Cout);
endmodule

module adder64(A, B, Cin, S, Cout);
    input logic [63:0] A;
    input logic [63:0] B;
    input logic Cin;
    output logic [63:0] S;
    output logic Cout;

    wire w0, w1, w2;

    adder16 add0(A[15:0], B[15:0], Cin, S[15:0], w0);
    adder16 add1(A[31:16], B[31:16], w0, S[31:16], w1);
    adder16 add2(A[47:32], B[47:32], w1, S[47:32], w2);
    adder16 add3(A[63:48], B[63:48], w2, S[63:48], Cout);
endmodule

module adder128(A, B, Cin, S, Cout);
    input logic [127:0] A;
    input logic [127:0] B;
    input logic Cin;
    output logic [127:0] S;
    output logic Cout;

    wire w0;

    adder64 add0(A[63:0], B[63:0], Cin, S[63:0], w0);
    adder64 add1(A[127:64], B[127:64], w0, S[127:64], Cout);
endmodule

module multiplier(A, B, S);
    input logic [1:0] A;
    input logic [1:0] B;
    output logic [3:0] S;

    logic temp00, temp10, temp01, temp11;
    wire w1;

    assign temp00 = A[0] & B[0];
    assign temp10 = A[1] & B[0];
    assign temp01 = A[0] & B[1];
    assign temp11 = A[1] & B[1];

    assign S[0] = temp00;
    halfAdder add1(temp10, temp01, S[1], w1);
    halfAdder add2(w1, temp11, S[2], S[3]);
endmodule
    
module multiplier4(A, B, S);
    input logic [3:0] A;
    input logic [3:0] B;
    output logic [7:0] S;

    // ab * cd = (a+b) * (c+d) = ac << 4 + ad << 2 + bc << 2 + bd << 0;
    // a = A[3:2]
    // b = A[1:0]
    // c = B[3:2]
    // d = B[1:0]
    logic [3:0] ac, ad, bc, bd;
    logic [7:0] tempAC, tempAD, tempBC, tempBD;

    multiplier mult1(A[3:2], B[3:2], ac);
    multiplier mult2(A[3:2], B[1:0], ad);
    multiplier mult3(A[1:0], B[3:2], bc);
    multiplier mult4(A[1:0], B[1:0], bd);

    assign tempAC[7:4] = ac;
    assign tempAC[3:0] = 4'b0;

    assign tempAD[7:6] = 2'b0;
    assign tempAD[5:2] = ad;
    assign tempAD[1:0] = 4'b0;

    assign tempBC[7:6] = 2'b0;
    assign tempBC[5:2] = bc;
    assign tempBC[1:0] = 4'b0;

    assign tempBD[7:4] = 4'b0;
    assign tempBD[3:0] = bd;

    logic [7:0] tempOut1, tempOut2, tempOut;
    wire null1, null2, null3;

    adder8 add1(tempAC, tempBD, 1'b0, tempOut1, null1);
    adder8 add2(tempAD, tempBC, 1'b0, tempOut2, null2);
    adder8 add3(tempOut1, tempOut2, 1'b0, tempOut, null3);

    assign S = tempOut;

endmodule

module multiplier8(A, B, S);
    input logic [7:0] A;
    input logic [7:0] B;
    output logic [15:0] S;

    // ab * cd = (a+b) * (c+d) = ac << 4 + ad << 2 + bc << 2 + bd << 0;
    // a = A[3:2]
    // b = A[1:0]
    // c = B[3:2]
    // d = B[1:0]
    logic [7:0] ac, ad, bc, bd;
    logic [15:0] tempAC, tempAD, tempBC, tempBD;

    multiplier4 mult1(A[7:4], B[7:4], ac);
    multiplier4 mult2(A[7:4], B[3:0], ad);
    multiplier4 mult3(A[3:0], B[7:4], bc);
    multiplier4 mult4(A[3:0], B[3:0], bd);

    assign tempAC[15:8] = ac;
    assign tempAC[7:0] = 4'b0;

    assign tempAD[15:12] = 4'b0;
    assign tempAD[11:4] = ad;
    assign tempAD[3:0] = 4'b0;

    assign tempBC[15:12] = 4'b0;
    assign tempBC[11:4] = bc;
    assign tempBC[3:0] = 4'b0;

    assign tempBD[15:8] = 4'b0;
    assign tempBD[7:0] = bd;

    logic [15:0] tempOut1, tempOut2, tempOut;
    wire null1, null2, null3;

    adder16 add1(tempAC, tempBD, 1'b0, tempOut1, null1);
    adder16 add2(tempAD, tempBC, 1'b0, tempOut2, null2);
    adder16 add3(tempOut1, tempOut2, 1'b0, tempOut, null3);

    assign S = tempOut;

endmodule
    
module multiplier16(A, B, S);
    input logic [15:0] A;
    input logic [15:0] B;
    output logic [31:0] S;

    // ab * cd = (a+b) * (c+d) = ac << 4 + ad << 2 + bc << 2 + bd << 0;
    // a = A[3:2]
    // b = A[1:0]
    // c = B[3:2]
    // d = B[1:0]
    logic [15:0] ac, ad, bc, bd;
    logic [31:0] tempAC, tempAD, tempBC, tempBD;

    multiplier8 mult1(A[15:8], B[15:8], ac);
    multiplier8 mult2(A[15:8], B[7:0], ad);
    multiplier8 mult3(A[7:0], B[15:8], bc);
    multiplier8 mult4(A[7:0], B[7:0], bd);

    assign tempAC[31:16] = ac;
    assign tempAC[15:0] = 16'b0;

    assign tempAD[31:24] = 8'b0;
    assign tempAD[23:8] = ad;
    assign tempAD[7:0] = 8'b0;

    assign tempBC[31:24] = 8'b0;
    assign tempBC[23:8] = bc;
    assign tempBC[7:0] = 8'b0;

    assign tempBD[31:16] = 16'b0;
    assign tempBD[15:0] = bd;

    logic [31:0] tempOut1, tempOut2, tempOut;
    wire null1, null2, null3;

    adder32 add1(tempAC, tempBD, 1'b0, tempOut1, null1);
    adder32 add2(tempAD, tempBC, 1'b0, tempOut2, null2);
    adder32 add3(tempOut1, tempOut2, 1'b0, tempOut, null3);

    assign S = tempOut;

endmodule

module multiplier32(A, B, S);
    input logic [31:0] A;
    input logic [31:0] B;
    output logic [63:0] S;

    // ab * cd = (a+b) * (c+d) = ac << 4 + ad << 2 + bc << 2 + bd << 0;
    // a = A[3:2]
    // b = A[1:0]
    // c = B[3:2]
    // d = B[1:0]
    logic [31:0] ac, ad, bc, bd;
    logic [63:0] tempAC, tempAD, tempBC, tempBD;

    multiplier16 mult1(A[31:16], B[31:16], ac);
    multiplier16 mult2(A[31:16], B[15:0], ad);
    multiplier16 mult3(A[15:0], B[31:16], bc);
    multiplier16 mult4(A[15:0], B[15:0], bd);

    assign tempAC[63:32] = ac;
    assign tempAC[31:0] = 32'b0;

    assign tempAD[63:48] = 16'b0;
    assign tempAD[47:16] = ad;
    assign tempAD[15:0] = 16'b0;

    assign tempBC[63:48] = 16'b0;
    assign tempBC[47:16] = bc;
    assign tempBC[15:0] = 16'b0;

    assign tempBD[63:32] = 32'b0;
    assign tempBD[31:0] = bd;

    logic [63:0] tempOut1, tempOut2, tempOut;
    wire null1, null2, null3;

    adder64 add1(tempAC, tempBD, 1'b0, tempOut1, null1);
    adder64 add2(tempAD, tempBC, 1'b0, tempOut2, null2);
    adder64 add3(tempOut1, tempOut2, 1'b0, tempOut, null3);

    assign S = tempOut;

endmodule

module multiplier64(A, B, S);
    input logic [63:0] A;
    input logic [63:0] B;
    output logic [127:0] S;

    // ab * cd = (a+b) * (c+d) = ac << 4 + ad << 2 + bc << 2 + bd << 0;
    // a = A[3:2]
    // b = A[1:0]
    // c = B[3:2]
    // d = B[1:0]
    logic [63:0] ac, ad, bc, bd;
    logic [127:0] tempAC, tempAD, tempBC, tempBD;

    multiplier32 mult1(A[63:32], B[63:32], ac);
    multiplier32 mult2(A[63:32], B[31:0], ad);
    multiplier32 mult3(A[31:0], B[63:32], bc);
    multiplier32 mult4(A[31:0], B[31:0], bd);

    assign tempAC[127:64] = ac;
    assign tempAC[63:0] = 64'b0;

    assign tempAD[127:96] = 32'b0;
    assign tempAD[95:32] = ad;
    assign tempAD[31:0] = 32'b0;

    assign tempBC[127:96] = 32'b0;
    assign tempBC[95:32] = bc;
    assign tempBC[31:0] = 32'b0;

    assign tempBD[127:64] = 64'b0;
    assign tempBD[63:0] = bd;

    logic [127:0] tempOut1, tempOut2, tempOut;
    wire null1, null2, null3;

    adder128 add1(tempAC, tempBD, 1'b0, tempOut1, null1);
    adder128 add2(tempAD, tempBC, 1'b0, tempOut2, null2);
    adder128 add3(tempOut1, tempOut2, 1'b0, tempOut, null3);

    assign S = tempOut;

endmodule

module equation(A, B, C, Z);
    input logic [63:0] A;
    input logic [63:0] B;
    input logic [127:0] C;
    output logic [127:0] Z;

    logic [127:0] temp;
    wire null1;
    
    multiplier64 mult(A, B, temp);
    adder128 add(temp, C, 1'b0, Z, null1);
endmodule

module subtractor#(parameter N=128)(A, B, Y);
    input logic [N-1:0] A, B;
    output logic [N-1:0] Y;

    assign Y = A - B;
endmodule


//overflow not addressed
//used when different signs
module signedSubtraction #(parameter N=4)(A,B,S);
    input logic [N-1:0] A;
    input logic [N-1:0] B;
    output logic [N-1:0] S;

    logic signA, signB, Cout;
    logic [N-1:0] tempA, tempB, tempOut, out;

    assign signA = A[N-1];
    assign signB = B[N-1];

    always_comb begin
        case(signA)
            0: tempA = A;
            1: tempA = ~A + 1'b1;
        endcase
        case(signB)
            0: tempB = B;
            1: tempB = ~B + 1'b1;
        endcase
    end

    assign {Cout, tempOut} = tempA + tempB;

    always_comb begin
        case(Cout)
            0: out = ~tempOut + 1'b1;
            1: out = tempOut;
        endcase
    end
    
    assign S = out;
endmodule

module signedAddition (A,B,S);
    parameter N = 4;
    input logic [N-1:0] A;
    input logic [N-1:0] B;
    output logic [N-1:0] S;

    logic signA, signB, signS, tempMagCarry;
    logic [N-1:0] tempA, tempB, tempOut;
    logic [N-2:0] magA, magB, tempMagA, tempMagB, tempMagOut;

    // caseNum indicates the 4 different combinations of pos and neg
    // 0: pos + pos
    // 1: pos > neg
    // 2: pos < neg
    // 3: neg + neg
    logic [1:0] caseNum;

    assign signA = A[N-1];
    assign magA = A[N-2:0];
    assign signB = B[N-1];
    assign magB = B[N-2:0];

    always_comb begin
        caseNum = 2'bxx;

        case(signA)
            0: tempMagA = magA;
            1: tempMagA = ~magA + 1'b1;
        endcase
        case(signB)
            0: tempMagB = magB;
            1: tempMagB = ~magB + 1'b1;
        endcase

        if (signA == 1'b0) begin
            if (signB == 1'b1) begin
                if (magA >= magB) begin
                    caseNum = 2'b01;
                end else if (magB > magA) begin
                    caseNum = 2'b10;
                end
            end else if (signB == 1'b0) begin
                caseNum = 2'b00;
            end
        end else if (signA == 1'b1) begin
            if (signB == 1'b1) begin
                caseNum = 2'b11;
            end else if (signB == 1'b0) begin
                if (magA <= magB) begin
                    caseNum = 2'b01;
                end else if (magB < magA) begin
                    caseNum = 2'b10;
                end 
            end
        end
    end

    assign {tempMagCarry, tempMagOut} = tempMagA + tempMagB;

    always_comb begin
        case(caseNum)
            0: signS = 1'b0;
            1: signS = 1'b0;
            2: signS = 1'b1;
            3: signS = 1'b1;
        endcase

        case(signS)
            0: tempOut[N-2:0] = tempMagOut;
            1: tempOut[N-2:0] = ~tempMagOut + 1'b1;
        endcase

        tempOut [N-1] = signS;
    end

    assign S = tempOut;
endmodule