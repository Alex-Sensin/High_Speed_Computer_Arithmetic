module stimulus();
    logic A;
    logic B;
    logic Cin;
    logic S;
    logic P;
    logic G;

    integer handle;
    integer desc;

    RFA dut(.A(A), .B(B), .Cin(Cin), .S(S), .P(P), .G(G));
    
    initial begin
        handle = $fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nP: %b\nG: ", S, P, G);
    end

    initial begin
        #5 A = 1'b0;
        #0 B = 1'b0;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 1'b0;
        #0 B = 1'b0;
        #0 Cin = 1'b1;
    end

    initial begin
        #15 A = 1'b0;
        #0 B = 1'b1;
        #0 Cin = 1'b0;
    end

    initial begin
        #20 A = 1'b0;
        #0 B = 1'b1;
        #0 Cin = 1'b1;
    end

    initial begin
        #25 A = 1'b1;
        #0 B = 1'b0;
        #0 Cin = 1'b0;
    end

    initial begin
        #30 A = 1'b1;
        #0 B = 1'b0;
        #0 Cin = 1'b1;
    end

    initial begin
        #35 A = 1'b1;
        #0 B = 1'b1;
        #0 Cin = 1'b0;
    end

    initial begin
        #40 A = 1'b1;
        #0 B = 1'b1;
        #0 Cin = 1'b1;
    end

endmodule