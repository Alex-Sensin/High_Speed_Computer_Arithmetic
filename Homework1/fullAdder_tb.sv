module stimulus();
    logic Cin;
    logic A;
    logic B;
    logic S;
    logic Cout;

    integer handle;
    integer desc;

    fullAdder dut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nCout: %b", S, Cout);
    end

    initial begin
        #5 A = 1'b0;
        #0 B = 1'b0;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 1'b1;
        #0 B = 1'b1;
        #0 Cin = 1'b0;
    end

    initial begin
        #15 A = 1'b1;
        #0 B = 1'b0;
        #0 Cin = 1'b1;
    end

    initial begin
        #20 A = 1'b1;
        #0 B = 1'b1;
        #0 Cin = 1'b1;
    end

    initial begin
        #25 A = 1'b1;
        #0 B = 1'b0;
        #0 Cin = 1'b0;
    end
endmodule