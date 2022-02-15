module stimulus();
    logic [15:0] A;
    logic [15:0] B;
    logic Cin;
    logic [15:0] S;
    logic Cout;


    integer handle;
    integer desc;

    BKA dut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
        handle = $fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nCout: ", S, Cout);
    end

    initial begin
        #5 A = 16'h0;
        #0 B = 16'h0;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 16'hffff;
        #0 B = 16'h0;
        #0 Cin = 1'b0;
    end

    initial begin
        #15 A = 16'haaaa;
        #0 B = 16'h5555;
        #0 Cin = 1'b0;
    end

    initial begin
        #20 A = 16'h5555;
        #0 B = 16'haaa9;
        #0 Cin = 1'b1;
    end

    initial begin
        #25 A = 16'hffff;
        #0 B = 16'hffff;
        #0 Cin = 1'b1;
    end

    initial begin
        #30 A = 16'haaaa;
        #0 B = 16'h5555;
        #0 Cin = 1'b1;
    end

endmodule