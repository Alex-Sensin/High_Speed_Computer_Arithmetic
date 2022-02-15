module stimulus();
    logic [3:0] A;
    logic [3:0] B;
    logic Cin;
    logic [3:0] S;
    logic Pout;
    logic Gout;

    integer handle;
    integer desc;

    BCLG4 dut(.A(A), .B(B), .Cin(Cin), .S(S), .Gout(Gout), .Pout(Pout));
    
    initial begin
        handle = $fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nPout: %b\nGout: ", S, Pout, Gout);
    end

    initial begin
        #5 A = 4'b0000;
        #0 B = 4'b0000;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 4'b1111;
        #0 B = 4'b0000;
        #0 Cin = 1'b0;
    end

    initial begin
        #15 A = 4'b0101;
        #0 B = 4'b1010;
        #0 Cin = 1'b0;
    end

    initial begin
        #20 A = 4'b1111;
        #0 B = 4'b1111;
        #0 Cin = 1'b1;
    end

    initial begin
        #25 A = 4'b0011;
        #0 B = 4'b1101;
        #0 Cin = 1'b0;
    end

endmodule