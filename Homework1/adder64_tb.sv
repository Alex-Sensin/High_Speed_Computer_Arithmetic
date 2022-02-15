module stimulus();
    logic [63:0] A;
    logic [63:0] B;
    logic Cin;
    logic [63:0] S;
    logic Cout;

    integer handle;
    integer desc;

    adder64 dut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nCout: %b", S, Cout);
    end

    // test numbers were randomly generated in hex
    // then a calculator was used to check values

    initial begin
        #5 A = 64'h0;
        #0 B = 64'h0;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 64'h7234e99470421ba6;
        #0 B = 64'h8a5e583072661ea4;
        #0 Cin = 1'b0;
    end

    initial begin
        #15 A = 64'hfdf1319d2dcd03c8;
        #0 B = 64'hb68ec2526eb44f9c;
        #0 Cin = 1'b1;
    end

    initial begin
        #20 A = 64'h1401fda05bd07de5;
        #0 B = 64'h17ad57a3a66bd673;
        #0 Cin = 1'b1;
    end

    initial begin
        #25 A = 64'hffff_ffff_ffff_ffff;
        #0 B = 64'hffff_ffff_ffff_ffff;
        #0 Cin = 1'b1;
    end

endmodule