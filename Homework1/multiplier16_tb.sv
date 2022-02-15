module stimulus();
    logic [15:0] A;
    logic [15:0] B;
    logic [31:0] S;

    integer handle;
    integer desc;

    multiplier16 dut(.A(A), .B(B), .S(S));

    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\n", S);
    end

    initial begin
        #5 A = 16'h0;
        #0 B = 16'h0;
    end

    initial begin
        #10 A = 16'hadfe;
        #0 B = 16'h0;
    end

    initial begin
        #15 A = 16'hc02f;
        #0 B = 16'h1;
    end

    initial begin
        #20 A = 16'hd6b7;
        #0 B = 16'h6150;
    end

    initial begin
        #25 A = 16'hffff;
        #0 B = 16'hffff;
    end
endmodule