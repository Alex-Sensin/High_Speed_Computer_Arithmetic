module equation(A, B, C, Z);
    parameter N = 64;
    parameter M = 2 * N;
    input logic [N-1:0] A, B;
    input logic [M-1:0] C;
    output logic [M-1:0] Z;

    assign Z = A * B + C;
endmodule

module signedEquation(A, B, C, Z);
    parameter N = 4;
    parameter M = 2 * N;
    input logic [N-1:0] A, B;
    input logic [M-1:0] C;
    output logic [M-1:0] Z;

    logic [M-1:0] temp;

    signedMultiply mult(A, B, temp);
    signedAddition add(temp, C, Z);
endmodule

module signedAddition (A, B, S);
    parameter N = 8;
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

module signedMultiply(A, B, S);
    parameter N = 4;
    parameter M = 2 * N;
    input logic [N-1:0] A;
    input logic [N-1:0] B;
    output logic [M-1:0] S;

    assign S[M-1] = A[N-1] ^ B[N-1];
    assign S[M-2:0] = A[N-2:0] * B[N-2:0];
endmodule