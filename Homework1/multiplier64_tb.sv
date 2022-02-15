module stimulus();
    logic [63:0] A;
    logic [63:0] B;
    logic [127:0] S;

    integer handle;
    integer desc;

    multiplier64 dut(.A(A), .B(B), .S(S));

    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\n", S);
    end

    initial begin
        #5 A = 64'h0;
        #0 B = 64'h0;
    end

    initial begin
        #10 A = 64'h4f704b31d58f02dd;
        #0 B = 64'h0;
    end

    initial begin
        #15 A = 64'hc04a141011a31c0b;
        #0 B = 64'h1;
    end

    initial begin
        #20 A = 64'h750374286c58462a;
        #0 B = 64'hdcdf7b83db0a62f1;
    end

    initial begin
        #25 A = 64'hffff_ffff_ffff_ffff;
        #0 B = 64'hffff_ffff_ffff_ffff;
    end
endmodule