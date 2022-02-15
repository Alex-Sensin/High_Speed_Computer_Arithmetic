module stimulus();
    logic [30:0] A;
    logic [30:0] B;
    logic Cin;
    logic [30:0] S;

    integer handle;
    integer desc;

    BCLG4_Teir3 dut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
        handle = $fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nCout: ", S, Cout);
    end

    initial begin
        #5 A = 31'h0;
        #0 B = 31'h0;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 31'h7fff_ffff;
        #0 B = 31'h0;
        #0 Cin = 1'b0;
    end

    initial begin
        #15 A = 31'h2aaa_aaaa;
        #0 B = 31'h5555_5555;
        #0 Cin = 1'b0;
    end

    initial begin
        #20 A = 31'h5555_5555;
        #0 B = 31'h2aaa_aaa9;
        #0 Cin = 1'b1;
    end

    initial begin
        #25 A = 31'h7fff_ffff;
        #0 B = 31'h7fff_ffff;
        #0 Cin = 1'b1;
    end

    initial begin
        #30 A = 31'h2aaa_aaaa;
        #0 B = 31'h5555_5555;
        #0 Cin = 1'b1;
    end

endmodule