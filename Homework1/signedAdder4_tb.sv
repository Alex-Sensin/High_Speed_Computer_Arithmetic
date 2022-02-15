module stimulus();
    logic [3:0] A;
    logic [3:0] B;
    logic [3:0] S;

    integer handle;
    integer desc;

    signedAddition dut(.A(A), .B(B), .S(S));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\n", S);
    end

    //adding zeros
    initial begin
        #5 A = 4'b0;
        #0 B = 4'b0;
    end

    //case 0
    initial begin
        #10 A = 4'b0101;
        #0 B = 4'b0001;
    end

    //case 1
    initial begin
        #15 A = 4'b0011;
        #0 B = 4'b1010;
    end

    //case 2
    initial begin
        #20 A = 4'b1100;
        #0 B = 4'b0011;
    end

    //case 3
    initial begin
        #25 A = 4'b1010;
        #0 B = 4'b1011;
    end
endmodule