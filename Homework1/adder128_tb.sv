module stimulus();
    logic [127:0] A;
    logic [127:0] B;
    logic Cin;
    logic [127:0] S;
    logic Cout;

    integer handle;
    integer desc;

    adder128 dut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nCout: %b", S, Cout);
    end

    initial begin
        #5 A = 128'h0;
        #0 B = 128'h0;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 128'h06662dc00efbb59528634381fa7b52c6;
        #0 B = 128'h0;
        #0 Cin = 1'b0;
    end

    initial begin
        #15 A = 128'h5e6bfa1f6d60980123d407904aebffe4;
        #0 B = 128'h4aa5b502b4fddf6c7f22db6347e7cd55;
        #0 Cin = 1'b0;
    end

    initial begin
        #20 A = 128'h948f1a047f82ec9c6e3ee0060a9bd2e6;
        #0 B = 128'h35fe7c5550ca6c903038b2bff783e56e;
        #0 Cin = 1'b1;
    end

    initial begin
        #25 A = 128'hffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff;
        #0 B = 128'hffff_ffff_ffff_ffff_ffff_ffff_ffff_ffff;
        #0 Cin = 1'b1;
    end

endmodule