module stimulus();
    logic [15:0] A;
    logic [15:0] B;
    logic Cin;
    logic [15:0] S;
    logic Cout;

    integer handle;
    integer desc;

    adder16 dut(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial begin
        handle =$fopen("test.out");

    end

    always begin
        desc = handle;
        #5 $fdisplay(desc, "S: %b\nCout: %b", S, Cout);
    end

    initial begin
        #5 A = 16'b0;
        #0 B = 16'b0;
        #0 Cin = 1'b0;
    end

    initial begin
        #10 A = 16'b1110_0011_0100_1101;
        #0 B = 16'b1101_0110_1101_1001;
        #0 Cin = 1'b0;
    end

    initial begin
        #15 A = 16'b1111_1111_1111_1111;
        #0 B = 16'b1111_1111_1111_1111;
        #0 Cin = 1'b1;
    end

    initial begin
        #20 A = 16'b0000_0110_1011_1111;
        #0 B = 16'b0010_1101_1101_0010;
        #0 Cin = 1'b1;
    end
endmodule