module stimulus();
    logic [31:0] A;
    logic [31:0] B;
    logic [63:0] S;

    integer handle;
    integer desc;

    multiplier32 dut(.A(A), .B(B), .S(S));

    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\n", S);
    end

    initial begin
        #5 A = 32'h0;
        #0 B = 32'h0;
    end

    initial begin
        #10 A = 32'hfe768e7a;
        #0 B = 32'h0;
    end

    initial begin
        #15 A = 32'h1a86615d;
        #0 B = 32'h1;
    end

    initial begin
        #20 A = 32'hae9b7ccb;
        #0 B = 32'hd52749c0;
    end

    initial begin
        #25 A = 32'hffff_ffff;
        #0 B = 32'hffff_ffff;
    end
endmodule