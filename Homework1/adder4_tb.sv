module stimulus();
    logic [3:0] A;
    logic [3:0] B;
    logic Cin;
    logic [3:0] S;
    logic Cout;

    integer handle;
    integer desc;

    adder4 dut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nCout: %b", S, Cout);
    end

    initial begin
        #5 A = 4'b0;
        #0 B = 4'b0;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 4'b0011;
        #0 B = 4'b1101;
        #0 Cin = 1'b0;
    end

    initial begin
        #15 A = 4'b1111;
        #0 B = 4'b1111;
        #0 Cin = 1'b1;
    end

    initial begin
        #20 A = 4'b1001;
        #0 B = 4'b0101;
        #0 Cin = 1'b1;
    end
endmodule